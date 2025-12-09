# Function: test_BasicDepositSimple()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_BasicDepositSimple()`
- **Visibility**: public
- **Source Range**: 20811:3263:565

## Implementation

```solidity
function test_BasicDepositSimple() public {
    console.log("test_BasicDepositSimple() Start");
    uint256 depositAmount = 100e18;
    uint256 minSharesOut = 99e18;
    underlyingToken1.mint(user, depositAmount);
    vm.startPrank(user);
    assertEq(underlyingToken1.balanceOf(user), depositAmount);
    underlyingToken1.approve(address(superAsset), depositAmount);
    ISuperAsset.PreviewDepositArgs memory previewDepositArgs = ISuperAsset.PreviewDepositArgs({tokenIn: address(underlyingToken1), amountTokenToDeposit: depositAmount, isSoft: false});
    ISuperAsset.PreviewDepositReturnVars memory previewDepositRet = superAsset.previewDeposit(previewDepositArgs);
    console.log("Oracle Price USD:", previewDepositRet.oraclePriceUSD);
    console.log("Is Depeg:", previewDepositRet.isDepeg);
    console.log("Is Dispersion:", previewDepositRet.isDispersion);
    console.log("Is Oracle Off:", previewDepositRet.isOracleOff);
    console.log("Token In Found:", previewDepositRet.tokenInFound);
    console.log("Incentive Calculation Success:", previewDepositRet.incentiveCalculationSuccess);
    bool isSuccess = ((((previewDepositRet.oraclePriceUSD != 0) && (!previewDepositRet.isDepeg)) && (!previewDepositRet.isDispersion)) && (!previewDepositRet.isOracleOff)) && previewDepositRet.tokenInFound;
    assertEq(isSuccess, true, "isSuccess should be true, because of zero initial allocation");
    uint256 b1 = tokenIn.balanceOf(address(superBank));
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(underlyingToken1), amountTokenToDeposit: depositAmount, minSharesOut: minSharesOut});
    console.log("test_BasicDepositSimple() Pre-Deposit");
    ISuperAsset.DepositReturnVars memory ret = superAsset.deposit(depositArgs);
    console.log("test_BasicDepositSimple() Post-Deposit");
    vm.stopPrank();
    assertEq(underlyingToken1.balanceOf(address(superBank)) - b1, ret.swapFee, "SuperBank should receive the swap fee");
    assertEq(previewDepositRet.amountSharesMinted, ret.amountSharesMinted, "Actual shares minted should match preview");
    assertEq(previewDepositRet.swapFee, ret.swapFee, "Actual swap fee should match preview");
    assertEq(previewDepositRet.amountIncentiveUSDDeposit, ret.amountIncentiveUSDDeposit, "Actual incentive should match preview");
    assertGt(ret.amountSharesMinted, 0, "Should mint shares");
    assertEq(ret.swapFee, (depositAmount * superAsset.swapFeeInPercentage()) / superAsset.SWAP_FEE_PERC(), "Incorrect swap fee");
    assertTrue(superAsset.balanceOf(user) > 0, "User should have shares");
}
```

## Related Implementations

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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### log(string,bool)

- **Kind**: internal
- **Source**: 7595:139:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,bool)`

```solidity
function log(string memory p0, bool p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,bool)", p0, p1));
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

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::balanceOf(address)**
- **MockERC20::approve(address,uint256)**
- **SuperAsset::previewDeposit(struct ISuperAsset.PreviewDepositArgs)**
- **Mock4626Vault::balanceOf(address)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::stopPrank()**
- **SuperAsset::swapFeeInPercentage()**
- **SuperAsset::SWAP_FEE_PERC()**
- **SuperAsset::balanceOf(address)**

## State Variable Reads

- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_BasicDepositSimple() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["test_BasicDepositSimple() Start"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [underlyingToken1.balanceOf(user), depositAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 5)
  │   💬 Args: ["Oracle Price USD:", previewDepositRet.oraclePriceUSD]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 6)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 7)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 8)
  │   💬 Args: ["Is Depeg:", previewDepositRet.isDepeg]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │     💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 11)
  │   💬 Args: ["Is Dispersion:", previewDepositRet.isDispersion]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 12)
  │     💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 13)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 14)
  │   💬 Args: ["Is Oracle Off:", previewDepositRet.isOracleOff]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 15)
  │     💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 16)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 17)
  │   💬 Args: ["Token In Found:", previewDepositRet.tokenInFound]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 18)
  │     💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 19)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 20)
  │   💬 Args: ["Incentive Calculation Success:", previewDepositRet.incentiveCalculationSuccess]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │     💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 23)
  │   💬 Args: [isSuccess, true, "isSuccess should be true, because of zero initial allocation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 24)
  │   💬 Args: ["test_BasicDepositSimple() Pre-Deposit"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 25)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 26)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 27)
  │   💬 Args: ["test_BasicDepositSimple() Post-Deposit"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 28)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 29)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 30)
  │   💬 Args: [underlyingToken1.balanceOf(address(superBank)) - b1, ret.swapFee, "SuperBank should receive the swap fee"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 31)
  │   💬 Args: [previewDepositRet.amountSharesMinted, ret.amountSharesMinted, "Actual shares minted should match preview"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 32)
  │   💬 Args: [previewDepositRet.swapFee, ret.swapFee, "Actual swap fee should match preview"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256,string) (NodeID: 33)
  │   💬 Args: [previewDepositRet.amountIncentiveUSDDeposit, ret.amountIncentiveUSDDeposit, "Actual incentive should match preview"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 34)
  │   💬 Args: [ret.amountSharesMinted, 0, "Should mint shares"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 35)
  │   💬 Args: [ret.swapFee, (depositAmount * superAsset.swapFeeInPercentage()) / superAsset.SWAP_FEE_PERC(), "Incorrect swap fee"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 36)
      💬 Args: [superAsset.balanceOf(user) > 0, "User should have shares"]
      👁️  Def: internal
```
