# Function: getProposedMinStaleness()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getProposedMinStaleness()`
- **Visibility**: external
- **Source Range**: 31583:186:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getProposedMinStaleness() external view returns (uint256 proposedMinStaleness, uint256 effectiveTime) {
    return (_proposedMinStaleness, _minStalenessEffectiveTime);
}
```

## State Variable Reads

- **_proposedMinStaleness** (`uint256`)
- **_minStalenessEffectiveTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getProposedMinStaleness() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the proposed minimum staleness value and its effective time
 @return proposedMinStaleness The proposed new minimum staleness value
 @return effectiveTime The timestamp when the new value will become effective
