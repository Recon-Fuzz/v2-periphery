# Function: test_DemonstrateSlippageIssue_WithLoss()

**Contract**: [test/integration/SuperVault/RedemptionSlippageIssueDemo.t.sol/contract_RedemptionSlippageIssueDemo.md]

## Metadata

- **Contract**: RedemptionSlippageIssueDemo
- **Signature**: `test_DemonstrateSlippageIssue_WithLoss()`
- **Visibility**: public
- **Source Range**: 887:5163:577

## Implementation

```solidity
function test_DemonstrateSlippageIssue_WithLoss() public pure {
    console2.log("\n=== Demonstrating Slippage Issue ===\n");
    uint256 requestedShares = 2000e18;
    uint256 ppsAtRequest = 1.0e18;
    uint16 userSlippageBps = 500;
    console2.log("T0 (Request Time):");
    console2.log("  PPS:", ppsAtRequest / 1e18);
    console2.log("  Shares Requested:", requestedShares / 1e18);
    console2.log("  User Slippage Tolerance:", userSlippageBps, "bps (5%)");
    uint256 expectedAssetsAtRequest = (requestedShares * ppsAtRequest) / PRECISION;
    console2.log("  Expected Assets:", expectedAssetsAtRequest / 1e18);
    uint256 minAssetsOut_Current = computeMinNetOut_Current(requestedShares, ppsAtRequest, userSlippageBps);
    console2.log("  minAssetsOut (anchored to request):", minAssetsOut_Current / 1e18);
    console2.log("\n[Market Event: Underlying vault loses 10%]\n");
    uint256 ppsAtFulfillment = 0.9e18;
    console2.log("T1 (Fulfillment Time):");
    console2.log("  Current PPS:", ppsAtFulfillment / 1e18);
    uint256 theoreticalAssets = (requestedShares * ppsAtFulfillment) / PRECISION;
    console2.log("  Theoretical Assets (at current PPS):", theoreticalAssets / 1e18);
    uint256 totalAssetsOut = 1800e18;
    console2.log("  Actual Assets from executeHooks:", totalAssetsOut / 1e18);
    console2.log("\nBounds Check:");
    console2.log("  minAssetsOut:", minAssetsOut_Current / 1e18);
    console2.log("  totalAssetsOut:", totalAssetsOut / 1e18);
    console2.log("  theoreticalAssets:", theoreticalAssets / 1e18);
    console2.log("  Required: minAssetsOut <= totalAssetsOut <= theoreticalAssets");
    console2.log("  Check:", minAssetsOut_Current / 1e18, "<=", totalAssetsOut / 1e18);
    console2.log("         ", totalAssetsOut / 1e18, "<=", theoreticalAssets / 1e18);
    bool passesCheck = (totalAssetsOut >= minAssetsOut_Current) && (totalAssetsOut <= theoreticalAssets);
    if (!passesCheck) {
        console2.log("\n RESULT: BOUNDS_EXCEEDED - Transaction REVERTS");
        console2.log("  Reason: minAssetsOut (1900) > totalAssetsOut (1800)");
        console2.log("  minAssetsOut is anchored to OLD PPS (1.0), but actual is at NEW PPS (0.9)");
    } else {
        console2.log("\n RESULT: Transaction succeeds");
    }
    console2.log("\n--- Testing with 100% Slippage ---");
    uint16 maxSlippageBps = 10_000;
    uint256 minAssetsOut_MaxSlippage = computeMinNetOut_Current(requestedShares, ppsAtRequest, maxSlippageBps);
    console2.log("  User sets slippageBps:", maxSlippageBps, "(100%)");
    console2.log("  minAssetsOut:", minAssetsOut_MaxSlippage / 1e18);
    console2.log("  This means: Accept ANY outcome, including total loss");
    console2.log("   User has NO protection - 'slippage tolerance' becomes meaningless");
    console2.log("\n=== Alternative: Anchor to Current PPS ===\n");
    uint256 minAssetsOut_Proposed = computeMinNetOut_Proposed(requestedShares, ppsAtFulfillment, userSlippageBps);
    console2.log("  minAssetsOut (anchored to CURRENT PPS):", minAssetsOut_Proposed / 1e18);
    console2.log("  totalAssetsOut:", totalAssetsOut / 1e18);
    console2.log("  theoreticalAssets:", theoreticalAssets / 1e18);
    bool passesProposedCheck = (totalAssetsOut >= minAssetsOut_Proposed) && (totalAssetsOut <= theoreticalAssets);
    console2.log("\n  Bounds Check:", minAssetsOut_Proposed / 1e18, "<=", totalAssetsOut / 1e18);
    console2.log("                ", totalAssetsOut / 1e18, "<=", theoreticalAssets / 1e18);
    if (passesProposedCheck) {
        console2.log("\n RESULT: Transaction succeeds!");
        console2.log("  User gets 1800 assets, which is:");
        console2.log("    - Exactly theoretical at current PPS (100% of current value)");
        console2.log("    - Within 5% slippage tolerance of current market");
        console2.log("    - Fair distribution of the actual loss from underlying vault");
    }
    assertFalse(passesCheck, "Current implementation should FAIL in loss scenario");
    assertTrue(passesProposedCheck, "Proposed implementation should SUCCEED in loss scenario");
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

### log(string,uint256,string)

- **Kind**: internal
- **Source**: 11920:174:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,string)`

```solidity
function log(string memory p0, uint256 p1, string memory p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,string)", p0, p1, p2));
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

### log(string,uint256,string,uint256)

- **Kind**: internal
- **Source**: 33028:198:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,string,uint256)`

```solidity
function log(string memory p0, uint256 p1, string memory p2, uint256 p3) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3));
}
```

### computeMinNetOut_Proposed(uint256,uint256,uint16)

- **Kind**: internal
- **Source**: 11037:376:577
- **Link**: `test/integration/SuperVault/RedemptionSlippageIssueDemo.t.sol:RedemptionSlippageIssueDemo:computeMinNetOut_Proposed(uint256,uint256,uint16)`

```solidity
/// @notice Proposed implementation: anchors to currentPPS
function computeMinNetOut_Proposed(uint256 requestedShares, uint256 currentPPS, uint16 slippageBps) internal pure returns (uint256 minAssetsOut) {
    uint256 expectedAssets = (requestedShares * currentPPS) / PRECISION;
    minAssetsOut = (expectedAssets * (BPS_PRECISION - slippageBps)) / BPS_PRECISION;
}
```

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
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

## State Variable Reads

- **PRECISION** (`uint256`)
- **BPS_PRECISION** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionSlippageIssueDemo.test_DemonstrateSlippageIssue_WithLoss() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["\n=== Demonstrating Slippage Issue ===\n"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 4)
  │   💬 Args: ["T0 (Request Time):"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 7)
  │   💬 Args: ["  PPS:", ppsAtRequest / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 10)
  │   💬 Args: ["  Shares Requested:", requestedShares / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 11)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 12)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,string) (NodeID: 13)
  │   💬 Args: ["  User Slippage Tolerance:", userSlippageBps, "bps (5%)"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string)", p0, p1, p2)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 16)
  │   💬 Args: ["  Expected Assets:", expectedAssetsAtRequest / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 17)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 18)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RedemptionSlippageIssueDemo.computeMinNetOut_Current(uint256,uint256,uint16) (NodeID: 19)
  │   💬 Args: [requestedShares, ppsAtRequest, userSlippageBps]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 20)
  │   💬 Args: ["  minAssetsOut (anchored to request):", minAssetsOut_Current / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 23)
  │   💬 Args: ["\n[Market Event: Underlying vault loses 10%]\n"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 24)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 25)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 26)
  │   💬 Args: ["T1 (Fulfillment Time):"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 27)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 28)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 29)
  │   💬 Args: ["  Current PPS:", ppsAtFulfillment / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 30)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 31)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 32)
  │   💬 Args: ["  Theoretical Assets (at current PPS):", theoreticalAssets / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 33)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 34)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 35)
  │   💬 Args: ["  Actual Assets from executeHooks:", totalAssetsOut / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 36)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 37)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 38)
  │   💬 Args: ["\nBounds Check:"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 39)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 40)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 41)
  │   💬 Args: ["  minAssetsOut:", minAssetsOut_Current / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 42)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 43)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 44)
  │   💬 Args: ["  totalAssetsOut:", totalAssetsOut / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 45)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 46)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 47)
  │   💬 Args: ["  theoreticalAssets:", theoreticalAssets / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 48)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 49)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 50)
  │   💬 Args: ["  Required: minAssetsOut <= totalAssetsOut <= theoreticalAssets"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 51)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 52)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,string,uint256) (NodeID: 53)
  │   💬 Args: ["  Check:", minAssetsOut_Current / 1e18, "<=", totalAssetsOut / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 54)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 55)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,string,uint256) (NodeID: 56)
  │   💬 Args: ["         ", totalAssetsOut / 1e18, "<=", theoreticalAssets / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 57)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 58)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 59)
  │   💬 Args: ["\n RESULT: BOUNDS_EXCEEDED - Transaction REVERTS"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 60)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 61)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 62)
  │   💬 Args: ["  Reason: minAssetsOut (1900) > totalAssetsOut (1800)"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 63)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 64)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 65)
  │   💬 Args: ["  minAssetsOut is anchored to OLD PPS (1.0), but actual is at NEW PPS (0.9)"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 66)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 67)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 68)
  │   💬 Args: ["\n RESULT: Transaction succeeds"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 69)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 70)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 71)
  │   💬 Args: ["\n--- Testing with 100% Slippage ---"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 72)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 73)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RedemptionSlippageIssueDemo.computeMinNetOut_Current(uint256,uint256,uint16) (NodeID: 74)
  │   💬 Args: [requestedShares, ppsAtRequest, maxSlippageBps]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,string) (NodeID: 75)
  │   💬 Args: ["  User sets slippageBps:", maxSlippageBps, "(100%)"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 76)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string)", p0, p1, p2)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 77)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 78)
  │   💬 Args: ["  minAssetsOut:", minAssetsOut_MaxSlippage / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 79)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 80)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 81)
  │   💬 Args: ["  This means: Accept ANY outcome, including total loss"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 82)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 83)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 84)
  │   💬 Args: ["   User has NO protection - 'slippage tolerance' becomes meaningless"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 85)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 86)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 87)
  │   💬 Args: ["\n=== Alternative: Anchor to Current PPS ===\n"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 88)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 89)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RedemptionSlippageIssueDemo.computeMinNetOut_Proposed(uint256,uint256,uint16) (NodeID: 90)
  │   💬 Args: [requestedShares, ppsAtFulfillment, userSlippageBps]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 91)
  │   💬 Args: ["  minAssetsOut (anchored to CURRENT PPS):", minAssetsOut_Proposed / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 92)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 93)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 94)
  │   💬 Args: ["  totalAssetsOut:", totalAssetsOut / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 95)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 96)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 97)
  │   💬 Args: ["  theoreticalAssets:", theoreticalAssets / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 98)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 99)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,string,uint256) (NodeID: 100)
  │   💬 Args: ["\n  Bounds Check:", minAssetsOut_Proposed / 1e18, "<=", totalAssetsOut / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 101)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 102)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,string,uint256) (NodeID: 103)
  │   💬 Args: ["                ", totalAssetsOut / 1e18, "<=", theoreticalAssets / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 104)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 105)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 106)
  │   💬 Args: ["\n RESULT: Transaction succeeds!"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 107)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 108)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 109)
  │   💬 Args: ["  User gets 1800 assets, which is:"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 110)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 111)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 112)
  │   💬 Args: ["    - Exactly theoretical at current PPS (100% of current value)"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 113)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 114)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 115)
  │   💬 Args: ["    - Within 5% slippage tolerance of current market"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 116)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 117)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 118)
  │   💬 Args: ["    - Fair distribution of the actual loss from underlying vault"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 119)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 120)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 121)
  │   💬 Args: [passesCheck, "Current implementation should FAIL in loss scenario"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 122)
      💬 Args: [passesProposedCheck, "Proposed implementation should SUCCEED in loss scenario"]
      👁️  Def: internal
```
