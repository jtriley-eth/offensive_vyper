# @version ^0.3.2

"""
@title password_storage
@author jtriley.eth
"""

password: String[32]

owner: address


@external
def __init__(password: String[32]):
	self.password = password
	
	self.owner = msg.sender


@external
def set_new_password(old_password: String[32], password: String[32]):
	"""
	@notice Sets a new password
	@param old_password Last password for authentication
	@param password New password to set
	@dev Throws when password is invalid or the same as the last
	"""

	assert self.password == old_password or msg.sender == self.owner
	
	self.password = password


@external
def withdraw(password: String[32]):
	"""
	@notice Withdraws funds from vault
	@param password Password for authentication
	@dev Throws when password is invalid
	"""

	assert self.password == password or msg.sender == self.owner

	send(msg.sender, self.balance)


@external
@payable
def __default__():
	pass

