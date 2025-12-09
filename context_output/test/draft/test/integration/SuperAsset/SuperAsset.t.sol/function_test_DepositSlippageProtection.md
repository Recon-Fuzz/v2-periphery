# Function: test_DepositSlippageProtection()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_DepositSlippageProtection()`
- **Visibility**: public
- **Source Range**: 31407:658:565

## Implementation

```solidity
function test_DepositSlippageProtection() public {
    uint256 depositAmount = 100e18;
    uint256 tooHighMinSharesOut = 101e18;
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), depositAmount);
    vm.expectRevert(ISuperAsset.SLIPPAGE_PROTECTION.selector);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: depositAmount, minSharesOut: tooHighMinSharesOut});
    superAsset.deposit(depositArgs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Mock4626Vault::approve(address,uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_DepositSlippageProtection() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
