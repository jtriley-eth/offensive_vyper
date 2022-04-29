# @version 0.3.1

# @title coin_flipper
# @author jtriley.eth

interface Rng:
    def generate_random_number() -> uint256: nonpayable


event Winner:
    _account: indexed(address)
    _amount: uint256


generator: public(address)
cost: constant(uint256) = 1000000000000000000


@external
@payable
def flip_coin(_guess: bool):
    assert msg.value == cost

    side: bool = Rng(self.generator).generate_random_number() % 2 == 0

    if side == _guess:

        amount: uint256 = self.balance

        send(msg.sender, amount)

        log Winner(msg.sender, amount)
