# Function: test_CanRedeemInactiveToken()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_CanRedeemInactiveToken()`
- **Visibility**: public
- **Source Range**: 54250:1574:565

## Implementation

```solidity
function test_CanRedeemInactiveToken() public {
    uint256 depositAmount = 50e18;
    underlyingToken1.mint(user, depositAmount);
    vm.startPrank(user);
    underlyingToken1.approve(address(superAsset), depositAmount);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(underlyingToken1), amountTokenToDeposit: depositAmount, minSharesOut: 0});
    ISuperAsset.DepositReturnVars memory depositRet = superAsset.deposit(depositArgs);
    uint256 sharesBalance = depositRet.amountSharesMinted;
    assertGt(sharesBalance, 0, "User should have shares after deposit");
    vm.stopPrank();
    vm.startPrank(admin);
    superAsset.removeVault(address(underlyingToken1));
    vm.stopPrank();
    vm.startPrank(user);
    ISuperAsset.RedeemArgs memory redeemArgs = ISuperAsset.RedeemArgs({receiver: user, tokenOut: address(underlyingToken1), amountSharesToRedeem: sharesBalance, minTokenOut: 0});
    ISuperAsset.RedeemReturnVars memory redeemRet = superAsset.redeem(redeemArgs);
    assertEq(superAsset.balanceOf(user), 0, "User should have no shares left");
    assertGt(redeemRet.amountTokenOutAfterFees, 0, "User should receive tokens");
    vm.stopPrank();
}
```

## Related Implementations

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::stopPrank()**
- **SuperAsset::removeVault(address)**
- **SuperAsset::redeem(struct ISuperAsset.RedeemArgs)**
- **SuperAsset::balanceOf(address)**

## State Variable Reads

- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **admin** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_CanRedeemInactiveToken() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [sharesBalance, 0, "User should have shares after deposit"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superAsset.balanceOf(user), 0, "User should have no shares left"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 3)
      💬 Args: [redeemRet.amountTokenOutAfterFees, 0, "User should receive tokens"]
      👁️  Def: internal
```
