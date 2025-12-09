# Function: test_SequentialPriceUpdates()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_SequentialPriceUpdates()`
- **Visibility**: public
- **Source Range**: 68400:1999:565

## Implementation

```solidity
function test_SequentialPriceUpdates() public {
    uint256 depositAmount = 100e18;
    underlyingToken1.mint(user, 2 * depositAmount);
    vm.startPrank(user);
    underlyingToken1.approve(address(superAsset), depositAmount);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(underlyingToken1), amountTokenToDeposit: depositAmount, minSharesOut: 0});
    ISuperAsset.DepositReturnVars memory ret1 = superAsset.deposit(depositArgs);
    (, int256 currentPrice, , , ) = mockFeed1.latestRoundData();
    mockFeed1.setAnswer((currentPrice * 102) / 100);
    mockFeed2.setAnswer((currentPrice * 102) / 100);
    mockFeed3.setAnswer((currentPrice * 102) / 100);
    _updateAllFeedTimestamps();
    underlyingToken1.approve(address(superAsset), depositAmount);
    ISuperAsset.DepositReturnVars memory ret2 = superAsset.deposit(depositArgs);
    console.log("ret1.amountSharesMinted = ", ret1.amountSharesMinted);
    console.log("ret2.amountSharesMinted = ", ret2.amountSharesMinted);
    assertTrue(ret1.amountSharesMinted == ret2.amountSharesMinted, "Price updates should affect share calculations");
    vm.stopPrank();
}
```

## Related Implementations

### _updateAllFeedTimestamps()

- **Kind**: internal
- **Source**: 4273:618:565
- **Link**: `test/draft/test/integration/SuperAsset/SuperAsset.t.sol:SuperAssetTest:_updateAllFeedTimestamps()`

```solidity
function _updateAllFeedTimestamps() internal {
    mockFeedSuperAssetShares1.setUpdatedAt(block.timestamp);
    mockFeedPrimaryAsset.setUpdatedAt(block.timestamp);
    mockFeed1.setUpdatedAt(block.timestamp);
    mockFeed2.setUpdatedAt(block.timestamp);
    mockFeed3.setUpdatedAt(block.timestamp);
    mockFeed4.setUpdatedAt(block.timestamp);
    mockFeed5.setUpdatedAt(block.timestamp);
    mockFeed6.setUpdatedAt(block.timestamp);
    mockFeed7.setUpdatedAt(block.timestamp);
    mockFeed8.setUpdatedAt(block.timestamp);
    mockFeed9.setUpdatedAt(block.timestamp);
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
- **MockERC20::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **MockAggregator::latestRoundData()**
- **MockAggregator::setAnswer(int256)**
- **Vm::stopPrank()**

## State Variable Reads

- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeedSuperAssetShares1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeedPrimaryAsset** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed5** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed6** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed7** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed8** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed9** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_SequentialPriceUpdates() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperAssetTest._updateAllFeedTimestamps() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 2)
  │   💬 Args: ["ret1.amountSharesMinted = ", ret1.amountSharesMinted]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 3)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 4)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 5)
  │   💬 Args: ["ret2.amountSharesMinted = ", ret2.amountSharesMinted]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 6)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 7)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 8)
      💬 Args: [ret1.amountSharesMinted == ret2.amountSharesMinted, "Price updates should affect share calculations"]
      👁️  Def: internal
```
