# Flash Receiver

## Overview

The Flash Receiver contract is a receiver of an ERC20-based flash loan pool.
The Flash Pool contract is the ERC20-based flash loan contract.
There is a flash fee of ten tokens for each flash loan.
Your objective is to drain the Flash Receiver contract.

## Contracts in Scope

[FlashReceiver.vy](../contracts/flash-receiver/FlashReceiver.vy)

[FlashPool.vy](../contracts/flash-receiver/FlashPool.vy)

## Exploit Contract

[FlashReceiverExploit.vy](../contracts/exploits/FlashReceiverExploit.vy)

## Proof of Concept Script

[flash-receiver.challenge.js](../test/flash-receiver.challenge.js)

Good Hacking.
