# @version ^0.3.2

"""
@title Flash Loan Receiver Supporting ERC20 Token
@author jtriley.eth
"""

from vyper.interfaces import ERC20

interface Flash_pool:
    def deposit(amount: uint256): nonpayable
    def withdraw(amount: uint256): nonpayable
    def flash_loan(amount: uint256): nonpayable
    def deposits(arg0: address) -> uint256: view
    def token() -> address: view
    def flash_fee() -> uint256: view

token: public(address)

pool: public(address)


@external
def __init__(token: address, pool: address):
    self.token = token


@internal
def _execute_action(amount: uint256):
    pass


@external
def execute():
    """
    @notice Receives flash loan, executes action, then pays back the flash loan + the fee
    @dev Reverts when caller is not the pool itself.
    """
    assert msg.sender == self.pool, "invalid caller"
    amount: uint256 = ERC20(self.token).balanceOf(self)
    self._execute_action(amount)
    fee: uint256 = Flash_pool(self.pool).flash_fee()
    ERC20(self.token).transfer(self.pool, amount + fee)


@external
def initiate_flash_loan(amount: uint256):
    """
    @notice Initiates flash loan from the pool.
    
    Receiver.initiate_flash_loan -> Pool.flash_loan -> Receiver.execute
    """
    Flash_pool(self.pool).flash_loan(amount)
