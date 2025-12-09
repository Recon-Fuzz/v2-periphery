# Function: test_FulfillRedeemRequests_RevertsOnEmptyControllersArray()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_FulfillRedeemRequests_RevertsOnEmptyControllersArray()`
- **Visibility**: public
- **Source Range**: 93483:490:660

## Implementation

```solidity
/// @notice Tests fulfillRedeemRequests reverts when controllers array is empty
///  @dev Covers SuperVaultStrategy.sol:329 (len == 0 condition)
function test_FulfillRedeemRequests_RevertsOnEmptyControllersArray() public {
    address[] memory controllers = new address[](0);
    uint256[] memory totalAssetsOut = new uint256[](0);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_ARRAY_LENGTH.selector);
    strategy.fulfillRedeemRequests(controllers, totalAssetsOut);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::fulfillRedeemRequests(address[],uint256[])**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_FulfillRedeemRequests_RevertsOnEmptyControllersArray() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests fulfillRedeemRequests reverts when controllers array is empty
 @dev Covers SuperVaultStrategy.sol:329 (len == 0 condition)
