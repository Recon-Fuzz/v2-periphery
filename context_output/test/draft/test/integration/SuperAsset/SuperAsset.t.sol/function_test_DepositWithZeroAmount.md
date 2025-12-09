# Function: test_DepositWithZeroAmount()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_DepositWithZeroAmount()`
- **Visibility**: public
- **Source Range**: 30116:392:565

## Implementation

```solidity
function test_DepositWithZeroAmount() public {
    vm.startPrank(user);
    vm.expectRevert(ISuperAsset.ZERO_AMOUNT.selector);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: 0, minSharesOut: 0});
    superAsset.deposit(depositArgs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_DepositWithZeroAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
