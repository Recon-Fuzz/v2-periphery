# Function: test_GetAllSuperVaultStrategies()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetAllSuperVaultStrategies()`
- **Visibility**: public
- **Source Range**: 59213:770:661

## Implementation

```solidity
/// @notice Tests getAllSuperVaultStrategies and superVaultStrategies indexed access
function test_GetAllSuperVaultStrategies() public {
    address[] memory strategies = superVaultAggregator.getAllSuperVaultStrategies();
    assertEq(strategies.length, 1, "Should have 1 strategy from setUp");
    assertEq(strategies[0], strategy, "Strategy should match the one from setUp");
    address strategyAtIndex = superVaultAggregator.superVaultStrategies(0);
    assertEq(strategyAtIndex, strategy, "Indexed access should return same strategy");
    vm.expectRevert(ISuperVaultAggregator.INDEX_OUT_OF_BOUNDS.selector);
    superVaultAggregator.superVaultStrategies(1);
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

- **SuperVaultAggregator::getAllSuperVaultStrategies()**
- **SuperVaultAggregator::superVaultStrategies(uint256)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetAllSuperVaultStrategies() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [strategies.length, 1, "Should have 1 strategy from setUp"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
  │   💬 Args: [strategies[0], strategy, "Strategy should match the one from setUp"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
      💬 Args: [strategyAtIndex, strategy, "Indexed access should return same strategy"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getAllSuperVaultStrategies and superVaultStrategies indexed access
