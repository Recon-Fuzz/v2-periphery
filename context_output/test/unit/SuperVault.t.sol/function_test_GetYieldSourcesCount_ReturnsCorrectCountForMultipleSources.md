# Function: test_GetYieldSourcesCount_ReturnsCorrectCountForMultipleSources()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSourcesCount_ReturnsCorrectCountForMultipleSources()`
- **Visibility**: public
- **Source Range**: 156917:1050:660

## Implementation

```solidity
/// @notice Tests getYieldSourcesCount after adding multiple yield sources
///  @dev Verifies count increments correctly
function test_GetYieldSourcesCount_ReturnsCorrectCountForMultipleSources() public {
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
    uint256 count = strategy.getYieldSourcesCount();
    assertEq(count, 3, "Count should be 3 after adding three sources");
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSourcesCount_ReturnsCorrectCountForMultipleSources() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [count, 3, "Count should be 3 after adding three sources"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSourcesCount after adding multiple yield sources
 @dev Verifies count increments correctly
