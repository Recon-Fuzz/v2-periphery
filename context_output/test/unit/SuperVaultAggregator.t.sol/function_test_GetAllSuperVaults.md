# Function: test_GetAllSuperVaults()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetAllSuperVaults()`
- **Visibility**: public
- **Source Range**: 58497:621:661

## Implementation

```solidity
/// @notice Tests getAllSuperVaults and superVaults indexed access
function test_GetAllSuperVaults() public {
    address[] memory vaults = superVaultAggregator.getAllSuperVaults();
    assertEq(vaults.length, 1, "Should have 1 vault from setUp");
    address vaultAtIndex = superVaultAggregator.superVaults(0);
    assertEq(vaultAtIndex, vaults[0], "Indexed access should return same vault");
    vm.expectRevert(ISuperVaultAggregator.INDEX_OUT_OF_BOUNDS.selector);
    superVaultAggregator.superVaults(1);
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

- **SuperVaultAggregator::getAllSuperVaults()**
- **SuperVaultAggregator::superVaults(uint256)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetAllSuperVaults() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [vaults.length, 1, "Should have 1 vault from setUp"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [vaultAtIndex, vaults[0], "Indexed access should return same vault"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getAllSuperVaults and superVaults indexed access
