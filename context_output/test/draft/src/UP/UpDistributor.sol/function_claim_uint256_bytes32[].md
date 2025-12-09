# Function: claim(uint256,bytes32[])

**Contract**: [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]

## Metadata

- **Contract**: UpDistributor
- **Signature**: `claim(uint256,bytes32[])`
- **Visibility**: external
- **Source Range**: 1899:592:551

## Implementation

```solidity
///  @notice Claim tokens if you are part of the merkle tree
///  @param amount The amount of tokens to claim
///  @param merkleProof A proof of inclusion in the merkle tree
function claim(uint256 amount, bytes32[] calldata merkleProof) external {
    if (hasClaimed[msg.sender]) revert ALREADY_CLAIMED();
    bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(msg.sender, amount))));
    if (!MerkleProof.verify(merkleProof, merkleRoot, leaf)) revert INVALID_MERKLE_PROOF();
    hasClaimed[msg.sender] = true;
    emit TokensClaimed(msg.sender, amount);
    token.safeTransfer(msg.sender, amount);
}
```

## Related Implementations

### verify(bytes32[],bytes32,bytes32)

- **Kind**: internal
- **Source**: 1902:154:290
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol:MerkleProof:verify(bytes32[],bytes32,bytes32)`

```solidity
///  @dev Returns true if a `leaf` can be proved to be a part of a Merkle tree
///  defined by `root`. For this, a `proof` must be provided, containing
///  sibling hashes on the branch from the leaf to the root of the tree. Each
///  pair of leaves and each pair of pre-images are assumed to be sorted.
///  This version handles proofs in memory with the default hashing function.
function verify(bytes32[] memory proof, bytes32 root, bytes32 leaf) internal pure returns (bool) {
    return processProof(proof, leaf) == root;
}
```

### processProof(bytes32[],bytes32)

- **Kind**: internal
- **Source**: 2457:308:290
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol:MerkleProof:processProof(bytes32[],bytes32)`

```solidity
///  @dev Returns the rebuilt hash obtained by traversing a Merkle tree up
///  from `leaf` using `proof`. A `proof` is valid if and only if the rebuilt
///  hash matches the root of the tree. When processing the proof, the pairs
///  of leaves & pre-images are assumed to be sorted.
///  This version handles proofs in memory with the default hashing function.
function processProof(bytes32[] memory proof, bytes32 leaf) internal pure returns (bytes32) {
    bytes32 computedHash = leaf;
    for (uint256 i = 0; i < proof.length; i++) {
        computedHash = Hashes.commutativeKeccak256(computedHash, proof[i]);
    }
    return computedHash;
}
```

### commutativeKeccak256(bytes32,bytes32)

- **Kind**: internal
- **Source**: 504:167:289
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/Hashes.sol:Hashes:commutativeKeccak256(bytes32,bytes32)`

```solidity
///  @dev Commutative Keccak256 hash of a sorted pair of bytes32. Frequently used when working with merkle proofs.
///  NOTE: Equivalent to the `standardNodeHash` in our https://github.com/OpenZeppelin/merkle-tree[JavaScript library].
function commutativeKeccak256(bytes32 a, bytes32 b) internal pure returns (bytes32) {
    return (a < b) ? efficientKeccak256(a, b) : efficientKeccak256(b, a);
}
```

### efficientKeccak256(bytes32,bytes32)

- **Kind**: internal
- **Source**: 791:239:289
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/Hashes.sol:Hashes:efficientKeccak256(bytes32,bytes32)`

```solidity
///  @dev Implementation of keccak256(abi.encode(a, b)) that doesn't allocate or expand memory.
function efficientKeccak256(bytes32 a, bytes32 b) internal pure returns (bytes32 value) {
    assembly ("memory-safe") {
        mstore(0x00, a)
        mstore(0x20, b)
        value := keccak256(0x00, 0x40)
    }
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **hasClaimed** (`mapping(address => bool)`)
- **merkleRoot** (`bytes32`)
- **token** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Writes

- **hasClaimed** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributor.claim(uint256,bytes32[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MerkleProof.verify(bytes32[],bytes32,bytes32) (NodeID: 1)
      💬 Args: [merkleProof, merkleRoot, leaf]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MerkleProof.processProof(bytes32[],bytes32) (NodeID: 2)
        💬 Args: [proof, leaf]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Hashes.commutativeKeccak256(bytes32,bytes32) (NodeID: 3)
          💬 Args: [computedHash, proof[i]]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Hashes.efficientKeccak256(bytes32,bytes32) (NodeID: 4)
        │   💬 Args: [a, b]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Hashes.efficientKeccak256(bytes32,bytes32) (NodeID: 5)
            💬 Args: [b, a]
            👁️  Def: internal
```

## Documentation

### Function Documentation

 @notice Claim tokens if you are part of the merkle tree
 @param amount The amount of tokens to claim
 @param merkleProof A proof of inclusion in the merkle tree
