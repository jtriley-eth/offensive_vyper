const { expect } = require('chai')
const { ethers } = require('hardhat')

function generateMessageHash(sender, receiver, amount, nonce) {
    return ethers.utils.keccak256(
        new ethers.utils.AbiCoder().encode(
            ['address', 'address', 'uint256', 'uint256'],
            [sender, receiver, amount, nonce]
        )
    )
}

describe('[META TX EXPLOIT]', async function () {
    let deployer, attacker

    const INITIAL_BALANCE = ethers.utils.parseEther('10')
    const TRANSFER_AMOUNT = ethers.utils.parseEther('1')

    before(async function () {
        // SET UP
        ;[deployer, attacker, alice] = await ethers.getSigners()

        this.token = await (
            await ethers.getContractFactory('Token', deployer)
        ).deploy("Meta Token", "Meta", INITIAL_BALANCE)

        await this.token.transfer(alice, INITIAL_BALANCE)

        const nonce = await this.token.nonce()

        this.metaTransaction = {
            sender: alice.address,
            receiver: attacker.address,
            amount: ethers.utils.parseEther('1').toString(),
            nonce: nonce.toString()
        }

        const messageHash = generateMessageHash(
            alice.address,
            attacker.address,
            ethers.utils.parseEther('1').toString(),
            nonce.toString()
        )

        this.signature = await alice.signMessage(messageHash)
    })

    it('Exploit', async function () {
        // YOUR EXPLOIT HERE
        console.log(this.signature)
    })

    after(async function () {
        // SUCCESS CONDITIONS
        expect(await token.balanceOf(alice.address)).to.be.equal('0')
    })
})
