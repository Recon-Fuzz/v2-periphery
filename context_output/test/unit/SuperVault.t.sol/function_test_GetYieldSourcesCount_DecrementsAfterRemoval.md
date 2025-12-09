# Function: test_GetYieldSourcesCount_DecrementsAfterRemoval()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSourcesCount_DecrementsAfterRemoval()`
- **Visibility**: public
- **Source Range**: 158095:1666:660

## Implementation

```solidity
/// @notice Tests getYieldSourcesCount after removing a yield source
///  @dev Verifies count decrements correctly
function test_GetYieldSourcesCount_DecrementsAfterRemoval() public {
    address[] memory sources = new address[](2);
    address[] memory oracles = new address[](2);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](2);
    sources[0] = address(0x1111);
    sources[1] = address(0x2222);
    oracles[0] = address(0xAAAA);
    oracles[1] = address(0xBBBB);
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
    actionTypes[1] = ISuperVaultStrategy.YieldSourceAction.Add;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    uint256 countBefore = strategy.getYieldSourcesCount();
    assertEq(countBefore, 2, "Count should be 2 after adding two sources");
    address[] memory sourcesToRemove = new address[](1);
    address[] memory oraclesToRemove = new address[](1);
    ISuperVaultStrategy.YieldSourceAction[] memory removeActionTypes = new ISuperVaultStrategy.YieldSourceAction[](1);
    sourcesToRemove[0] = address(0x1111);
    oraclesToRemove[0] = address(0);
    removeActionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Remove;
    vm.prank(manager);
    strategy.manageYieldSources(sourcesToRemove, oraclesToRemove, removeActionTypes);
    uint256 countAfter = strategy.getYieldSourcesCount();
    assertEq(countAfter, 1, "Count should be 1 after removing one source");
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
- **SuperVaultStrategy::manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])**
- **SuperVaultStrategy::getYieldSourcesCount()**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSourcesCount_DecrementsAfterRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [countBefore, 2, "Count should be 2 after adding two sources"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [countAfter, 1, "Count should be 1 after removing one source"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSourcesCount after removing a yield source
 @dev Verifies count decrements correctly
