# @version ^0.3.2

"""
@title Token with Meta Transaction Support
@author jtriley.eth
"""

from vyper.interfaces import ERC20

implements: ERC20

event Transfer:
    sender: indexed(address)
    receiver: indexed(address)
    amount: uint256

event Approval:
    owner: indexed(address)
    spender: indexed(address)
    amount: uint256

name: public(String[32])

symbol: public(String[32])

decimals: public(uint8)

totalSupply: public(uint256)

balanceOf: public(HashMap[address, uint256])

allowance: public(HashMap[address, HashMap[address, uint256]])

nonce: public(uint256)

@external
def __init__(name: String[32], symbol: String[32], initial_supply: uint256):
    self.name = name
    self.symbol = symbol
    self.decimals = 18
    self.balanceOf[msg.sender] = initial_supply
    self.totalSupply = initial_supply


@external
def transfer(receiver: address, amount: uint256) -> bool:
    assert receiver != ZERO_ADDRESS, "zero address receiver"
    self.balanceOf[msg.sender] -= amount
    self.balanceOf[receiver] = unsafe_add(self.balanceOf[receiver], amount)
    log Transfer(msg.sender, receiver, amount)
    return True


@external
def approve(spender: address, amount: uint256) -> bool:
    self.allowance[msg.sender][spender] = amount
    log Approval(msg.sender, spender, amount)
    return True


@external
def transferFrom(sender: address, receiver: address, amount: uint256) -> bool:
    if (msg.sender != sender):
        self.allowance[sender][msg.sender] -= amount
    self.balanceOf[sender] -= amount
    self.balanceOf[receiver] = unsafe_add(self.balanceOf[receiver], amount)
    log Transfer(sender, receiver, amount)
    return True


@external
def metaTransfer(
    sender: address,
    receiver: address,
    amount: uint256,
    v: uint256,
    r: uint256,
    s: uint256
) -> bool:
    """
    @notice Transfers `amount` on `sender`'s behalf to `receiver`. Transfer is authenticated with an
    offchain EC digital signature. Signature components `v`, `r`, and `s` can be generated using
    client libraries are passed to `ecrecover` builtin. If `sender` does not match the recovered
    signer, the signature is invalid. A nonce is added to protect against replay attacks.
    @param sender Address from which to transfer.
    @param receiver Address to which to transfer.
    @param amount Amount to transfer.
    @param v Recovery component of ECDSA.
    @param r ECDSA 'R' coordinate.
    @param s ECDSA 'S' coordinate.
    """
    hash: bytes32 = keccak256(
        concat(
            convert(sender, bytes32),
            convert(receiver, bytes32),
            convert(amount, bytes32),
            convert(self.nonce, bytes32)
        )
    )

    message: bytes32 = keccak256(
        concat(
            b"\x19Ethereum Signed Message:\n32",
            hash
        )
    )

    signer: address = ecrecover(message, v, r, s)
    assert signer == sender, "invalid sender"

    self.balanceOf[sender] -= amount
    self.balanceOf[receiver] = unsafe_add(self.balanceOf[receiver], amount)

    return True
