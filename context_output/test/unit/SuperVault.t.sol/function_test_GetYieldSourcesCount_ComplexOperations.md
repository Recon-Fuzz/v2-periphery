# Function: test_GetYieldSourcesCount_ComplexOperations()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSourcesCount_ComplexOperations()`
- **Visibility**: public
- **Source Range**: 159913:3258:660

## Implementation

```solidity
/// @notice Tests getYieldSourcesCount with complex add/remove operations
///  @dev Verifies count is accurate through multiple operations
function test_GetYieldSourcesCount_ComplexOperations() public {
    assertEq(strategy.getYieldSourcesCount(), 0, "Initial count should be 0");
    address[] memory sources = new address[](3);
    address[] memory oracles = new address[](3);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](3);
    sources[0] = address(0x1111);
    sources[1] = address(0x2222);
    sources[2] = address(0x3333);
    oracles[0] = address(0xAAAA);
    oracles[1] = address(0xBBBB);
    oracles[2] = address(0xCCCC);
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
    actionTypes[1] = ISuperVaultStrategy.YieldSourceAction.Add;
    actionTypes[2] = ISuperVaultStrategy.YieldSourceAction.Add;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    assertEq(strategy.getYieldSourcesCount(), 3, "Count should be 3");
    address[] memory sourcesToRemove = new address[](2);
    address[] memory oraclesToRemove = new address[](2);
    ISuperVaultStrategy.YieldSourceAction[] memory removeActionTypes = new ISuperVaultStrategy.YieldSourceAction[](2);
    sourcesToRemove[0] = address(0x1111);
    sourcesToRemove[1] = address(0x3333);
    oraclesToRemove[0] = address(0);
    oraclesToRemove[1] = address(0);
    removeActionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Remove;
    removeActionTypes[1] = ISuperVaultStrategy.YieldSourceAction.Remove;
    vm.prank(manager);
    strategy.manageYieldSources(sourcesToRemove, oraclesToRemove, removeActionTypes);
    assertEq(strategy.getYieldSourcesCount(), 1, "Count should be 1 after removing 2");
    address[] memory moreSources = new address[](1);
    address[] memory moreOracles = new address[](1);
    ISuperVaultStrategy.YieldSourceAction[] memory addActionTypes = new ISuperVaultStrategy.YieldSourceAction[](1);
    moreSources[0] = address(0x4444);
    moreOracles[0] = address(0xDDDD);
    addActionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
    vm.prank(manager);
    strategy.manageYieldSources(moreSources, moreOracles, addActionTypes);
    assertEq(strategy.getYieldSourcesCount(), 2, "Count should be 2 after adding 1 more");
    address[] memory removeAll = new address[](2);
    address[] memory removeAllOracles = new address[](2);
    ISuperVaultStrategy.YieldSourceAction[] memory removeAllTypes = new ISuperVaultStrategy.YieldSourceAction[](2);
    removeAll[0] = address(0x2222);
    removeAll[1] = address(0x4444);
    removeAllOracles[0] = address(0);
    removeAllOracles[1] = address(0);
    removeAllTypes[0] = ISuperVaultStrategy.YieldSourceAction.Remove;
    removeAllTypes[1] = ISuperVaultStrategy.YieldSourceAction.Remove;
    vm.prank(manager);
    strategy.manageYieldSources(removeAll, removeAllOracles, removeAllTypes);
    assertEq(strategy.getYieldSourcesCount(), 0, "Count should be 0 after removing all");
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

- **SuperVaultStrategy::getYieldSourcesCount()**
- **Vm::prank(address)**
- **SuperVaultStrategy::manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSourcesCount_ComplexOperations() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [strategy.getYieldSourcesCount(), 0, "Initial count should be 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [strategy.getYieldSourcesCount(), 3, "Count should be 3"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [strategy.getYieldSourcesCount(), 1, "Count should be 1 after removing 2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [strategy.getYieldSourcesCount(), 2, "Count should be 2 after adding 1 more"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [strategy.getYieldSourcesCount(), 0, "Count should be 0 after removing all"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSourcesCount with complex add/remove operations
 @dev Verifies count is accurate through multiple operations
