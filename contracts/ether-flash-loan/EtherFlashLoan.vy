# @version ^0.3.2

"""
@title Ether Flash Loan Pool
@author jtriley.eth
"""

interface IFlashLoanReceiver:
    def execute(): payable

event Deposit:
    account: indexed(address)
    amount: uint256

event Withdrawal:
    account: indexed(address)
    amount: uint256


deposits: public(HashMap[address, uint256])


@external
@payable
@nonreentrant('deposit')
def deposit():
    """
    @notice Deposits Ether.
    """
    self.deposits[msg.sender] += msg.value
    log Deposit(msg.sender, msg.value)


@external
@nonreentrant('withdraw')
def withdraw(amount: uint256):
    """
    @notice Withdraws Ether.
    @param amount Withdrwawal amount.
    @dev Throws when amount is gt than deposit.
    """
    sender_deposit: uint256 = self.deposits[msg.sender]

    assert sender_deposit >= amount, "not enough deposited"

    self.deposits[msg.sender] = sender_deposit - amount

    raw_call(msg.sender, b"", value=amount)

    log Withdrawal(msg.sender, amount)


@external
@nonreentrant('flash_loan')
def flash_loan(amount: uint256):
    """
    @notice Flash Loans to caller.
    @param amount Amount to flash loan.
    @dev Throws when insufficient balance OR flash loan isn't paid back.
    """
    balance_before: uint256 = self.balance

    assert balance_before >= amount, "not enough balance"

    IFlashLoanReceiver(msg.sender).execute(value=amount)

    assert self.balance >= balance_before, "flash loan not paid back"


@external
@payable
def __default__():
    """
    @notice For paying back flash loans ONLY.
    """
    pass

