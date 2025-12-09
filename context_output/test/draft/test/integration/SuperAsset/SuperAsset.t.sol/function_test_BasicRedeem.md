# Function: test_BasicRedeem()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_BasicRedeem()`
- **Visibility**: public
- **Source Range**: 32099:4843:565

## Implementation

```solidity
function test_BasicRedeem() public {
    uint256 depositAmount = 100e18;
    ISuperAsset.PreviewDepositArgs memory previewDepositArgs = ISuperAsset.PreviewDepositArgs({tokenIn: address(tokenIn), amountTokenToDeposit: depositAmount, isSoft: false});
    ISuperAsset.PreviewDepositReturnVars memory previewDepositRet = superAsset.previewDeposit(previewDepositArgs);
    bool isSuccess = ((((previewDepositRet.oraclePriceUSD != 0) && (!previewDepositRet.isDepeg)) && (!previewDepositRet.isDispersion)) && (!previewDepositRet.isOracleOff)) && previewDepositRet.tokenInFound;
    assertEq(isSuccess, true, "isSuccess should be true, because of zero initial allocation");
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), depositAmount);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: depositAmount, minSharesOut: 0});
    console.log("\n DEPOSIT 1 START");
    ISuperAsset.DepositReturnVars memory ret = superAsset.deposit(depositArgs);
    console.log("\n DEPOSIT 1 END");
    assertEq(tokenIn.balanceOf(address(superAsset)), depositAmount - ret.swapFee);
    assertEq(previewDepositRet.amountSharesMinted, ret.amountSharesMinted);
    uint256 userShareBalancePostDeposit = superAsset.balanceOf(user);
    assertEq(userShareBalancePostDeposit, ret.amountSharesMinted, "User should have received the shares");
    assertEq(previewDepositRet.swapFee, ret.swapFee);
    assertEq(previewDepositRet.amountIncentiveUSDDeposit, ret.amountIncentiveUSDDeposit);
    tokenIn.approve(address(superAsset), depositAmount);
    ISuperAsset.DepositArgs memory depositArgs2 = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: depositAmount, minSharesOut: 0});
    console.log("\n DEPOSIT 2 START");
    ISuperAsset.DepositReturnVars memory ret2 = superAsset.deposit(depositArgs2);
    console.log("\n DEPOSIT 2 END");
    uint256 minTokenOut = ((ret.amountSharesMinted + ret2.amountSharesMinted) * 99) / 100;
    ISuperAsset.PreviewRedeemArgs memory previewRedeemArgs = ISuperAsset.PreviewRedeemArgs({tokenOut: address(tokenIn), amountSharesToRedeem: ret.amountSharesMinted + ret2.amountSharesMinted, isSoft: false});
    ISuperAsset.PreviewRedeemReturnVars memory previewRedeemRet = superAsset.previewRedeem(previewRedeemArgs);
    isSuccess = (((((previewRedeemRet.oraclePriceUSD != 0) && (!previewRedeemRet.isDepeg)) && (!previewRedeemRet.isDispersion)) && (!previewRedeemRet.isOracleOff)) && previewRedeemRet.tokenOutFound) && previewRedeemRet.incentiveCalculationSuccess;
    assertEq(isSuccess, true, "isSuccess should be true, because of zero initial allocation");
    assertGt(previewRedeemRet.amountTokenOutAfterFees, 0, "Should receive tokens");
    assertGt(previewRedeemRet.swapFee, 0, "Should pay swap fees");
    ISuperAsset.RedeemArgs memory redeemArgs = ISuperAsset.RedeemArgs({receiver: user, amountSharesToRedeem: ret.amountSharesMinted + ret2.amountSharesMinted, tokenOut: address(tokenIn), minTokenOut: minTokenOut});
    console.log("\n USER SHARE BALANCE PRE REDEEM", userShareBalancePostDeposit);
    ISuperAsset.RedeemReturnVars memory retRedeem = superAsset.redeem(redeemArgs);
    vm.stopPrank();
    assertEq(previewRedeemRet.amountTokenOutAfterFees, retRedeem.amountTokenOutAfterFees, "Actual token output should match preview");
    assertEq(previewRedeemRet.swapFee, retRedeem.swapFee, "Actual swap fee should match preview");
    assertEq(previewRedeemRet.amountIncentiveUSDRedeem, retRedeem.amountIncentiveUSDRedeem, "Actual incentive should match preview");
    assertGt(retRedeem.amountTokenOutAfterFees, 0, "Should receive tokens");
    assertEq(superAsset.balanceOf(user), 0, "User should have no shares left");
}
```

## Related Implementations

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2487:171:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### log(string)

- **Kind**: internal
- **Source**: 6191:121:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 8891:133:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 8650:235:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
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

### assertEq(int256,int256)

- **Kind**: internal
- **Source**: 3346:151:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256)`

```solidity
function assertEq(int256 left, int256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### assertEq(int256,int256,string)

- **Kind**: internal
- **Source**: 3503:175:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256,string)`

```solidity
function assertEq(int256 left, int256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperAsset::previewDeposit(struct ISuperAsset.PreviewDepositArgs)**
- **Vm::startPrank(address)**
- **Mock4626Vault::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Mock4626Vault::balanceOf(address)**
- **SuperAsset::balanceOf(address)**
- **SuperAsset::previewRedeem(struct ISuperAsset.PreviewRedeemArgs)**
- **SuperAsset::redeem(struct ISuperAsset.RedeemArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_BasicRedeem() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [isSuccess, true, "isSuccess should be true, because of zero initial allocation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 2)
  │   💬 Args: ["\n DEPOSIT 1 START"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 3)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 4)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 5)
  │   💬 Args: ["\n DEPOSIT 1 END"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 6)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 7)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
  │   💬 Args: [tokenIn.balanceOf(address(superAsset)), depositAmount - ret.swapFee]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 9)
  │   💬 Args: [previewDepositRet.amountSharesMinted, ret.amountSharesMinted]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [userShareBalancePostDeposit, ret.amountSharesMinted, "User should have received the shares"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 11)
  │   💬 Args: [previewDepositRet.swapFee, ret.swapFee]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256) (NodeID: 12)
  │   💬 Args: [previewDepositRet.amountIncentiveUSDDeposit, ret.amountIncentiveUSDDeposit]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 13)
  │   💬 Args: ["\n DEPOSIT 2 START"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 16)
  │   💬 Args: ["\n DEPOSIT 2 END"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 17)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 18)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 19)
  │   💬 Args: [isSuccess, true, "isSuccess should be true, because of zero initial allocation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 20)
  │   💬 Args: [previewRedeemRet.amountTokenOutAfterFees, 0, "Should receive tokens"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 21)
  │   💬 Args: [previewRedeemRet.swapFee, 0, "Should pay swap fees"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 22)
  │   💬 Args: ["\n USER SHARE BALANCE PRE REDEEM", userShareBalancePostDeposit]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 23)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 24)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 25)
  │   💬 Args: [previewRedeemRet.amountTokenOutAfterFees, retRedeem.amountTokenOutAfterFees, "Actual token output should match preview"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 26)
  │   💬 Args: [previewRedeemRet.swapFee, retRedeem.swapFee, "Actual swap fee should match preview"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256,string) (NodeID: 27)
  │   💬 Args: [previewRedeemRet.amountIncentiveUSDRedeem, retRedeem.amountIncentiveUSDRedeem, "Actual incentive should match preview"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 28)
  │   💬 Args: [retRedeem.amountTokenOutAfterFees, 0, "Should receive tokens"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 29)
      💬 Args: [superAsset.balanceOf(user), 0, "User should have no shares left"]
      👁️  Def: internal
```
