# Function: test_UpkeepPayments_GetProposedStatus_MultipleProposals()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_UpkeepPayments_GetProposedStatus_MultipleProposals()`
- **Visibility**: public
- **Source Range**: 84932:1784:659

## Implementation

```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus with multiple proposals
///  @dev Verifies latest proposal overrides previous ones
function test_UpkeepPayments_GetProposedStatus_MultipleProposals() public {
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    (bool enabled1, uint256 effectiveTime1) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabled1, true, "First proposal should be true");
    uint256 expectedTime1 = block.timestamp + TIMELOCK;
    assertEq(effectiveTime1, expectedTime1, "First effective time should match");
    vm.warp(block.timestamp + 100);
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(false);
    (bool enabled2, uint256 effectiveTime2) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabled2, false, "Second proposal should override to false");
    uint256 expectedTime2 = block.timestamp + TIMELOCK;
    assertEq(effectiveTime2, expectedTime2, "Second effective time should be updated");
    assertTrue(effectiveTime2 > effectiveTime1, "Second effective time should be later");
    vm.warp(block.timestamp + 200);
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    (bool enabled3, uint256 effectiveTime3) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabled3, true, "Third proposal should override to true");
    uint256 expectedTime3 = block.timestamp + TIMELOCK;
    assertEq(effectiveTime3, expectedTime3, "Third effective time should be updated");
    assertTrue(effectiveTime3 > effectiveTime2, "Third effective time should be latest");
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
- **Vm::warp(uint256)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_UpkeepPayments_GetProposedStatus_MultipleProposals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [enabled1, true, "First proposal should be true"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [effectiveTime1, expectedTime1, "First effective time should match"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 3)
  │   💬 Args: [enabled2, false, "Second proposal should override to false"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [effectiveTime2, expectedTime2, "Second effective time should be updated"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
  │   💬 Args: [effectiveTime2 > effectiveTime1, "Second effective time should be later"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 6)
  │   💬 Args: [enabled3, true, "Third proposal should override to true"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [effectiveTime3, expectedTime3, "Third effective time should be updated"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 8)
      💬 Args: [effectiveTime3 > effectiveTime2, "Third effective time should be latest"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getProposedUpkeepPaymentsStatus with multiple proposals
 @dev Verifies latest proposal overrides previous ones
