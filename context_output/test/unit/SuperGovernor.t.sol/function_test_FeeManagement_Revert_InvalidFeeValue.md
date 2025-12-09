# Function: test_FeeManagement_Revert_InvalidFeeValue()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_FeeManagement_Revert_InvalidFeeValue()`
- **Visibility**: public
- **Source Range**: 79239:341:659

## Implementation

```solidity
/// @notice Tests reverting when proposing an invalid fee value
function test_FeeManagement_Revert_InvalidFeeValue() public {
    FeeType feeType = FeeType.REVENUE_SHARE;
    uint256 invalidFeeValue = BPS_MAX + 1;
    vm.prank(sGovernor);
    vm.expectRevert(ISuperGovernor.INVALID_FEE_VALUE.selector);
    superGovernor.proposeFee(feeType, invalidFeeValue);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::proposeFee(enum FeeType,uint256)**

## State Variable Reads

- **BPS_MAX** (`uint256`)
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_FeeManagement_Revert_InvalidFeeValue() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when proposing an invalid fee value
