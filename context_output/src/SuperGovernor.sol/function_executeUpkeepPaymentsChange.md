# Function: executeUpkeepPaymentsChange()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `executeUpkeepPaymentsChange()`
- **Visibility**: external
- **Source Range**: 23934:456:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
///  @notice Executes a previously proposed change to upkeep payments status after timelock expires
function executeUpkeepPaymentsChange() external {
    if (_upkeepPaymentsChangeEffectiveTime == 0) revert NO_PENDING_CHANGE();
    if (block.timestamp < _upkeepPaymentsChangeEffectiveTime) revert TIMELOCK_NOT_EXPIRED();
    _upkeepPaymentsEnabled = _proposedUpkeepPaymentsEnabled;
    _upkeepPaymentsChangeEffectiveTime = 0;
    _proposedUpkeepPaymentsEnabled = false;
    emit UpkeepPaymentsChanged(_upkeepPaymentsEnabled);
}
```

## State Variable Reads

- **_upkeepPaymentsChangeEffectiveTime** (`uint256`)
- **_proposedUpkeepPaymentsEnabled** (`bool`)
- **_upkeepPaymentsEnabled** (`bool`)

## State Variable Writes

- **_upkeepPaymentsEnabled** (`bool`)
- **_upkeepPaymentsChangeEffectiveTime** (`uint256`)
- **_proposedUpkeepPaymentsEnabled** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.executeUpkeepPaymentsChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor
 @notice Executes a previously proposed change to upkeep payments status after timelock expires

### Interface Documentation

@notice Executes a previously proposed upkeep payments status change
