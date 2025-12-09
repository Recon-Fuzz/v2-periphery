# Function: test_PPSOracleManagement_ExecuteActivePPSOracleChange()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_PPSOracleManagement_ExecuteActivePPSOracleChange()`
- **Visibility**: public
- **Source Range**: 69501:919:659

## Implementation

```solidity
/// @notice Tests executing a PPS Oracle change
function test_PPSOracleManagement_ExecuteActivePPSOracleChange() public {
    vm.prank(sGovernor);
    superGovernor.proposeActivePPSOracle(ppsOracle1);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    vm.expectEmit(true, false, false, false);
    emit ISuperGovernor.ActivePPSOracleChanged(address(0), ppsOracle1);
    superGovernor.executeActivePPSOracleChange();
    assertEq(superGovernor.getActivePPSOracle(), ppsOracle1, "Active PPS Oracle should be updated");
    assertTrue(superGovernor.isActivePPSOracle(ppsOracle1), "isActivePPSOracle should return true");
    (address proposedOracle, ) = superGovernor.getProposedActivePPSOracle();
    assertEq(proposedOracle, address(0), "Proposed PPS Oracle should be reset");
}
```

## Related Implementations

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
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
- **SuperGovernor::proposeActivePPSOracle(address)**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::executeActivePPSOracleChange()**
- **SuperGovernor::getActivePPSOracle()**
- **SuperGovernor::isActivePPSOracle(address)**
- **SuperGovernor::getProposedActivePPSOracle()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **ppsOracle1** (`address`)
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_PPSOracleManagement_ExecuteActivePPSOracleChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [superGovernor.getActivePPSOracle(), ppsOracle1, "Active PPS Oracle should be updated"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.isActivePPSOracle(ppsOracle1), "isActivePPSOracle should return true"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
      💬 Args: [proposedOracle, address(0), "Proposed PPS Oracle should be reset"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executing a PPS Oracle change
