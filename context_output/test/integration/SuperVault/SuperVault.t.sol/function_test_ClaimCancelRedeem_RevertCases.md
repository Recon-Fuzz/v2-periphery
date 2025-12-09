# Function: test_ClaimCancelRedeem_RevertCases()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ClaimCancelRedeem_RevertCases()`
- **Visibility**: public
- **Source Range**: 62574:1029:580

## Implementation

```solidity
function test_ClaimCancelRedeem_RevertCases() public {
    vm.prank(accountEth);
    vm.expectRevert(ISuperVaultStrategy.REQUEST_NOT_FOUND.selector);
    vault.cancelRedeemRequest(0, accountEth);
    vm.startPrank(MANAGER);
    address[] memory controllers = new address[](1);
    controllers[0] = accountEth;
    strategy.fulfillCancelRedeemRequests(controllers);
    vm.stopPrank();
    vm.prank(accountEth);
    vm.expectRevert(ISuperVault.ZERO_ADDRESS.selector);
    vault.claimCancelRedeemRequest(0, address(0), accountEth);
    vm.prank(accountEth);
    vm.expectRevert(ISuperVault.ZERO_ADDRESS.selector);
    vault.claimCancelRedeemRequest(0, accountEth, address(0));
    vm.prank(address(this));
    vm.expectRevert(ISuperVault.INVALID_CONTROLLER.selector);
    vault.claimCancelRedeemRequest(0, accountEth, accountEth);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVault::cancelRedeemRequest(uint256,address)**
- **Vm::startPrank(address)**
- **SuperVaultStrategy::fulfillCancelRedeemRequests(address[])**
- **Vm::stopPrank()**
- **SuperVault::claimCancelRedeemRequest(uint256,address,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ClaimCancelRedeem_RevertCases() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
