# @version ^0.3.2

# @title random_number
# @author jtriley.eth

nonce: public(uint256)

@external
def generate_random_number() -> uint256:
    '''
    @notice Generates a random number for the caller
    @dev Increment nonce to ensure two contracts don't receive the same value in the same block.
    '''
    digest: bytes32 = keccak256(
        concat(
            block.prevhash,
            convert(block.timestamp, bytes32),
            convert(block.difficulty, bytes32),
            convert(self.nonce, bytes32)
        )
    )

    self.nonce += 1

    return convert(digest, uint256)
