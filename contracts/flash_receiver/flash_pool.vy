# @version ^0.3.2

"""
@title Flash Loan Pool Supporting ERC20 Token
@author jtriley.eth
"""

from vyper.interfaces import ERC20

interface IFlashLoanReceiver:
	def execute(): nonpayable


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
	self.flash_fee = 10 ** 18


@external
def deposit(amount: uint256):
	ERC20(self.token).transferFrom(msg.sender, self, amount)
	self.deposits[msg.sender] += amount
	log Deposit(msg.sender, amount)


@external
def withdraw(amount: uint256):
	self.deposits[msg.sender] -= amount
	ERC20(self.token).transferFrom(self, msg.sender, amount)
	log Withdrawal(msg.sender, amount)


@external
def flash_loan(amount: uint256):
	balance_before: uint256 = ERC20(self.token).balanceOf(self)
	ERC20(self.token).transfer(msg.sender, amount)
	IFlashLoanReceiver(msg.sender).execute()
	balance_after: uint256 = ERC20(self.token).balanceOf(self)
	assert balance_after >= balance_before + self.flash_fee, "not paid back"

