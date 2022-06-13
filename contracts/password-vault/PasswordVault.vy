# @version ^0.3.2

"""
@title Password Protected Vault
@author jtriley.eth
"""

password_hash: bytes32

owner: address

@external
def __init__(password_hash: bytes32):
    self.password_hash = password_hash

    self.owner = msg.sender


@external
def set_new_password(old_password_hash: bytes32, new_password_hash: bytes32):
    """
    @notice Sets a new password hash. Passwords are hashed offchain for security.
    @param old_password_hash Last password hash for authentication.
    @param new_password_hash New password hash to set.
    @dev Throws when password is invalid and the caller is not the owner.
    """

    assert self.password_hash == old_password_hash or msg.sender == self.owner, "unauthorized"
    
    self.password_hash = new_password_hash


@external
def withdraw(password_hash: bytes32):
    """
    @notice Withdraws funds from vault.
    @param password_hash Password hash for authentication.
    @dev Throws when password hash is invalid and the caller is not the owner.
    """

    assert self.password_hash == password_hash or msg.sender == self.owner, "unauthorized"

    send(msg.sender, self.balance)


@external
@payable
def __default__():
    pass

