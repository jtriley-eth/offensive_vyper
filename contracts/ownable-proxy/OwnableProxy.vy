# @version ^0.3.2

"""
@title Ownable Proxy Contract
@author jtriley.eth
"""

# Storage paddings for external contract calls.
storage_padding: uint256[32]


owner: public(address)


@external
def __init__():
	self.owner = msg.sender


@external
def forward_call(target: address, payload: Bytes[32]):
	"""
	@notice Forwards a contract call
	@param target Address to call
	@param payload Calldata
	"""
	raw_call(target, payload)


@external
def forward_call_with_value(
	target: address,
	payload: Bytes[32],
	msg_value: uint256
):
	"""
	@notice Forward a contract call with a msg.value
	@param target Address to call
	@param payload Calldata
	@dev reverts if msg.sender is not owner since, ya know, it sends value
	"""
	assert msg.sender == self.owner, "not authorized"
	assert msg_value <= self.balance, "insufficient balance"
	raw_call(target, payload, value=msg_value)


@external
def forward_delegatecall(target: address, payload: Bytes[32]):
	"""
	@notice Forwards a contract delegate call
	@param target Address to delegate call
	@param payload Calldata
	@dev Local storage is padded to accomodate delegated contracts
	"""
	raw_call(target, payload, is_delegate_call=True)


@external
@payable
def __default__():
	pass

