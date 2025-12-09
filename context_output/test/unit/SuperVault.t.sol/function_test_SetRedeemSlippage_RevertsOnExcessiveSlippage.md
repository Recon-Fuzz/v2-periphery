# Function: test_SetRedeemSlippage_RevertsOnExcessiveSlippage()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SetRedeemSlippage_RevertsOnExcessiveSlippage()`
- **Visibility**: public
- **Source Range**: 145983:363:660

## Implementation

```solidity
/// @notice Tests setRedeemSlippage reverts when slippage exceeds BPS_PRECISION
///  @dev Covers SuperVaultStrategy.sol:547
function test_SetRedeemSlippage_RevertsOnExcessiveSlippage() public {
    address _user = _deployAccount(0xABC, "TestUser");
    uint16 invalidSlippage = 10_001;
    vm.prank(_user);
    vm.expectRevert(ISuperVaultStrategy.INVALID_REDEEM_SLIPPAGE_BPS.selector);
    strategy.setRedeemSlippage(invalidSlippage);
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
- **SuperVaultStrategy::setRedeemSlippage(uint16)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SetRedeemSlippage_RevertsOnExcessiveSlippage() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0xABC, "TestUser"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setRedeemSlippage reverts when slippage exceeds BPS_PRECISION
 @dev Covers SuperVaultStrategy.sol:547
