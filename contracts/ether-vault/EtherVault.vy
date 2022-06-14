# @version ^0.3.2

"""
@title Ether Liquidity Pool
@author jtriley.eth
"""


event Deposit:
    account: indexed(address)
    amount: uint256

event Withdrawal:
    account: indexed(address)
    amount: uint256


deposits: public(HashMap[address, uint256])


@external
@payable
def deposit():
    """
    @notice Deposits Ether.
    """
    self.deposits[msg.sender] = unsafe_add(self.deposits[msg.sender], msg.value)

    log Deposit(msg.sender, msg.value)


@external
def withdraw():
    """
    @notice Withdraws Ether.
    """
    amount: uint256 = self.deposits[msg.sender]

    raw_call(msg.sender, b"", value=amount)

    self.deposits[msg.sender] = 0

    log Withdrawal(msg.sender, amount)


@external
@payable
def __default__():
    """
    @notice Receives Ether as Deposit.
    """
    self.deposits[msg.sender] = unsafe_add(self.deposits[msg.sender], msg.value)

    log Deposit(msg.sender, msg.value)


