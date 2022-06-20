# Coin Flipper

## Overview

The Coin Flipper is a true/false coin-toss with a 50% chance of either.
It costs one Ether to play, but pays two Ether on a correct guess.
On a long enough timescale, players are expected to break even.
Your objective is to not break even; drain all ten Ether from the contract.

## Contracts in Scope

[CoinFlipper.vy](../contracts/coin-flipper/CoinFlipper.vy)

[RandomNumber.vy](../contracts/coin-flipper/RandomNumber.vy)

## Exploit Contract

[CoinFlipperExploit.vy](../contracts/exploits/CoinFlipperExploit.vy)

## Proof of Concept Script

[coin-flipper.challenge.js](../test/coin-flipper.challenge.js)

## Execute Test

```bash
yarn test:coin-flipper
```

Good Hacking.
