# Function: test_SetRedeemSlippage_SucceedsWithMaximumSlippage()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SetRedeemSlippage_SucceedsWithMaximumSlippage()`
- **Visibility**: public
- **Source Range**: 147670:478:660

## Implementation

```solidity
/// @notice Tests setRedeemSlippage succeeds with maximum valid slippage
///  @dev Covers edge case: exactly BPS_PRECISION (10000 = 100%)
function test_SetRedeemSlippage_SucceedsWithMaximumSlippage() public {
    address _user = _deployAccount(0xABC, "TestUser");
    uint16 maxSlippage = 10_000;
    vm.prank(_user);
    strategy.setRedeemSlippage(maxSlippage);
    ISuperVaultStrategy.SuperVaultState memory state = strategy.getSuperVaultState(_user);
    assertEq(state.redeemSlippageBps, maxSlippage, "Maximum slippage should be stored correctly");
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SetRedeemSlippage_SucceedsWithMaximumSlippage() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xABC, "TestUser"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [state.redeemSlippageBps, maxSlippage, "Maximum slippage should be stored correctly"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setRedeemSlippage succeeds with maximum valid slippage
 @dev Covers edge case: exactly BPS_PRECISION (10000 = 100%)
