# @version 0.3.1

# @title password_storage
# @author jtriley.eth

passwords: map(address, string[32])

@public
def set_password(password: string[32]):
	self.passwords[msg.sender] = password

@public
def read_password() -> string[32]:
	return self.passwords[msg.sender]

