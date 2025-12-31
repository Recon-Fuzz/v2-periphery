# Contract: MerkleProof

## Metadata

- **Name**: MerkleProof
- **Type**: Contract
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol
- **Documentation**:  @dev These functions deal with verification of Merkle Tree proofs.
   The tree and the proofs can be generated using our
   https://github.com/OpenZeppelin/merkle-tree[JavaScript library].
   You will find a quickstart guide in the readme.
   WARNING: You should avoid using leaf values that are 64 bytes long prior to
   hashing, or use a hash function other than keccak256 for hashing leaves.
   This is because the concatenation of a sorted pair of internal nodes in
   the Merkle tree could be reinterpreted as a leaf value.
   OpenZeppelin's JavaScript library generates Merkle trees that are safe
   against this attack out of the box.
   IMPORTANT: Consider memory side-effects when using custom hashing functions
   that access memory in an unsafe way.
   NOTE: This library supports proof verification for merkle trees built using
   custom _commutative_ hashing functions (i.e. `H(a, b) == H(b, a)`). Proving
   leaf inclusion in trees built using non-commutative hashing functions requires
   additional logic that is not supported by this library.

## Errors

### MerkleProofInvalidMultiproof

```solidity
/// @dev The multiproof provided is not valid.
error MerkleProofInvalidMultiproof();
```
