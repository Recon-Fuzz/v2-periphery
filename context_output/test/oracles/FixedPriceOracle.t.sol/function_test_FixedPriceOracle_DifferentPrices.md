# Function: test_FixedPriceOracle_DifferentPrices()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_DifferentPrices()`
- **Visibility**: public
- **Source Range**: 8863:1122:623

## Implementation

```solidity
/// @notice Test with different UP prices to understand token economics
function test_FixedPriceOracle_DifferentPrices() public {
    console2.log("=== UP Token Cost at Different Prices ===");
    console2.log("(For 10k gas at 30 gwei, ETH=$2500 = $0.75 cost)");
    console2.log("");
    int256[] memory prices = new int256[](5);
    prices[0] = 0.05e18;
    prices[1] = 0.09e18;
    prices[2] = 0.1e18;
    prices[3] = 0.5e18;
    prices[4] = 1.0e18;
    uint256 usdCost = 0.75e18;
    for (uint256 i = 0; i < prices.length; i++) {
        fixedPriceOracle.setPrice(prices[i]);
        uint256 requiredUp = (usdCost * 1e18) / uint256(prices[i]);
        uint256 priceInCents = uint256(prices[i]) / 1e16;
        uint256 upWhole = requiredUp / 1e18;
        uint256 upFrac = (requiredUp % 1e18) / 1e14;
        console2.log("UP Price: $0.%s", priceInCents);
        console2.log("  UP tokens needed: %s.%s", upWhole, upFrac);
        console2.log("");
    }
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### log(string,uint256,uint256)

- **Kind**: internal
- **Source**: 11745:169:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,uint256)`

```solidity
function log(string memory p0, uint256 p1, uint256 p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2));
}
```

## External Calls

- **FixedPriceOracle::setPrice(int256)**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_DifferentPrices() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["=== UP Token Cost at Different Prices ==="]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 4)
  │   💬 Args: ["(For 10k gas at 30 gwei, ETH=$2500 = $0.75 cost)"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 7)
  │   💬 Args: [""]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 10)
  │   💬 Args: ["UP Price: $0.%s", priceInCents]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 11)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 12)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 13)
  │   💬 Args: ["  UP tokens needed: %s.%s", upWhole, upFrac]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 16)
      💬 Args: [""]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 17)
        💬 Args: [abi.encodeWithSignature("log(string)", p0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 18)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test with different UP prices to understand token economics
