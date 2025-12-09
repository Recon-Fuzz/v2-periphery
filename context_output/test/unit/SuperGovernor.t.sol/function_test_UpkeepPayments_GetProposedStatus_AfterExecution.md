# Function: test_UpkeepPayments_GetProposedStatus_AfterExecution()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_UpkeepPayments_GetProposedStatus_AfterExecution()`
- **Visibility**: public
- **Source Range**: 83833:953:659

## Implementation

```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus after execution
///  @dev Verifies getter returns reset values after execution
function test_UpkeepPayments_GetProposedStatus_AfterExecution() public {
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    (bool enabledBefore, uint256 effectiveTimeBefore) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabledBefore, true, "Should be true before execution");
    assertTrue(effectiveTimeBefore > 0, "Effective time should be set");
    vm.warp((block.timestamp + TIMELOCK) + 1);
    superGovernor.executeUpkeepPaymentsChange();
    (bool enabledAfter, uint256 effectiveTimeAfter) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabledAfter, false, "Should be reset to false after execution");
    assertEq(effectiveTimeAfter, 0, "Effective time should be reset to 0");
}
```

## Related Implementations

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2487:171:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

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
- **SuperGovernor::proposeUpkeepPaymentsChange(bool)**
- **SuperGovernor::getProposedUpkeepPaymentsStatus()**
- **Vm::warp(uint256)**
- **SuperGovernor::executeUpkeepPaymentsChange()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_UpkeepPayments_GetProposedStatus_AfterExecution() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [enabledBefore, true, "Should be true before execution"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [effectiveTimeBefore > 0, "Effective time should be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 3)
  │   💬 Args: [enabledAfter, false, "Should be reset to false after execution"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
      💬 Args: [effectiveTimeAfter, 0, "Effective time should be reset to 0"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getProposedUpkeepPaymentsStatus after execution
 @dev Verifies getter returns reset values after execution
