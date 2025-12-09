# Function: test_RedeemSlippageProtection()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_RedeemSlippageProtection()`
- **Visibility**: public
- **Source Range**: 40172:1051:565

## Implementation

```solidity
function test_RedeemSlippageProtection() public {
    uint256 depositAmount = 100e18;
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), depositAmount);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: depositAmount, minSharesOut: 0});
    ISuperAsset.DepositReturnVars memory ret = superAsset.deposit(depositArgs);
    uint256 tooHighMinTokenOut = 101e18;
    ISuperAsset.RedeemArgs memory redeemArgs = ISuperAsset.RedeemArgs({receiver: user, amountSharesToRedeem: ret.amountSharesMinted, tokenOut: address(tokenIn), minTokenOut: tooHighMinTokenOut});
    vm.expectRevert(ISuperAsset.SLIPPAGE_PROTECTION.selector);
    superAsset.redeem(redeemArgs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Mock4626Vault::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::redeem(struct ISuperAsset.RedeemArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_RedeemSlippageProtection() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
