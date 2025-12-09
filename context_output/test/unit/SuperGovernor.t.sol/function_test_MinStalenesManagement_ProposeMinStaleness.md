# Function: test_MinStalenesManagement_ProposeMinStaleness()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MinStalenesManagement_ProposeMinStaleness()`
- **Visibility**: public
- **Source Range**: 91931:680:659

## Implementation

```solidity
/// @notice Tests proposing a new minimum staleness value
function test_MinStalenesManagement_ProposeMinStaleness() public {
    uint256 newMinStaleness = 600;
    uint256 expectedTime = block.timestamp + TIMELOCK;
    vm.prank(sGovernor);
    vm.expectEmit(true, true, false, false);
    emit ISuperGovernor.MinStalenessProposed(newMinStaleness, expectedTime);
    superGovernor.proposeMinStaleness(newMinStaleness);
    (uint256 proposedMinStaleness, uint256 effectiveTime) = superGovernor.getProposedMinStaleness();
    assertEq(proposedMinStaleness, newMinStaleness, "Proposed minimum staleness mismatch");
    assertEq(effectiveTime, expectedTime, "Effective time mismatch");
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
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::proposeMinStaleness(uint256)**
- **SuperGovernor::getProposedMinStaleness()**

## State Variable Reads

- **TIMELOCK** (`uint256`)
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MinStalenesManagement_ProposeMinStaleness() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [proposedMinStaleness, newMinStaleness, "Proposed minimum staleness mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, expectedTime, "Effective time mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests proposing a new minimum staleness value
