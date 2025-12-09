# Function: test_UpkeepPayments_GetProposedStatus_AfterProposeEnable()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_UpkeepPayments_GetProposedStatus_AfterProposeEnable()`
- **Visibility**: public
- **Source Range**: 81973:472:659

## Implementation

```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus after proposing to enable
///  @dev Verifies getter returns correct values after proposal to enable
function test_UpkeepPayments_GetProposedStatus_AfterProposeEnable() public {
    uint256 expectedTime = block.timestamp + TIMELOCK;
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    (bool enabled, uint256 effectiveTime) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabled, true, "Proposed enabled should be true");
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
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_UpkeepPayments_GetProposedStatus_AfterProposeEnable() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [enabled, true, "Proposed enabled should be true"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, expectedTime, "Effective time should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getProposedUpkeepPaymentsStatus after proposing to enable
 @dev Verifies getter returns correct values after proposal to enable
