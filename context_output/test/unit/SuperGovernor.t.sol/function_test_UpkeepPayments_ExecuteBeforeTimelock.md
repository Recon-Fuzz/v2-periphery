# Function: test_UpkeepPayments_ExecuteBeforeTimelock()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_UpkeepPayments_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 83092:599:659

## Implementation

```solidity
function test_UpkeepPayments_ExecuteBeforeTimelock() public {
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    (bool enabledBefore, uint256 effectiveTimeBefore) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabledBefore, true, "Should be true before execution");
    assertTrue(effectiveTimeBefore > 0, "Effective time should be set");
    vm.expectRevert(ISuperGovernor.TIMELOCK_NOT_EXPIRED.selector);
    superGovernor.executeUpkeepPaymentsChange();
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::proposeUpkeepPaymentsChange(bool)**
- **SuperGovernor::getProposedUpkeepPaymentsStatus()**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeUpkeepPaymentsChange()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_UpkeepPayments_ExecuteBeforeTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [enabledBefore, true, "Should be true before execution"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [effectiveTimeBefore > 0, "Effective time should be set"]
      👁️  Def: internal
```
