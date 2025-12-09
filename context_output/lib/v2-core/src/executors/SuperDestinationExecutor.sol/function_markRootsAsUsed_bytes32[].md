# Function: markRootsAsUsed(bytes32[])

**Contract**: [lib/v2-core/src/executors/SuperDestinationExecutor.sol/contract_SuperDestinationExecutor.md]

## Metadata

- **Contract**: SuperDestinationExecutor
- **Signature**: `markRootsAsUsed(bytes32[])`
- **Visibility**: external
- **Source Range**: 6591:288:360

## Implementation

```solidity
/// @inheritdoc ISuperDestinationExecutor
function markRootsAsUsed(bytes32[] memory roots) external {
    uint256 length = roots.length;
    for (uint256 i; i < length; ++i) {
        usedMerkleRoots[msg.sender][roots[i]] = true;
    }
    emit SuperDestinationExecutorMarkRootsAsUsed(msg.sender, roots);
}
```

## State Variable Writes

- **usedMerkleRoots** (`mapping(address => mapping(bytes32 => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperDestinationExecutor.markRootsAsUsed(bytes32[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperDestinationExecutor

### Interface Documentation

@notice Marks a list of merkle roots as used by the account
 @dev Used to prevent replay attacks in cross-chain message verification
      Each valid merkle root should only be usable once per user account
 @param roots Array of merkle roots to mark as used
