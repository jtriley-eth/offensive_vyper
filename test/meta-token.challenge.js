const { expect } = require('chai')
const { ethers } = require('hardhat')

function generateMessageHash(sender, receiver, amount, nonce) {
    const message = new ethers.utils.AbiCoder().encode(
        ['address', 'address', 'uint256', 'uint256'],
        [sender, receiver, amount, nonce]
    )
    return ethers.utils.keccak256(message)
}

describe('[META TOKEN EXPLOIT]', async function () {
    let deployer, attacker

    const INITIAL_BALANCE = ethers.utils.parseEther('100')
    const TRANSFER_AMOUNT = ethers.utils.parseEther('10')

    before(async function () {
        // SET UP
        ;[deployer, attacker, alice] = await ethers.getSigners()

        this.token = await (
            await ethers.getContractFactory('MetaToken', deployer)
        ).deploy("Meta Token", "Meta", INITIAL_BALANCE)

        await this.token.transfer(alice.address, INITIAL_BALANCE)

        const nonce = await this.token.nonce()

        const messageHash = generateMessageHash(
            alice.address,
            attacker.address,
            TRANSFER_AMOUNT,
            nonce.toString()
        )

        this.signature = ethers.utils.splitSignature(
            await alice.signMessage(ethers.utils.arrayify(messageHash))
        )

        await this.token.metaTransfer(
            alice.address,
            attacker.address,
            TRANSFER_AMOUNT,
            this.signature.v,
            this.signature.r,
            this.signature.s
        )

        expect(
            await this.token.balanceOf(alice.address)
        ).to.be.equal(INITIAL_BALANCE.sub(TRANSFER_AMOUNT))
    })

    it('Exploit', async function () {
        // YOUR EXPLOIT HERE

    })

    after(async function () {
        // SUCCESS CONDITIONS
        expect(await this.token.balanceOf(alice.address)).to.be.equal('0')
    })
})
