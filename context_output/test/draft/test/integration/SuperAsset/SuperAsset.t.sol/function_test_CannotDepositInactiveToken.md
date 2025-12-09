# Function: test_CannotDepositInactiveToken()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_CannotDepositInactiveToken()`
- **Visibility**: public
- **Source Range**: 53207:1037:565

## Implementation

```solidity
function test_CannotDepositInactiveToken() public {
    MockERC20 testToken = new MockERC20("Test Token", "TEST", 18);
    vm.startPrank(admin);
    superAsset.whitelistERC20(address(testToken));
    vm.stopPrank();
    testToken.mint(user, 100e18);
    vm.startPrank(admin);
    superAsset.removeERC20(address(testToken));
    vm.stopPrank();
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(testToken), amountTokenToDeposit: 10e18, minSharesOut: 0});
    vm.startPrank(user);
    testToken.approve(address(superAsset), 100e18);
    vm.expectRevert(ISuperAsset.NOT_SUPPORTED_TOKEN.selector);
    superAsset.deposit(depositArgs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperAsset::whitelistERC20(address)**
- **Vm::stopPrank()**
- **MockERC20::mint(address,uint256)**
- **SuperAsset::removeERC20(address)**
- **MockERC20::approve(address,uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**

## State Variable Reads

- **admin** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_CannotDepositInactiveToken() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
