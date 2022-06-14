# Offensive Vyper

## Introduction

Offensive Vyper is a Vyper-based Capture the Flag.
All contracts are written in Vyper and all exploits should be written in Vyper.

The development environment is Hardhat using Ethers.js as the client library.
The Hardhat environment includes a Vyper plugin for contract compilation and testing.

## Getting Started

To get started, clone this repository.

```bash
git clone https://github.com/JoshuaTrujillo15/offensive_vyper.git
```

Then install dependencies. You will need `node`, `npm`, and optionally, `yarn`.

```bash
# if using yarn
yarn

# if using npm
npm i
```

To begin a challenge, follow the links under **Challenges**.
This will lead you to an overview, the contracts in scope, the exploit contract, and the test.

To write an exploit, use the corresponding Vyper contract in `./contracts/exploits`.

To test your exploit, edit the Javascript test file and in the
`YOUR EXPLOIT HERE` section, then use the respective command in the
**Challenge** file.

## Challenges

0. [Password Vault](./docs/PasswordVault.md)

1. [Unstoppable Auction](./docs/UnstoppableAuction.md)

2. [Coin Flipper](./docs/CoinFlipper.md)

3. [Ether Vault](./docs/EtherVault.md)

4. [Ether Flash Loan](./docs/EtherFlashLoan.md)

5. [Flash Receiver](./docs/FlashReceiver.md)

6. [Ownable Proxy](./docs/OwnableProxy.md)

7. [Meta Token](./docs/MetaToken.md)
