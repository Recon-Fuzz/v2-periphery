# Function: executeFeeUpdate(enum FeeType)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `executeFeeUpdate(enum FeeType)`
- **Visibility**: external
- **Source Range**: 21807:578:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function executeFeeUpdate(FeeType feeType) external {
    FeeData storage feeData = _feeData[feeType];
    uint256 effectiveTime = feeData.effectiveTime;
    if (effectiveTime == 0) revert NO_PROPOSED_FEE(feeType);
    if (block.timestamp < effectiveTime) {
        revert TIMELOCK_NOT_EXPIRED();
    }
    feeData.value = feeData.proposedValue;
    feeData.proposedValue = 0;
    feeData.effectiveTime = 0;
    emit FeeUpdated(feeType, feeData.value);
}
```

## State Variable Reads

- **_feeData** (`mapping(enum FeeType => struct SuperGovernor.FeeData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.executeFeeUpdate(enum FeeType) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Executes a previously proposed fee update after timelock has expired
 @param feeType The type of ffee to execute the update for
