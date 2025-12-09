# Function: test_HandleOperations4626Mint_RevertsOnAccessDenied()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_HandleOperations4626Mint_RevertsOnAccessDenied()`
- **Visibility**: public
- **Source Range**: 71828:416:660

## Implementation

```solidity
/// @notice Tests handleOperations4626Mint reverts when called by non-vault address
///  @dev Covers SuperVaultStrategy.sol:204 - _requireVault() check
function test_HandleOperations4626Mint_RevertsOnAccessDenied() public {
    address testUser = _deployAccount(0xDEF, "TestUser");
    vm.prank(testUser);
    vm.expectRevert(ISuperVaultStrategy.ACCESS_DENIED.selector);
    strategy.handleOperations4626Mint(testUser, 100e18, 1000e18, 950e18);
}
```

## Related Implementations

### _deployAccount(uint256,string)

- **Kind**: internal
- **Source**: 3858:217:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_deployAccount(uint256,string)`

```solidity
function _deployAccount(uint256 key_, string memory name_) internal returns (address) {
    address _user = vm.addr(key_);
    vm.deal(_user, LARGE);
    vm.label(_user, name_);
    return _user;
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::handleOperations4626Mint(address,uint256,uint256,uint256)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_HandleOperations4626Mint_RevertsOnAccessDenied() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0xDEF, "TestUser"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests handleOperations4626Mint reverts when called by non-vault address
 @dev Covers SuperVaultStrategy.sol:204 - _requireVault() check
