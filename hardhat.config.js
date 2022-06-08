require('@nomiclabs/hardhat-ethers')
require('@nomiclabs/hardhat-waffle')
require('@nomiclabs/hardhat-vyper')

module.exports = {
    defaultNetwork: 'hardhat',
    networks: {
        hardhat: {},
    },
    vyper: {
        version: '0.3.3'
    },
    mocha: {
        timeout: 30000
    }
}
