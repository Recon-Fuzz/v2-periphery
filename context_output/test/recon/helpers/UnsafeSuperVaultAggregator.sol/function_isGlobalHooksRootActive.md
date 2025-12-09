# Function: isGlobalHooksRootActive()

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `isGlobalHooksRootActive()`
- **Visibility**: external
- **Source Range**: 47012:170:634

## Implementation

```solidity
/// @notice Checks if the global hooks root is active (timelock period has passed)
///  @return isActive True if the global hooks root is active
function isGlobalHooksRootActive() external view returns (bool) {
    return (block.timestamp >= _globalHooksRootEffectiveTime) && (_globalHooksRoot != bytes32(0));
}
```

## State Variable Reads

- **_globalHooksRootEffectiveTime** (`uint256`)
- **_globalHooksRoot** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.isGlobalHooksRootActive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Checks if the global hooks root is active (timelock period has passed)
 @return isActive True if the global hooks root is active

### Interface Documentation

@notice Checks if the global hooks root is active (timelock period has passed)
 @return isActive True if the global hooks root is active
