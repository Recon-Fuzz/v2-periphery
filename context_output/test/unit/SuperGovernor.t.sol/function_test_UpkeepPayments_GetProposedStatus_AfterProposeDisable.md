# Function: test_UpkeepPayments_GetProposedStatus_AfterProposeDisable()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_UpkeepPayments_GetProposedStatus_AfterProposeDisable()`
- **Visibility**: public
- **Source Range**: 82610:476:659

## Implementation

```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus after proposing to disable
///  @dev Verifies getter returns correct values after proposal to disable
function test_UpkeepPayments_GetProposedStatus_AfterProposeDisable() public {
    uint256 expectedTime = block.timestamp + TIMELOCK;
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(false);
    (bool enabled, uint256 effectiveTime) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabled, false, "Proposed enabled should be false");
    assertEq(effectiveTime, expectedTime, "Effective time should match");
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::proposeUpkeepPaymentsChange(bool)**
- **SuperGovernor::getProposedUpkeepPaymentsStatus()**

## State Variable Reads

- **TIMELOCK** (`uint256`)
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_UpkeepPayments_GetProposedStatus_AfterProposeDisable() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [enabled, false, "Proposed enabled should be false"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, expectedTime, "Effective time should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getProposedUpkeepPaymentsStatus after proposing to disable
 @dev Verifies getter returns correct values after proposal to disable
