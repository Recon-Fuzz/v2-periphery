# Function: test_MinStalenesManagement_ExecuteMinStalenesChange()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MinStalenesManagement_ExecuteMinStalenesChange()`
- **Visibility**: public
- **Source Range**: 93652:1033:659

## Implementation

```solidity
/// @notice Tests executing a minimum staleness change
function test_MinStalenesManagement_ExecuteMinStalenesChange() public {
    uint256 newMinStaleness = 600;
    vm.prank(sGovernor);
    superGovernor.proposeMinStaleness(newMinStaleness);
    assertEq(superGovernor.getMinStaleness(), 300, "Initial minimum staleness should be 300");
    vm.warp((block.timestamp + TIMELOCK) + 1);
    vm.expectEmit(true, false, false, false);
    emit ISuperGovernor.MinStalenessChanged(newMinStaleness);
    superGovernor.executeMinStalenessChange();
    assertEq(superGovernor.getMinStaleness(), newMinStaleness, "Minimum staleness should be updated");
    (uint256 proposedMinStaleness, ) = superGovernor.getProposedMinStaleness();
    assertEq(proposedMinStaleness, 0, "Proposed minimum staleness should be reset");
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
- **SuperGovernor::proposeMinStaleness(uint256)**
- **SuperGovernor::getMinStaleness()**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::executeMinStalenessChange()**
- **SuperGovernor::getProposedMinStaleness()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MinStalenesManagement_ExecuteMinStalenesChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superGovernor.getMinStaleness(), 300, "Initial minimum staleness should be 300"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superGovernor.getMinStaleness(), newMinStaleness, "Minimum staleness should be updated"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [proposedMinStaleness, 0, "Proposed minimum staleness should be reset"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executing a minimum staleness change
