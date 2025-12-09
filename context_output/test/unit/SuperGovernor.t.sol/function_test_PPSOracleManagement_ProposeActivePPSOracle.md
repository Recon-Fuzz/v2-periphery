# Function: test_PPSOracleManagement_ProposeActivePPSOracle()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_PPSOracleManagement_ProposeActivePPSOracle()`
- **Visibility**: public
- **Source Range**: 67787:611:659

## Implementation

```solidity
/// @notice Tests proposing a new active PPS Oracle
function test_PPSOracleManagement_ProposeActivePPSOracle() public {
    uint256 expectedTime = block.timestamp + TIMELOCK;
    vm.prank(sGovernor);
    vm.expectEmit(true, true, false, false);
    emit ISuperGovernor.ActivePPSOracleProposed(ppsOracle1, expectedTime);
    superGovernor.proposeActivePPSOracle(ppsOracle1);
    (address proposedOracle, uint256 effectiveTime) = superGovernor.getProposedActivePPSOracle();
    assertEq(proposedOracle, ppsOracle1, "Proposed PPS Oracle address mismatch");
    assertEq(effectiveTime, expectedTime, "Effective time mismatch");
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
- **SuperGovernor::proposeActivePPSOracle(address)**
- **SuperGovernor::getProposedActivePPSOracle()**

## State Variable Reads

- **TIMELOCK** (`uint256`)
- **sGovernor** (`address`)
- **ppsOracle1** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_PPSOracleManagement_ProposeActivePPSOracle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [proposedOracle, ppsOracle1, "Proposed PPS Oracle address mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, expectedTime, "Effective time mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests proposing a new active PPS Oracle
