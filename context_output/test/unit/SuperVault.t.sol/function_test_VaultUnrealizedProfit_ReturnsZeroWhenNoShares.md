# Function: test_VaultUnrealizedProfit_ReturnsZeroWhenNoShares()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_VaultUnrealizedProfit_ReturnsZeroWhenNoShares()`
- **Visibility**: public
- **Source Range**: 164754:267:660

## Implementation

```solidity
/// @notice Tests vaultUnrealizedProfit returns zero when total supply is zero
///  @dev Covers SuperVaultStrategy.sol:617
function test_VaultUnrealizedProfit_ReturnsZeroWhenNoShares() public view {
    uint256 profit = strategy.vaultUnrealizedProfit();
    assertEq(profit, 0, "Profit should be 0 when no shares exist");
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

- **SuperVaultStrategy::vaultUnrealizedProfit()**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_VaultUnrealizedProfit_ReturnsZeroWhenNoShares() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [profit, 0, "Profit should be 0 when no shares exist"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests vaultUnrealizedProfit returns zero when total supply is zero
 @dev Covers SuperVaultStrategy.sol:617
