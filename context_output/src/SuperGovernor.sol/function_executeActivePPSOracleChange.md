# Function: executeActivePPSOracleChange()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `executeActivePPSOracleChange()`
- **Visibility**: external
- **Source Range**: 19853:547:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function executeActivePPSOracleChange() external {
    if (_proposedActivePPSOracle == address(0)) revert NO_PROPOSED_PPS_ORACLE();
    if (block.timestamp < _activePPSOracleEffectiveTime) {
        revert TIMELOCK_NOT_EXPIRED();
    }
    address oldOracle = _activePPSOracle;
    _activePPSOracle = _proposedActivePPSOracle;
    _proposedActivePPSOracle = address(0);
    _activePPSOracleEffectiveTime = 0;
    emit ActivePPSOracleChanged(oldOracle, _activePPSOracle);
}
```

## State Variable Reads

- **_proposedActivePPSOracle** (`address`)
- **_activePPSOracleEffectiveTime** (`uint256`)
- **_activePPSOracle** (`address`)

## State Variable Writes

- **_activePPSOracle** (`address`)
- **_proposedActivePPSOracle** (`address`)
- **_activePPSOracleEffectiveTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.executeActivePPSOracleChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Executes a previously proposed PPS oracle change after timelock has expired
