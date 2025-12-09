# Function: test_UpkeepPayments_GetProposedStatus_AfterTimelockWithoutExecution()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_UpkeepPayments_GetProposedStatus_AfterTimelockWithoutExecution()`
- **Visibility**: public
- **Source Range**: 86900:661:659

## Implementation

```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus with time warp but no execution
///  @dev Verifies proposal values persist even after timelock expires without execution
function test_UpkeepPayments_GetProposedStatus_AfterTimelockWithoutExecution() public {
    uint256 expectedTime = block.timestamp + TIMELOCK;
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    vm.warp((block.timestamp + TIMELOCK) + 1000);
    (bool enabled, uint256 effectiveTime) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabled, true, "Proposal should still be true");
    assertEq(effectiveTime, expectedTime, "Effective time should remain unchanged");
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
- **Vm::warp(uint256)**
- **SuperGovernor::getProposedUpkeepPaymentsStatus()**

## State Variable Reads

- **TIMELOCK** (`uint256`)
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_UpkeepPayments_GetProposedStatus_AfterTimelockWithoutExecution() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [enabled, true, "Proposal should still be true"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, expectedTime, "Effective time should remain unchanged"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getProposedUpkeepPaymentsStatus with time warp but no execution
 @dev Verifies proposal values persist even after timelock expires without execution
