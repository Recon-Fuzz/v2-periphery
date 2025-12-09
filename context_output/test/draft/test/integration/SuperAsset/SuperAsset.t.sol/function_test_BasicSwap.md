# Function: test_BasicSwap()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_BasicSwap()`
- **Visibility**: public
- **Source Range**: 41654:4179:565

## Implementation

```solidity
function test_BasicSwap() public {
    BasiSwapStack memory s;
    s.swapAmount = 100e18;
    s.minTokenOut = 99e18;
    vm.startPrank(user11);
    tokenOut.approve(address(superAsset), s.swapAmount);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user11, tokenIn: address(tokenOut), amountTokenToDeposit: s.swapAmount, minSharesOut: 0});
    ISuperAsset.DepositReturnVars memory ret = superAsset.deposit(depositArgs);
    vm.stopPrank();
    assertEq(tokenOut.balanceOf(address(superAsset)), s.swapAmount - ret.swapFee, "Should deposit tokenOut");
    assertEq(superAsset.balanceOf(user11), ret.amountSharesMinted, "Should mint shares");
    ISuperAsset.PreviewSwapArgs memory previewArgs = ISuperAsset.PreviewSwapArgs({tokenIn: address(tokenIn), amountTokenToDeposit: s.swapAmount, tokenOut: address(tokenOut), isSoft: false});
    ISuperAsset.PreviewSwapReturnVars memory previewRet = superAsset.previewSwap(previewArgs);
    s.expAmountTokenOutAfterFees = previewRet.amountTokenOutAfterFees;
    s.expSwapFeeIn = previewRet.swapFeeIn;
    s.expSwapFeeOut = previewRet.swapFeeOut;
    s.expAmountIncentiveUSDDeposit = previewRet.amountIncentiveUSDDeposit;
    s.expAmountIncentiveUSDRedeem = previewRet.amountIncentiveUSDRedeem;
    s.isSuccess = ((((previewRet.oraclePriceUSD != 0) && (!previewRet.isDepeg)) && (!previewRet.isDispersion)) && (!previewRet.isOracleOff)) && previewRet.tokenInFound;
    assertEq(s.isSuccess, true, "isSuccess should be true, because of zero initial allocation");
    assertGt(s.expAmountTokenOutAfterFees, 0, "Should receive output tokens");
    assertGt(s.expSwapFeeIn, 0, "Should charge deposit fee");
    assertGt(s.expSwapFeeOut, 0, "Should charge redeem fee");
    assertTrue(s.expAmountIncentiveUSDDeposit == 0, "Should calculate deposit incentives");
    assertTrue(s.expAmountIncentiveUSDRedeem == 0, "Should calculate redeem incentives");
    console.log("test_BasicSwap() Preview");
    console.log("Amount Token Out After Fees:", s.expAmountTokenOutAfterFees);
    console.log("Swap Fee In:", s.expSwapFeeIn);
    console.log("Swap Fee Out:", s.expSwapFeeOut);
    console.log("Amount Incentive USD Deposit:", s.expAmountIncentiveUSDDeposit);
    console.log("Amount Incentive USD Redeem:", s.expAmountIncentiveUSDRedeem);
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), s.swapAmount);
    ISuperAsset.SwapArgs memory swapArgs = ISuperAsset.SwapArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: s.swapAmount, tokenOut: address(tokenOut), minTokenOut: s.minTokenOut});
    ISuperAsset.SwapReturnVars memory swapRet = superAsset.swap(swapArgs);
    uint256 sharesStep = swapRet.amountSharesIntermediateStep;
    uint256 tokensOut = swapRet.amountTokenOutAfterFees;
    uint256 swapFeeIn = swapRet.swapFeeIn;
    uint256 swapFeeOut = swapRet.swapFeeOut;
    int256 incentivesIn = swapRet.amountIncentivesIn;
    int256 incentivesOut = swapRet.amountIncentivesOut;
    vm.stopPrank();
    assertGt(sharesStep, 0, "Should create intermediate shares");
    assertGt(tokensOut, 0, "Should receive output tokens");
    assertGt(swapFeeIn, 0, "Should charge deposit fee");
    assertGt(swapFeeOut, 0, "Should charge redeem fee");
    assertTrue(incentivesIn == 0, "Should calculate deposit incentives");
    assertTrue(incentivesOut == 0, "Should calculate redeem incentives");
}
```

## Related Implementations

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

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### log(string,int256)

- **Kind**: internal
- **Source**: 7290:143:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,int256)`

```solidity
function log(string memory p0, int256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,int256)", p0, p1));
}
```

## External Calls

- **Vm::startPrank(address)**
- **Mock4626Vault::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::stopPrank()**
- **Mock4626Vault::balanceOf(address)**
- **SuperAsset::balanceOf(address)**
- **SuperAsset::previewSwap(struct ISuperAsset.PreviewSwapArgs)**
- **SuperAsset::swap(struct ISuperAsset.SwapArgs)**

## State Variable Reads

- **user11** (`address`)
- **tokenOut** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_BasicSwap() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [tokenOut.balanceOf(address(superAsset)), s.swapAmount - ret.swapFee, "Should deposit tokenOut"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superAsset.balanceOf(user11), ret.amountSharesMinted, "Should mint shares"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 3)
  │   💬 Args: [s.isSuccess, true, "isSuccess should be true, because of zero initial allocation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [s.expAmountTokenOutAfterFees, 0, "Should receive output tokens"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [s.expSwapFeeIn, 0, "Should charge deposit fee"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [s.expSwapFeeOut, 0, "Should charge redeem fee"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 7)
  │   💬 Args: [s.expAmountIncentiveUSDDeposit == 0, "Should calculate deposit incentives"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 8)
  │   💬 Args: [s.expAmountIncentiveUSDRedeem == 0, "Should calculate redeem incentives"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 9)
  │   💬 Args: ["test_BasicSwap() Preview"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 10)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 11)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 12)
  │   💬 Args: ["Amount Token Out After Fees:", s.expAmountTokenOutAfterFees]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 13)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 14)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 15)
  │   💬 Args: ["Swap Fee In:", s.expSwapFeeIn]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 16)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 17)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 18)
  │   💬 Args: ["Swap Fee Out:", s.expSwapFeeOut]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,int256) (NodeID: 21)
  │   💬 Args: ["Amount Incentive USD Deposit:", s.expAmountIncentiveUSDDeposit]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 22)
  │     💬 Args: [abi.encodeWithSignature("log(string,int256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 23)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,int256) (NodeID: 24)
  │   💬 Args: ["Amount Incentive USD Redeem:", s.expAmountIncentiveUSDRedeem]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 25)
  │     💬 Args: [abi.encodeWithSignature("log(string,int256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 26)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 27)
  │   💬 Args: [sharesStep, 0, "Should create intermediate shares"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 28)
  │   💬 Args: [tokensOut, 0, "Should receive output tokens"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 29)
  │   💬 Args: [swapFeeIn, 0, "Should charge deposit fee"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 30)
  │   💬 Args: [swapFeeOut, 0, "Should charge redeem fee"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 31)
  │   💬 Args: [incentivesIn == 0, "Should calculate deposit incentives"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 32)
      💬 Args: [incentivesOut == 0, "Should calculate redeem incentives"]
      👁️  Def: internal
```
