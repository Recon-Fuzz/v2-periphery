# Function: test_AddSecondaryManager_RevertMainManagerAlreadyExists()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_AddSecondaryManager_RevertMainManagerAlreadyExists()`
- **Visibility**: public
- **Source Range**: 32686:487:661

## Implementation

```solidity
/// @notice Tests that addSecondaryManager reverts when trying to add the main manager as secondary
function test_AddSecondaryManager_RevertMainManagerAlreadyExists() public {
    assertEq(superVaultAggregator.getMainManager(strategy), manager, "Manager should be main manager");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.SECONDARY_MANAGER_CANNOT_BE_PRIMARY.selector);
    superVaultAggregator.addSecondaryManager(strategy, manager);
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

## External Calls

- **SuperVaultAggregator::getMainManager(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_AddSecondaryManager_RevertMainManagerAlreadyExists() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [superVaultAggregator.getMainManager(strategy), manager, "Manager should be main manager"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that addSecondaryManager reverts when trying to add the main manager as secondary
