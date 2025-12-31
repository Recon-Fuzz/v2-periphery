# Function: isMerkleRootUsed(address,bytes32)

**Contract**: [lib/v2-core/src/executors/SuperDestinationExecutor.sol/contract_SuperDestinationExecutor.md]

## Metadata

- **Contract**: SuperDestinationExecutor
- **Signature**: `isMerkleRootUsed(address,bytes32)`
- **Visibility**: external
- **Source Range**: 4185:146:360

## Implementation

```solidity
/// @inheritdoc ISuperDestinationExecutor
function isMerkleRootUsed(address user, bytes32 merkleRoot) external view returns (bool) {
    return usedMerkleRoots[user][merkleRoot];
}
```

## State Variable Reads

- **usedMerkleRoots** (`mapping(address => mapping(bytes32 => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperDestinationExecutor.isMerkleRootUsed(address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperDestinationExecutor

### Interface Documentation

@notice Checks if a merkle root has already been used by an account
 @dev Used to prevent replay attacks in cross-chain message verification
      Each valid merkle root should only be usable once per user account
 @param user The user account to check for merkle root usage
 @param merkleRoot The merkle root hash to verify usage status
 @return True if the merkle root has already been used by this account, false otherwise
