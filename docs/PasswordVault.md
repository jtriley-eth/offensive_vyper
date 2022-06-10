# Password Vault

## Overview

The Password Vault is a vault that holds Ether and is password protected.
Your Objective is to steal all of the Ether in the Vault.
While the password is stored in this repository, the objective is to do it
without reading the password from `test/secrets/dont-peek.js`.

## Contracts in Scope

[PasswordVault.vy](../contracts/password-vault/PasswordVault.vy)

## Exploit Contract

[PasswordVaultExploit.vy](../contracts/exploits/PasswordVaultExploit.vy)

## Proof of Concept Script

[password-vault.challenge.js](../test/password-vault.challenge.js)

## Execute Test

```bash
yarn test:password-vault
```

Good Hacking.
