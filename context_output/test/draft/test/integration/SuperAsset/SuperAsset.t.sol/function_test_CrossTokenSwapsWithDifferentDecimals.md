# Function: test_CrossTokenSwapsWithDifferentDecimals()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_CrossTokenSwapsWithDifferentDecimals()`
- **Visibility**: public
- **Source Range**: 62588:1934:565

## Implementation

```solidity
function test_CrossTokenSwapsWithDifferentDecimals() public {
    vm.startPrank(admin);
    superAsset.whitelistERC20(address(underlyingToken6d));
    vm.stopPrank();
    console.log("test_CrossTokenSwapsWithDifferentDecimals() Start");
    address liquidityProvider = user11;
    uint256 LPingAmount = 100_000_000e6;
    underlyingToken6d.mint(liquidityProvider, LPingAmount);
    uint256 swapAmount = 10e18;
    vm.startPrank(liquidityProvider);
    underlyingToken6d.approve(address(superAsset), LPingAmount);
    ISuperAsset.DepositArgs memory liquidityArgs = ISuperAsset.DepositArgs({receiver: liquidityProvider, tokenIn: address(underlyingToken6d), amountTokenToDeposit: LPingAmount, minSharesOut: 0});
    superAsset.deposit(liquidityArgs);
    vm.stopPrank();
    console.log("test_CrossTokenSwapsWithDifferentDecimals() LPing Done");
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), swapAmount);
    ISuperAsset.SwapArgs memory swapArgs = ISuperAsset.SwapArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: swapAmount, tokenOut: address(underlyingToken6d), minTokenOut: 0});
    ISuperAsset.SwapReturnVars memory swapRet = superAsset.swap(swapArgs);
    assertGt(swapRet.amountTokenOutAfterFees, 0, "Should receive volatile tokens");
    assertGt(swapRet.swapFeeIn, 0, "Should pay input fee");
    assertGt(swapRet.swapFeeOut, 0, "Should pay output fee");
    vm.stopPrank();
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
- **SuperAsset::whitelistERC20(address)**
- **Vm::stopPrank()**
- **MockERC20::mint(address,uint256)**
- **MockERC20::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Mock4626Vault::approve(address,uint256)**
- **SuperAsset::swap(struct ISuperAsset.SwapArgs)**

## State Variable Reads

- **admin** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **underlyingToken6d** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user11** (`address`)
- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_CrossTokenSwapsWithDifferentDecimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["test_CrossTokenSwapsWithDifferentDecimals() Start"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 4)
  │   💬 Args: ["test_CrossTokenSwapsWithDifferentDecimals() LPing Done"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [swapRet.amountTokenOutAfterFees, 0, "Should receive volatile tokens"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [swapRet.swapFeeIn, 0, "Should pay input fee"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 9)
      💬 Args: [swapRet.swapFeeOut, 0, "Should pay output fee"]
      👁️  Def: internal
```
