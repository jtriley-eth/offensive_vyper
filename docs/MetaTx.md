# Meta Tx

## Overview

The Meta Tx contract is an ERC20 token with a builtin meta-transaction-based transfer.
Another user has graciously made a meta-transfer to your account.
Your objective is to drain their entire balance.

## Contracts in Scope

[MetaTx.vy](../contracts/meta-tx/MetaTx.vy)

## Exploit Contract

[MetaTxExploit.vy](../contracts/exploits/MetaTxExploit.vy)

## Proof of Concept Script

[meta-tx.challenge.js](../test/meta-tx.challenge.js)

## Execute Test

```bash
yarn test:meta-tx
```

Good Hacking.
