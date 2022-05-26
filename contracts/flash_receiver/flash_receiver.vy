# @version ^0.3.2

"""
@title Flash Loan Receiver Supporting ERC20 Token
@author jtriley.eth
"""

from vyper.interfaces import ERC20

interface IPool:
	flash_fee() -> uint256: view
	flash_loan(uint256): nonpayable

token: public(address)

pool: public(address)


@external
def __init__(token: address, pool: address):
	self.token = token


@internal
def _execute_action():
	pass


@external
def initiate_flash_loan(amount: uint256):
	IPool(pool).flash_loan(amount)
	_execute_action()
	fee: uint256 = IPool(pool).flash_fee()
	ERC20(token).transfer(pool, amount + fee)


