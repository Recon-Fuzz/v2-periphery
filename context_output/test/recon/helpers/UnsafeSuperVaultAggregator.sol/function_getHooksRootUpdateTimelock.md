# Function: getHooksRootUpdateTimelock()

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getHooksRootUpdateTimelock()`
- **Visibility**: external
- **Source Range**: 40542:118:634

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
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getHooksRootUpdateTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the current hooks root update timelock duration
 @return The current timelock duration in seconds
