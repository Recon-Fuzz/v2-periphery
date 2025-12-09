# Function: test_FeeManagement_ProposeFee()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_FeeManagement_ProposeFee()`
- **Visibility**: public
- **Source Range**: 78645:520:659

## Implementation

```solidity
/// @notice Tests proposing a new fee
function test_FeeManagement_ProposeFee() public {
    FeeType feeType = FeeType.REVENUE_SHARE;
    uint256 feeValue = 50;
    uint256 expectedTime = block.timestamp + TIMELOCK;
    vm.prank(sGovernor);
    vm.expectEmit(true, true, true, true);
    emit ISuperGovernor.FeeProposed(feeType, feeValue, expectedTime);
    superGovernor.proposeFee(feeType, feeValue);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::proposeFee(enum FeeType,uint256)**

## State Variable Reads

- **TIMELOCK** (`uint256`)
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_FeeManagement_ProposeFee() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests proposing a new fee
