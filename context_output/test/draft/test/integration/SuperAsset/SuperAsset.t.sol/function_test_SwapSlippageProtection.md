# Function: test_SwapSlippageProtection()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_SwapSlippageProtection()`
- **Visibility**: public
- **Source Range**: 47304:669:565

## Implementation

```solidity
function test_SwapSlippageProtection() public {
    uint256 swapAmount = 100e18;
    uint256 tooHighMinTokenOut = 101e18;
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), swapAmount);
    vm.expectRevert(ISuperAsset.SLIPPAGE_PROTECTION.selector);
    ISuperAsset.SwapArgs memory swapArgs = ISuperAsset.SwapArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: swapAmount, tokenOut: address(tokenOut), minTokenOut: tooHighMinTokenOut});
    superAsset.swap(swapArgs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Mock4626Vault::approve(address,uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::swap(struct ISuperAsset.SwapArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **tokenOut** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_SwapSlippageProtection() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
