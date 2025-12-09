# Function: test_ChangeHooksRootUpdateTimelock_AllowsZeroTimelock()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ChangeHooksRootUpdateTimelock_AllowsZeroTimelock()`
- **Visibility**: public
- **Source Range**: 37471:312:659

## Implementation

```solidity
/// @notice Tests changeHooksRootUpdateTimelock allows zero timelock (emergency use)
///  @dev Verifies that zero timelock is intentionally allowed for SUPER_GOVERNOR_ROLE
function test_ChangeHooksRootUpdateTimelock_AllowsZeroTimelock() public {
    vm.prank(sGovernor);
    superGovernor.changeHooksRootUpdateTimelock(0);
    uint256 timelock = aggregator.getHooksRootUpdateTimelock();
    assertEq(timelock, 0, "Timelock should be 0 for emergency situations");
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
- **SuperGovernor::changeHooksRootUpdateTimelock(uint256)**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ChangeHooksRootUpdateTimelock_AllowsZeroTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [timelock, 0, "Timelock should be 0 for emergency situations"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests changeHooksRootUpdateTimelock allows zero timelock (emergency use)
 @dev Verifies that zero timelock is intentionally allowed for SUPER_GOVERNOR_ROLE
