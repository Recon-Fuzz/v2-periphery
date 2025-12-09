# Contract: MerkleTreeBuilder

## Metadata

- **Name**: MerkleTreeBuilder
- **Type**: Contract
- **Path**: test/utils/MerkleTreeBuilder.sol
- **Documentation**: @title MerkleTreeBuilder
   @notice Pure Solidity Merkle tree generation for testing hook configurations
   @dev Generates Merkle trees matching OpenZeppelin's StandardMerkleTree.of() format

## Structs

### HookConfig

```solidity
/// @notice Represents a hook configuration for Merkle tree generation
struct HookConfig {
    address hookAddress;
    bytes encodedArgs;
}
```
