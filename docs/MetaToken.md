# Meta Tx

## Overview

The Meta Tx contract is an ERC20 token with a builtin meta-transaction-based transfer.
Another user has graciously made a meta-transfer to your account.
Your objective is to drain their entire balance.

## Contracts in Scope

[MetaToken.vy](../contracts/meta-token/MetaToken.vy)

## Exploit Contract

[MetaTokenExploit.vy](../contracts/exploits/MetaTokenExploit.vy)

## Proof of Concept Script

[meta-token.challenge.js](../test/meta-token.challenge.js)

## Execute Test

```bash
yarn test:meta-token
```

Good Hacking.
