# Function: test_FulfillRedeemRequests_RevertsOnArrayLengthMismatch()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_FulfillRedeemRequests_RevertsOnArrayLengthMismatch()`
- **Visibility**: public
- **Source Range**: 94150:694:660

## Implementation

```solidity
/// @notice Tests fulfillRedeemRequests reverts when array lengths don't match
///  @dev Covers SuperVaultStrategy.sol:329 (totalAssetsOut.length != len condition)
function test_FulfillRedeemRequests_RevertsOnArrayLengthMismatch() public {
    address[] memory controllers = new address[](2);
    controllers[0] = _deployAccount(0xABC, "TestUser1");
    controllers[1] = _deployAccount(0xDEF, "TestUser2");
    uint256[] memory totalAssetsOut = new uint256[](1);
    totalAssetsOut[0] = 100e18;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_ARRAY_LENGTH.selector);
    strategy.fulfillRedeemRequests(controllers, totalAssetsOut);
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
- **SuperVaultStrategy::fulfillRedeemRequests(address[],uint256[])**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_FulfillRedeemRequests_RevertsOnArrayLengthMismatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xABC, "TestUser1"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [0xDEF, "TestUser2"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests fulfillRedeemRequests reverts when array lengths don't match
 @dev Covers SuperVaultStrategy.sol:329 (totalAssetsOut.length != len condition)
