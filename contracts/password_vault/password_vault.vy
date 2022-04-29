# @version 0.3.1

# @title password_storage
# @author jtriley.eth

password: String[32]
owner: address


@external
def __init__(_password: String[32]):
	self.password = _password
	self.owner = msg.sender


@external
def set_new_password(_old_password: String[32], _password: String[32]):
	assert self.password == _old_password or msg.sender == self.owner
	
	self.password = _password


@external
def withdraw(_password: String[32]):
	assert self.password == _password or msg.sender == self.owner

	send(msg.sender, self.balance)


@external
@payable
def __default__():
	pass
