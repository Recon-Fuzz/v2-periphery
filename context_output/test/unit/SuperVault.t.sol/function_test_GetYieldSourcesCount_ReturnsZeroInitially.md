# Function: test_GetYieldSourcesCount_ReturnsZeroInitially()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSourcesCount_ReturnsZeroInitially()`
- **Visibility**: public
- **Source Range**: 155709:194:660

## Implementation

```solidity
/// @notice Tests getYieldSourcesCount returns zero initially
///  @dev Covers SuperVaultStrategy.sol:606 - initial state
function test_GetYieldSourcesCount_ReturnsZeroInitially() public view {
    uint256 count = strategy.getYieldSourcesCount();
    assertEq(count, 0, "Initial count should be zero");
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

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSourcesCount_ReturnsZeroInitially() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [count, 0, "Initial count should be zero"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSourcesCount returns zero initially
 @dev Covers SuperVaultStrategy.sol:606 - initial state
