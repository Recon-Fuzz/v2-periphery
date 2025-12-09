# Function: latestRoundData()

**Contract**: [test/mocks/MockFeedWithRealData.sol/contract_MockFeedWithRealData.md]

## Metadata

- **Contract**: MockFeedWithRealData
- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 659:410:592

## Implementation

```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
    console2.log("latestRoundData ------ block.timestamp", block.timestamp);
    (roundId, answer, startedAt, updatedAt, answeredInRound) = AggregatorV3Interface(feed).latestRoundData();
    updatedAt = block.timestamp;
}
```

## Related Implementations

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
- **Source**: 851:129:26
- **Link**: `lib/forge-std/src/console.sol:console:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castToPure(_sendLogPayloadImplementation)(payload);
}
```

### _castToPure(function (bytes)

- **Kind**: internal
- **Source**: 649:196:26
- **Link**: `lib/forge-std/src/console.sol:console:_castToPure(function (bytes) view)`

```solidity
function _castToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

## External Calls

- **AggregatorV3Interface::latestRoundData()**

## State Variable Reads

- **feed** (`contract AggregatorV3Interface`) [src/vendor/chainlink/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFeedWithRealData.latestRoundData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1)
      💬 Args: ["latestRoundData ------ block.timestamp", block.timestamp]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: console._sendLogPayload(bytes) (NodeID: 2)
        💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: console._castToPure(function (bytes) view) (NodeID: 3)
          💬 Args: [_sendLogPayloadImplementation]
          👁️  Def: internal
```
