# Function: test_SwapWithZeroAddress()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_SwapWithZeroAddress()`
- **Visibility**: public
- **Source Range**: 46835:463:565

## Implementation

```solidity
function test_SwapWithZeroAddress() public {
    vm.startPrank(user);
    vm.expectRevert(ISuperAsset.ZERO_ADDRESS.selector);
    ISuperAsset.SwapArgs memory swapArgs = ISuperAsset.SwapArgs({receiver: address(0), tokenIn: address(tokenIn), amountTokenToDeposit: 100e18, tokenOut: address(tokenOut), minTokenOut: 0});
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
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_SwapWithZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
