# Function: proposeGlobalHooksRoot(bytes32)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `proposeGlobalHooksRoot(bytes32)`
- **Visibility**: external
- **Source Range**: 33544:527:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function proposeGlobalHooksRoot(bytes32 newRoot) external {
    if (msg.sender != address(SUPER_GOVERNOR)) {
        revert UNAUTHORIZED_UPDATE_AUTHORITY();
    }
    _proposedGlobalHooksRoot = newRoot;
    uint256 effectiveTime = block.timestamp + _hooksRootUpdateTimelock;
    _globalHooksRootEffectiveTime = effectiveTime;
    emit GlobalHooksRootUpdateProposed(newRoot, effectiveTime);
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_hooksRootUpdateTimelock** (`uint256`)

## State Variable Writes

- **_proposedGlobalHooksRoot** (`bytes32`)
- **_globalHooksRootEffectiveTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.proposeGlobalHooksRoot(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Proposes an update to the global hooks Merkle root
 @dev Only callable by SUPER_GOVERNOR
 @param newRoot New Merkle root for global hooks validation
