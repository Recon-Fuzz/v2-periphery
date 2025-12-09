# Function: test_MultiUserDepositRedeemSequence()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_MultiUserDepositRedeemSequence()`
- **Visibility**: public
- **Source Range**: 60429:2153:565

## Implementation

```solidity
function test_MultiUserDepositRedeemSequence() public {
    uint256 deposit1 = 100e18;
    uint256 deposit2 = 200e18;
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), deposit1);
    ISuperAsset.DepositArgs memory depositArgs1 = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: deposit1, minSharesOut: 0});
    console.log("TokenIn = ", address(tokenIn));
    console.log("TokenOut = ", address(tokenOut));
    console.log("SuperAsset Shares = ", address(superAsset));
    ISuperAsset.DepositReturnVars memory ret1 = superAsset.deposit(depositArgs1);
    vm.stopPrank();
    vm.startPrank(user11);
    tokenOut.approve(address(superAsset), deposit2);
    ISuperAsset.DepositArgs memory depositArgs2 = ISuperAsset.DepositArgs({receiver: user11, tokenIn: address(tokenOut), amountTokenToDeposit: deposit2, minSharesOut: 0});
    ISuperAsset.DepositReturnVars memory ret2 = superAsset.deposit(depositArgs2);
    vm.stopPrank();
    assertEq(superAsset.balanceOf(user), ret1.amountSharesMinted, "User should have correct shares");
    assertEq(superAsset.balanceOf(user11), ret2.amountSharesMinted, "User11 should have correct shares");
    vm.startPrank(user);
    uint256 redeemAmount = ret1.amountSharesMinted / 2;
    ISuperAsset.RedeemArgs memory redeemArgs = ISuperAsset.RedeemArgs({receiver: user, amountSharesToRedeem: redeemAmount, tokenOut: address(tokenIn), minTokenOut: 0});
    ISuperAsset.RedeemReturnVars memory redeemRet = superAsset.redeem(redeemArgs);
    vm.stopPrank();
    assertEq(superAsset.balanceOf(user), ret1.amountSharesMinted - redeemAmount, "User should have remaining shares");
    assertGt(redeemRet.amountTokenOutAfterFees, 0, "User should receive tokens");
}
```

## Related Implementations

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
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

## External Calls

- **Vm::startPrank(address)**
- **Mock4626Vault::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::stopPrank()**
- **SuperAsset::balanceOf(address)**
- **SuperAsset::redeem(struct ISuperAsset.RedeemArgs)**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **tokenOut** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **user11** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_MultiUserDepositRedeemSequence() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 1)
  │   💬 Args: ["TokenIn = ", address(tokenIn)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 4)
  │   💬 Args: ["TokenOut = ", address(tokenOut)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 7)
  │   💬 Args: ["SuperAsset Shares = ", address(superAsset)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [superAsset.balanceOf(user), ret1.amountSharesMinted, "User should have correct shares"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [superAsset.balanceOf(user11), ret2.amountSharesMinted, "User11 should have correct shares"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [superAsset.balanceOf(user), ret1.amountSharesMinted - redeemAmount, "User should have remaining shares"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 13)
      💬 Args: [redeemRet.amountTokenOutAfterFees, 0, "User should receive tokens"]
      👁️  Def: internal
```
