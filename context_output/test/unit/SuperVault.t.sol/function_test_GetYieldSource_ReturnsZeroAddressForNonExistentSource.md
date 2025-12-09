# Function: test_GetYieldSource_ReturnsZeroAddressForNonExistentSource()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSource_ReturnsZeroAddressForNonExistentSource()`
- **Visibility**: public
- **Source Range**: 150486:415:660

## Implementation

```solidity
/// @notice Tests getYieldSource returns zero address for non-existent yield source
///  @dev Verifies default mapping behavior
function test_GetYieldSource_ReturnsZeroAddressForNonExistentSource() public view {
    address nonExistentSource = address(0x9999);
    ISuperVaultStrategy.YieldSource memory yieldSource = strategy.getYieldSource(nonExistentSource);
    assertEq(yieldSource.oracle, address(0), "Oracle should be zero address for non-existent source");
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

- **SuperVaultStrategy::getYieldSource(address)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSource_ReturnsZeroAddressForNonExistentSource() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [yieldSource.oracle, address(0), "Oracle should be zero address for non-existent source"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSource returns zero address for non-existent yield source
 @dev Verifies default mapping behavior
