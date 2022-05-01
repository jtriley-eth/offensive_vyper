# @version 0.3.1

"""
@title unstoppable_auction
@author jtriley.eth
@license MIT
@notice Simple, permissionless auction contract
@dev MUST NOT send ether to last bidder on new bid to avoid out-of-gas attacks
"""

event NewBid:
	bidder: indexed(address)
	amount: uint256

owner: address
total_deposit: public(uint256)
deposits: HashMap[address, uint256]
highest_bid: public(uint256)
highest_bidder: public(address)
auction_start: public(uint256)
auction_end: public(uint256)


@external
def __init__(auction_start: uint256, auction_end: uint256):
	assert auction_start < auction_end

	self.auction_start = auction_start
	self.auction_end = auction_end
	self.owner = msg.sender


@internal
def handle_bid(bidder: address, amount: uint256):
	assert self.balance == self.total_deposit
	assert self.auction_start < block.timestamp and block.timestamp < self.auction_end

	# if the current bidder is not highest_bidder, assert their bid is higher than the last,
	# otherwise, this means the highest_bidder is increasing their bid
	if bidder != self.highest_bidder:
		assert amount > self.highest_bid

	self.total_deposit += amount
	self.deposits[bidder] += amount
	self.highest_bid = amount
	self.highest_bidder = bidder

	log NewBid(bidder, amount)


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

