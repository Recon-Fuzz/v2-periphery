# Function: executeMinStalenessChange()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `executeMinStalenessChange()`
- **Visibility**: external
- **Source Range**: 24955:498:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function executeMinStalenessChange() external {
    uint256 minStalenessEffectiveTime = _minStalenessEffectiveTime;
    if (minStalenessEffectiveTime == 0) revert NO_PROPOSED_MIN_STALENESS();
    if (block.timestamp < minStalenessEffectiveTime) revert TIMELOCK_NOT_EXPIRED();
    _minStaleness = _proposedMinStaleness;
    _proposedMinStaleness = 0;
    _minStalenessEffectiveTime = 0;
    emit MinStalenessChanged(_minStaleness);
}
```

## State Variable Reads

- **_minStalenessEffectiveTime** (`uint256`)
- **_proposedMinStaleness** (`uint256`)
- **_minStaleness** (`uint256`)

## State Variable Writes

- **_minStaleness** (`uint256`)
- **_proposedMinStaleness** (`uint256`)
- **_minStalenessEffectiveTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.executeMinStalenessChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Executes a previously proposed minimum staleness change after timelock has expired
