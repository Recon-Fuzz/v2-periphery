# Function: getHooksRootUpdateTimelock()

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `getHooksRootUpdateTimelock()`
- **Visibility**: external
- **Source Range**: 42469:118:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getHooksRootUpdateTimelock() external view returns (uint256) {
    return _hooksRootUpdateTimelock;
}
```

## State Variable Reads

- **_hooksRootUpdateTimelock** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.getHooksRootUpdateTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the current hooks root update timelock duration
 @return The current timelock duration in seconds
