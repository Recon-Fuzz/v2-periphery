# Function: getProposedActivePPSOracle()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getProposedActivePPSOracle()`
- **Visibility**: external
- **Source Range**: 30178:189:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getProposedActivePPSOracle() external view returns (address proposedOracle, uint256 effectiveTime) {
    return (_proposedActivePPSOracle, _activePPSOracleEffectiveTime);
}
```

## State Variable Reads

- **_proposedActivePPSOracle** (`address`)
- **_activePPSOracleEffectiveTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getProposedActivePPSOracle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the proposed active PPS oracle and its effective time
 @return proposedOracle The proposed oracle address
 @return effectiveTime The timestamp when the proposed oracle will become effective
