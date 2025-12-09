# Function: test_DepositWithZeroAddress()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_DepositWithZeroAddress()`
- **Visibility**: public
- **Source Range**: 30996:405:565

## Implementation

```solidity
function test_DepositWithZeroAddress() public {
    vm.startPrank(user);
    vm.expectRevert(ISuperAsset.ZERO_ADDRESS.selector);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: address(0), tokenIn: address(tokenIn), amountTokenToDeposit: 100e18, minSharesOut: 0});
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
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_DepositWithZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
