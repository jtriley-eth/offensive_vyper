# @version 0.3.1

"""
@title unstoppable_auction
@author jtriley.eth
@license MIT
@notice Simple, permissionless auction contract
@dev MUST NOT send ether to last bidder on new bid to avoid out-of-gas attacks
"""

event NewBid:
	_bidder: indexed(address)
	_amount: uint256

owner: address
total_deposit: public(uint256)
deposits: HashMap[address, uint256]
highest_bid: public(uint256)
highest_bidder: public(address)
auction_start: public(uint256)
auction_end: public(uint256)


@external
def __init__(_auction_start: uint256, _auction_end: uint256):
	assert _auction_start < _auction_end

	self.auction_start = _auction_start
	self.auction_end = _auction_end
	self.owner = msg.sender


@internal
def handle_bid(_bidder: address, _amount: uint256):
	assert self.balance == self.total_deposit
	assert self.auction_start < block.timestamp and block.timestamp < self.auction_end

	# if the current bidder is not highest_bidder, assert their bid is higher than the last,
	# otherwise, this means the highest_bidder is increasing their bid
	if _bidder != self.highest_bidder:
		assert _amount > self.highest_bid

	self.total_deposit += _amount
	self.deposits[_bidder] += _amount
	self.highest_bid = _amount
	self.highest_bidder = _bidder

	log NewBid(_bidder, _amount)


@external
def withdraw():
	"""
	@notice Withdraws a losing bid
	@dev Throws if msg sender is still the highest bidder
	"""
	assert self.highest_bidder != msg.sender
	amount: uint256 = self.deposits[msg.sender]
	self.deposits[msg.sender] = 0
	self.total_deposit -= amount
	send(msg.sender, amount)


@external
def owner_withdraw():
	"""
	@notice Owner withdraws Ether once the auction ends
	@dev Throws if msg sender is not the owner or if the auction has not ended
	"""
	assert msg.sender == self.owner
	assert block.timestamp >= self.auction_end

	send(msg.sender, self.balance)


@external
@payable
def bid():
	self.handle_bid(msg.sender, msg.value)


@external
@payable
def __default__():
	self.handle_bid(msg.sender, msg.value)

