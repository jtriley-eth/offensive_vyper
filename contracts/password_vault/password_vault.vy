# @version 0.3.1

# @title password_storage
# @author jtriley.eth

password: String[32]
owner: address


@external
def __init__(password: String[32]):
	self.password = password
	self.owner = msg.sender


@external
def set_new_password(old_password: String[32], password: String[32]):
	assert self.password == old_password or msg.sender == self.owner
	
	self.password = password


@external
def withdraw(password: String[32]):
	assert self.password == password or msg.sender == self.owner

	send(msg.sender, self.balance)


@external
@payable
def __default__():
	pass

