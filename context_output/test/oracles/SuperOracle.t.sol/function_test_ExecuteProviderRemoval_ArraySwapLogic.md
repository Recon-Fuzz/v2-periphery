# Function: test_ExecuteProviderRemoval_ArraySwapLogic()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_ExecuteProviderRemoval_ArraySwapLogic()`
- **Visibility**: public
- **Source Range**: 60273:629:624

## Implementation

```solidity
/// @notice Tests executeProviderRemoval with array swap logic
///  @dev Covers SuperOracleBase.sol:225 - if (j < activeProviders.length - 1)
function test_ExecuteProviderRemoval_ArraySwapLogic() public {
    bytes32[] memory toRemove = new bytes32[](1);
    toRemove[0] = PROVIDER_1;
    superOracle.queueProviderRemoval(toRemove);
    vm.warp(block.timestamp + 1 hours);
    superOracle.executeProviderRemoval();
    bytes32[] memory active = superOracle.getActiveProviders();
    assertEq(active.length, 2);
    for (uint256 i = 0; i < active.length; i++) {
        assertTrue(active[i] != PROVIDER_1);
    }
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1764:124:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    if (!data) {
        vm.assertTrue(data);
    }
}
```

## External Calls

- **SuperOracle::queueProviderRemoval(bytes32[])**
- **Vm::warp(uint256)**
- **SuperOracle::executeProviderRemoval()**
- **SuperOracle::getActiveProviders()**

## State Variable Reads

- **PROVIDER_1** (`bytes32`)
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_ExecuteProviderRemoval_ArraySwapLogic() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [active.length, 2]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 2)
      💬 Args: [active[i] != PROVIDER_1]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executeProviderRemoval with array swap logic
 @dev Covers SuperOracleBase.sol:225 - if (j < activeProviders.length - 1)
