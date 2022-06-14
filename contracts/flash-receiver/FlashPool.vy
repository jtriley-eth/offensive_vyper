# @version ^0.3.2

"""
@title Flash Loan Pool Supporting ERC20 Token
@author jtriley.eth
"""

from vyper.interfaces import ERC20

interface IFlashLoanReceiver:
    def execute(amount: uint256): nonpayable


event Deposit:
    account: indexed(address)
    amount: uint256


event Withdrawal:
    account: indexed(address)
    amount: uint256


deposits: public(HashMap[address, uint256])


flash_fee: public(uint256)


token: public(address)


@external
def __init__(token: address):
    self.token = token
    self.flash_fee = 10000000000000000000


@external
def deposit(amount: uint256):
    """
    @notice Deposits ERC20 token.
    @param amount Amount to deposit.
    @dev Reverts when balance or approval of ERC20 is insufficient.
    """
    ERC20(self.token).transferFrom(msg.sender, self, amount)
    self.deposits[msg.sender] += amount
    log Deposit(msg.sender, amount)


@external
def withdraw(amount: uint256):
    """
    @notice Withdraws ERC20 token.
    @param amount Amount to withdraw.
    @dev Reverts when deposit amount is insufficient.
    """
    self.deposits[msg.sender] -= amount
    ERC20(self.token).transferFrom(self, msg.sender, amount)
    log Withdrawal(msg.sender, amount)


@external
def flash_loan(amount: uint256):
    """
    @notice Executes a flash loan, expects the token to be transferred back before completion.
    @param amount Amount to flash loan.
    @dev Reverts when insufficient balance OR when the amount + flash fee is not paid back.
    """
    balance_before: uint256 = ERC20(self.token).balanceOf(self)

    assert balance_before >= amount, "insufficient balance"

    ERC20(self.token).transfer(msg.sender, amount)
    IFlashLoanReceiver(msg.sender).execute(amount)
    balance_after: uint256 = ERC20(self.token).balanceOf(self)
    assert balance_after >= balance_before + self.flash_fee, "not paid back"

