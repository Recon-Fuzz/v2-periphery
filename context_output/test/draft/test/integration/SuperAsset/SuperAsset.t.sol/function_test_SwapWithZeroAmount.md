# Function: test_SwapWithZeroAmount()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_SwapWithZeroAmount()`
- **Visibility**: public
- **Source Range**: 45839:450:565

## Implementation

```solidity
function test_SwapWithZeroAmount() public {
    vm.startPrank(user);
    vm.expectRevert(ISuperAsset.ZERO_AMOUNT.selector);
    ISuperAsset.SwapArgs memory swapArgs = ISuperAsset.SwapArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: 0, tokenOut: address(tokenOut), minTokenOut: 0});
    superAsset.swap(swapArgs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::swap(struct ISuperAsset.SwapArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **tokenOut** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_SwapWithZeroAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
