# Function: test_RedeemWithZeroAddress()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_RedeemWithZeroAddress()`
- **Visibility**: public
- **Source Range**: 39767:399:565

## Implementation

```solidity
function test_RedeemWithZeroAddress() public {
    vm.startPrank(user);
    vm.expectRevert(ISuperAsset.ZERO_ADDRESS.selector);
    ISuperAsset.RedeemArgs memory redeemArgs = ISuperAsset.RedeemArgs({receiver: address(0), amountSharesToRedeem: 100e18, tokenOut: address(tokenIn), minTokenOut: 0});
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
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_RedeemWithZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
