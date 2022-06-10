const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('[ETHER VAULT EXPLOIT]', async function () {
    let deployer, attacker

    const VAULT_BALANCE = ethers.utils.parseEther('100')

    before(async function () {
        // SET UP
        ;[deployer, attacker, alice] = await ethers.getSigners()

        this.vault = await (await ethers.getContractFactory('EtherVault', deployer)).deploy()

        await deployer.sendTransaction({ to: this.vault.address, value: VAULT_BALANCE })
    })

    it('Exploit', async function () {
        // YOUR EXPLOIT HERE

    })

    after(async function () {
        // SUCCESS CONDITIONS
        expect(await ethers.provider.getBalance(this.vault.address)).to.be.equal('0')
    })
})
