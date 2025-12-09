# Function: test_ShowWorkaroundLimitations()

**Contract**: [test/integration/SuperVault/RedemptionSlippageIssueDemo.t.sol/contract_RedemptionSlippageIssueDemo.md]

## Metadata

- **Contract**: RedemptionSlippageIssueDemo
- **Signature**: `test_ShowWorkaroundLimitations()`
- **Visibility**: public
- **Source Range**: 8287:2037:577

## Implementation

```solidity
function test_ShowWorkaroundLimitations() public pure {
    console2.log("\n=== Demonstrating Workaround Limitations ===\n");
    uint256 requestedShares = 1000e18;
    uint256 ppsAtRequest = 1.0e18;
    uint256 ppsAtFulfillment = 0.85e18;
    uint256 theoreticalAssets = (requestedShares * ppsAtFulfillment) / PRECISION;
    uint256 totalAssetsOut = 850e18;
    console2.log("Scenario: 15% loss in underlying vault");
    console2.log("  PPS dropped from 1.0 to 0.85");
    console2.log("  User's shares worth: 850 assets\n");
    console2.log("User tries different slippage tolerances:\n");
    uint16[] memory slippageValues = new uint16[](5);
    slippageValues[0] = 500;
    slippageValues[1] = 1000;
    slippageValues[2] = 2000;
    slippageValues[3] = 5000;
    slippageValues[4] = 10_000;
    for (uint256 i = 0; i < slippageValues.length; i++) {
        uint16 slippage = slippageValues[i];
        uint256 minOut = computeMinNetOut_Current(requestedShares, ppsAtRequest, slippage);
        bool passes = (totalAssetsOut >= minOut) && (totalAssetsOut <= theoreticalAssets);
        console2.log("  Slippage:", slippage, unicode"bps →", "minAssetsOut:");
        console2.log("           ", minOut / 1e18, unicode"→", passes ? " PASS" : " FAIL");
    }
    console2.log("\n Insight:");
    console2.log("  - Slippage < 15%: Transaction fails (minAssetsOut > 850)");
    console2.log("  - Slippage = 15%: minAssetsOut = 850, barely passes");
    console2.log("  - Slippage > 15%: User must accept MORE loss than necessary");
    console2.log("  - Slippage = 100%: minAssetsOut = 0, complete loss of protection");
    console2.log("\n   User cannot set 'reasonable' slippage for current market conditions");
    console2.log("     They must either accept the transaction fails OR remove all protection");
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

### computeMinNetOut_Current(uint256,uint256,uint16)

- **Kind**: internal
- **Source**: 10579:389:577
- **Link**: `test/integration/SuperVault/RedemptionSlippageIssueDemo.t.sol:RedemptionSlippageIssueDemo:computeMinNetOut_Current(uint256,uint256,uint16)`

```solidity
/// @notice Current implementation: anchors to averageRequestPPS
function computeMinNetOut_Current(uint256 requestedShares, uint256 averageRequestPPS, uint16 slippageBps) internal pure returns (uint256 minAssetsOut) {
    uint256 expectedAssets = (requestedShares * averageRequestPPS) / PRECISION;
    minAssetsOut = (expectedAssets * (BPS_PRECISION - slippageBps)) / BPS_PRECISION;
}
```

### log(string,uint256,string,string)

- **Kind**: internal
- **Source**: 33232:203:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,string,string)`

```solidity
function log(string memory p0, uint256 p1, string memory p2, string memory p3) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,string,string)", p0, p1, p2, p3));
}
```

## State Variable Reads

- **PRECISION** (`uint256`)
- **BPS_PRECISION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionSlippageIssueDemo.test_ShowWorkaroundLimitations() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["\n=== Demonstrating Workaround Limitations ===\n"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 4)
  │   💬 Args: ["Scenario: 15% loss in underlying vault"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 7)
  │   💬 Args: ["  PPS dropped from 1.0 to 0.85"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 10)
  │   💬 Args: ["  User's shares worth: 850 assets\n"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 11)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 12)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 13)
  │   💬 Args: ["User tries different slippage tolerances:\n"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RedemptionSlippageIssueDemo.computeMinNetOut_Current(uint256,uint256,uint16) (NodeID: 16)
  │   💬 Args: [requestedShares, ppsAtRequest, slippage]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,string,string) (NodeID: 17)
  │   💬 Args: ["  Slippage:", slippage, unicode"bps →", "minAssetsOut:"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 18)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,string)", p0, p1, p2, p3)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 19)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,string,string) (NodeID: 20)
  │   💬 Args: ["           ", minOut / 1e18, unicode"→", passes ? " PASS" : " FAIL"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,string)", p0, p1, p2, p3)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 23)
  │   💬 Args: ["\n Insight:"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 24)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 25)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 26)
  │   💬 Args: ["  - Slippage < 15%: Transaction fails (minAssetsOut > 850)"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 27)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 28)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 29)
  │   💬 Args: ["  - Slippage = 15%: minAssetsOut = 850, barely passes"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 30)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 31)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 32)
  │   💬 Args: ["  - Slippage > 15%: User must accept MORE loss than necessary"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 33)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 34)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 35)
  │   💬 Args: ["  - Slippage = 100%: minAssetsOut = 0, complete loss of protection"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 36)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 37)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 38)
  │   💬 Args: ["\n   User cannot set 'reasonable' slippage for current market conditions"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 39)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 40)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 41)
      💬 Args: ["     They must either accept the transaction fails OR remove all protection"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 42)
        💬 Args: [abi.encodeWithSignature("log(string)", p0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 43)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```
