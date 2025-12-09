# Function: test_SetRedeemSlippage_MultipleUsersIndependentSettings()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SetRedeemSlippage_MultipleUsersIndependentSettings()`
- **Visibility**: public
- **Source Range**: 148290:848:660

## Implementation

```solidity
/// @notice Tests setRedeemSlippage allows different users to set different values
///  @dev Verifies per-user storage isolation
function test_SetRedeemSlippage_MultipleUsersIndependentSettings() public {
    address user1 = _deployAccount(0xABC, "User1");
    address user2 = _deployAccount(0xDEF, "User2");
    uint16 slippage1 = 100;
    uint16 slippage2 = 500;
    vm.prank(user1);
    strategy.setRedeemSlippage(slippage1);
    vm.prank(user2);
    strategy.setRedeemSlippage(slippage2);
    ISuperVaultStrategy.SuperVaultState memory state1 = strategy.getSuperVaultState(user1);
    ISuperVaultStrategy.SuperVaultState memory state2 = strategy.getSuperVaultState(user2);
    assertEq(state1.redeemSlippageBps, slippage1, "User1 slippage should be independent");
    assertEq(state2.redeemSlippageBps, slippage2, "User2 slippage should be independent");
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

- **Vm::prank(address)**
- **SuperVaultStrategy::setRedeemSlippage(uint16)**
- **SuperVaultStrategy::getSuperVaultState(address)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SetRedeemSlippage_MultipleUsersIndependentSettings() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xABC, "User1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0xDEF, "User2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [state1.redeemSlippageBps, slippage1, "User1 slippage should be independent"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
      💬 Args: [state2.redeemSlippageBps, slippage2, "User2 slippage should be independent"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setRedeemSlippage allows different users to set different values
 @dev Verifies per-user storage isolation
