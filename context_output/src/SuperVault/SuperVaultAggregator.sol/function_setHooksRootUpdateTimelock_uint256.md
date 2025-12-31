# Function: setHooksRootUpdateTimelock(uint256)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `setHooksRootUpdateTimelock(uint256)`
- **Visibility**: external
- **Source Range**: 33114:382:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function setHooksRootUpdateTimelock(uint256 newTimelock) external {
    if (msg.sender != address(SUPER_GOVERNOR)) {
        revert UNAUTHORIZED_UPDATE_AUTHORITY();
    }
    _hooksRootUpdateTimelock = newTimelock;
    emit HooksRootUpdateTimelockChanged(newTimelock);
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## State Variable Writes

- **_hooksRootUpdateTimelock** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.setHooksRootUpdateTimelock(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Sets a new hooks root update timelock duration
 @param newTimelock The new timelock duration in seconds
