const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('[OWNABLE PROXY EXPLOIT]', async function () {
    let deployer, attacker

    const INITIAL_BALANCE = ethers.utils.parseEther('2')

    before(async function () {
        // SET UP
        ;[deployer, attacker] = await ethers.getSigners()

        this.ownableProxy = await (
            await ethers.getContractFactory('OwnableProxy', deployer)
        ).deploy()

        await deployer.sendTransaction({ to: this.ownableProxy.address, value: INITIAL_BALANCE })
    })

    it('Exploit', async function () {
        // YOUR EXPLOIT HERE

    })

    after(async function () {
        // SUCCESS CONDITIONS
        expect(await this.ownableProxy.owner()).to.be.equal(attacker.address)
        expect(await ethers.provider.getBalance(this.ownableProxy.address)).to.be.equal('0')
    })
})
