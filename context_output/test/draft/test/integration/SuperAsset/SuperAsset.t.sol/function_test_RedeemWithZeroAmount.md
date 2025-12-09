# Function: test_RedeemWithZeroAmount()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_RedeemWithZeroAmount()`
- **Visibility**: public
- **Source Range**: 36948:386:565

## Implementation

```solidity
function test_RedeemWithZeroAmount() public {
    vm.startPrank(user);
    vm.expectRevert(ISuperAsset.ZERO_AMOUNT.selector);
    ISuperAsset.RedeemArgs memory redeemArgs = ISuperAsset.RedeemArgs({receiver: user, amountSharesToRedeem: 0, tokenOut: address(tokenIn), minTokenOut: 0});
    superAsset.redeem(redeemArgs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::redeem(struct ISuperAsset.RedeemArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_RedeemWithZeroAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
