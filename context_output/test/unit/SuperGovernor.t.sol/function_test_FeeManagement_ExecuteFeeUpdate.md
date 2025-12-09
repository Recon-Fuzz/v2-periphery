# Function: test_FeeManagement_ExecuteFeeUpdate()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_FeeManagement_ExecuteFeeUpdate()`
- **Visibility**: public
- **Source Range**: 79631:633:659

## Implementation

```solidity
/// @notice Tests executing a fee update
function test_FeeManagement_ExecuteFeeUpdate() public {
    FeeType feeType = FeeType.REVENUE_SHARE;
    uint256 feeValue = 50;
    vm.prank(sGovernor);
    superGovernor.proposeFee(feeType, feeValue);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    vm.expectEmit(true, true, false, false);
    emit ISuperGovernor.FeeUpdated(feeType, feeValue);
    superGovernor.executeFeeUpdate(feeType);
    assertEq(superGovernor.getFee(feeType), feeValue, "Fee value mismatch");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::proposeFee(enum FeeType,uint256)**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::executeFeeUpdate(enum FeeType)**
- **SuperGovernor::getFee(enum FeeType)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_FeeManagement_ExecuteFeeUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superGovernor.getFee(feeType), feeValue, "Fee value mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executing a fee update
