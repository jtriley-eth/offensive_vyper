# @version ^0.3.2

"""
@title ERC20 Token
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

