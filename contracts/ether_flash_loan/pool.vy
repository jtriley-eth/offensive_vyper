# @version 0.3.1

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


deposits = public(HashMap[address, uint256])


@external
@payable
def deposit():
	"""
	@notice Deposits Ether
	"""
	self.deposits[msg.sender] += msg.value

@external
def withdraw(amount: uint256):
	"""
	@notice Withdraws Ether
	@param amount Withdrwawal amount
	@dev Throws when amount is gt than deposit
	"""
	deposit = self.deposits[msg.sender]

	assert deposit >= amount, "not enough deposited"

	self.deposits[msg.sender] = deposit - amount

	send(msg.sender, amount)

	log Withdrawal(msg.sender, amount)

@external
def flash_loan(amount: uint256):
	"""
	@notice Flash Loans to caller
	@param amount Amount to flash loan
	@dev Throws when insufficient balance OR flash loan isn't paid back
	"""
	uint256 balance_before = self.balance

	assert balance_before >= amount, "not enough balance"

	IFlashLoanReceiver(msg.sender).execute(value=amount)

	assert self.balance >= balance_before, "flash loan not paid back"


