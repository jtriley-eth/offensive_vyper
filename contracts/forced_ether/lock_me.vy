# @version 0.3.1
# TODO FIX STATE VARIABLES
"""
@title unstoppable_auction
@author jtriley.eth
@license MIT
@notice Simple, permissionless auction contract
@dev MUST NOT send ether to last bidder on new bid to avoid gas attacks
"""

event NewBid:
	_bidder: indexed(address)
	_amount: indexed(address)

total_deposit: public(uint256)
deposits: public(map(address, uint256))
highest_bid: public(uint256)
highest_bidder: public(address)

@external
def withdraw():
	"""
	@notice Withdraws a losing bid
	@
	"""
	assert self.highest_bidder != msg.sender
	amount: uint256 = self.deposits[msg.sender]
	self.deposits[msg.sender] = 0
	self.total_deposit -= amount
	send(msg.sender, amount)

@external
@payable
def bid():
	handle_bid(msg.sender, msg.value)

@external
@payable
def __default__():
	handle_bid(msg.sender, msg.value)

@internal
def handle_bid(_bidder: address, _amount: uint256):
	assert self.balance == total_deposit

	# if bidder is not highest_bidder, assert their bid is higher
	# else, this means the highest_bidder is increasing their bid
	if _bidder != self.highest_bidder:
		assert _amount > highest_bid

	self.total_deposit += _amount
	self.deposits[bidder] += _amount
	self.highest_bid = _amount
	self.highest_bidder = bidder

	log NewBid(bidder, amount)

