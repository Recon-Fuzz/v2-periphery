# Function: test_GetYieldSourcesCount_UnchangedAfterOracleUpdate()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSourcesCount_UnchangedAfterOracleUpdate()`
- **Visibility**: public
- **Source Range**: 163330:1114:660

## Implementation

```solidity
/// @notice Tests getYieldSourcesCount after oracle update (should not change count)
///  @dev Verifies that updating oracle doesn't affect count
function test_GetYieldSourcesCount_UnchangedAfterOracleUpdate() public {
    address[] memory sources = new address[](1);
    address[] memory oracles = new address[](1);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](1);
    sources[0] = address(0x1234);
    oracles[0] = address(0x5678);
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    uint256 countBefore = strategy.getYieldSourcesCount();
    assertEq(countBefore, 1, "Count should be 1");
    oracles[0] = address(0xABCD);
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.UpdateOracle;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    uint256 countAfter = strategy.getYieldSourcesCount();
    assertEq(countAfter, 1, "Count should remain 1 after oracle update");
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSourcesCount_UnchangedAfterOracleUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [countBefore, 1, "Count should be 1"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [countAfter, 1, "Count should remain 1 after oracle update"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSourcesCount after oracle update (should not change count)
 @dev Verifies that updating oracle doesn't affect count
