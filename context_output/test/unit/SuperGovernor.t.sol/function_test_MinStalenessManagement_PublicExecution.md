# Function: test_MinStalenessManagement_PublicExecution()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MinStalenessManagement_PublicExecution()`
- **Visibility**: public
- **Source Range**: 95859:512:659

## Implementation

```solidity
/// @notice Tests that execution is public (can be called by anyone)
function test_MinStalenessManagement_PublicExecution() public {
    uint256 newMinStaleness = 600;
    vm.prank(sGovernor);
    superGovernor.proposeMinStaleness(newMinStaleness);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    vm.prank(user);
    superGovernor.executeMinStalenessChange();
    assertEq(superGovernor.getMinStaleness(), newMinStaleness, "Minimum staleness should be updated");
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
- **Vm::warp(uint256)**
- **SuperGovernor::executeMinStalenessChange()**
- **SuperGovernor::getMinStaleness()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **TIMELOCK** (`uint256`)
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MinStalenessManagement_PublicExecution() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superGovernor.getMinStaleness(), newMinStaleness, "Minimum staleness should be updated"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that execution is public (can be called by anyone)
