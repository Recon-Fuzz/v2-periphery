# Function: test_GetAllSuperVaultEscrows()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetAllSuperVaultEscrows()`
- **Visibility**: public
- **Source Range**: 60072:654:661

## Implementation

```solidity
/// @notice Tests getAllSuperVaultEscrows and superVaultEscrows indexed access
function test_GetAllSuperVaultEscrows() public {
    address[] memory escrows = superVaultAggregator.getAllSuperVaultEscrows();
    assertEq(escrows.length, 1, "Should have 1 escrow from setUp");
    address escrowAtIndex = superVaultAggregator.superVaultEscrows(0);
    assertEq(escrowAtIndex, escrows[0], "Indexed access should return same escrow");
    vm.expectRevert(ISuperVaultAggregator.INDEX_OUT_OF_BOUNDS.selector);
    superVaultAggregator.superVaultEscrows(1);
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

- **SuperVaultAggregator::getAllSuperVaultEscrows()**
- **SuperVaultAggregator::superVaultEscrows(uint256)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetAllSuperVaultEscrows() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [escrows.length, 1, "Should have 1 escrow from setUp"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [escrowAtIndex, escrows[0], "Indexed access should return same escrow"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getAllSuperVaultEscrows and superVaultEscrows indexed access
