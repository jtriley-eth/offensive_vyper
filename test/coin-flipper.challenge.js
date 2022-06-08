const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('[COIN FLIPPER EXPLOIT]', async function () {
    let deployer, attacker

    const INITIAL_BALANCE = ethers.utils.parseEther('2')

    before(async function () {
        // SET UP
        ;[deployer, attacker] = await ethers.getSigners()

        this.rng = await (await ethers.getContractFactory('RandomNumber', deployer)).deploy()
        this.coinFlipper = await (await ethers.getContractFactory('CoinFlipper', deployer)).deploy(
            this.rng.address,
            { value: INITIAL_BALANCE }
        )

        expect(
            await ethers.provider.getBalance(this.coinFlipper.address)
        ).to.equal(INITIAL_BALANCE)
    })

    it('Exploit', async function () {
        // YOUR EXPLOIT HERE

    })

    after(async function () {
        // SUCCESS CONDITIONS
        expect(await ethers.provider.getBalance(this.coinFlipper.address)).to.be.equal('0')
    })
})
