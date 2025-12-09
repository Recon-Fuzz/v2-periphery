# Function: test_ExecuteProviderRemoval_LastElement()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_ExecuteProviderRemoval_LastElement()`
- **Visibility**: public
- **Source Range**: 61072:665:624

## Implementation

```solidity
/// @notice Tests executeProviderRemoval removing last element (no swap needed)
///  @dev Covers the else case of line 225 - removing last provider in array
function test_ExecuteProviderRemoval_LastElement() public {
    bytes32[] memory activeBefore = superOracle.getActiveProviders();
    bytes32[] memory toRemove = new bytes32[](1);
    toRemove[0] = activeBefore[activeBefore.length - 1];
    superOracle.queueProviderRemoval(toRemove);
    vm.warp(block.timestamp + 1 hours);
    superOracle.executeProviderRemoval();
    bytes32[] memory activeAfter = superOracle.getActiveProviders();
    assertEq(activeAfter.length, activeBefore.length - 1);
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

## External Calls

- **SuperOracle::getActiveProviders()**
- **SuperOracle::queueProviderRemoval(bytes32[])**
- **Vm::warp(uint256)**
- **SuperOracle::executeProviderRemoval()**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_ExecuteProviderRemoval_LastElement() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [activeAfter.length, activeBefore.length - 1]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executeProviderRemoval removing last element (no swap needed)
 @dev Covers the else case of line 225 - removing last provider in array
