# Function: getProposedUpkeepPaymentsStatus()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getProposedUpkeepPaymentsStatus()`
- **Visibility**: external
- **Source Range**: 32655:195:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getProposedUpkeepPaymentsStatus() external view returns (bool enabled, uint256 effectiveTime) {
    return (_proposedUpkeepPaymentsEnabled, _upkeepPaymentsChangeEffectiveTime);
}
```

## State Variable Reads

- **_proposedUpkeepPaymentsEnabled** (`bool`)
- **_upkeepPaymentsChangeEffectiveTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getProposedUpkeepPaymentsStatus() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the proposed upkeep payments status and effective time
 @return enabled The proposed status
 @return effectiveTime The timestamp when the change becomes effective
