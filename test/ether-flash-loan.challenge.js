const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('[ETHER FLASH LOAN EXPLOIT]', async function () {
    let deployer, attacker

    const INITIAL_BALANCE = ethers.utils.parseEther('2')

    before(async function () {
        // SET UP
        ;[deployer, attacker] = await ethers.getSigners()

        this.etherFlashLoan = await (
            await ethers.getContractFactory('EtherFlashLoan', deployer)
        ).deploy()

        await this.etherFlashLoan.deposit({ value: INITIAL_BALANCE })

        expect(
            await ethers.provider.getBalance(this.etherFlashLoan.address)
        ).to.be.equal(INITIAL_BALANCE)
    })

    it('Exploit', async function () {
        // YOUR EXPLOIT HERE

    })

    after(async function () {
        // SUCCESS CONDITIONS
        expect(await ethers.provider.getBalance(this.etherFlashLoan.address)).to.be.equal('0')
    })
})
