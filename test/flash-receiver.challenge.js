const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('[FLASH RECEIVER EXPLOIT]', async function () {
    let deployer, attacker

    const INITIAL_SUPPLY = ethers.utils.parseEther('200')
    const INITIAL_BALANCE = ethers.utils.parseEther('100')

    before(async function () {
        // SET UP
        ;[deployer, attacker] = await ethers.getSigners()

        this.token = await (
            await ethers.getContractFactory('ERC20', deployer)
        ).deploy('Vyper Coin', 'VyCn', INITIAL_SUPPLY)

        this.pool = await (
            await ethers.getContractFactory('FlashPool', deployer)
        ).deploy(this.token.address)

        this.receiver = await (
            await ethers.getContractFactory('FlashReceiver', deployer)
        ).deploy(this.token.address, this.pool.address)

        await this.token.transfer(this.pool.address, INITIAL_BALANCE)

        await this.token.transfer(this.receiver.address, INITIAL_BALANCE)

        expect(await this.token.balanceOf(this.pool.address)).to.be.equal(INITIAL_BALANCE)

        expect(await this.token.balanceOf(this.receiver.address)).to.be.equal(INITIAL_BALANCE)
    })

    it('Exploit', async function () {
        // YOUR EXPLOIT HERE

    })

    after(async function () {
        // SUCCESS CONDITIONS
        expect(await this.token.balanceOf(this.receiver.address)).to.be.equal('0')
    })
})
