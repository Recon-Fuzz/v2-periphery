# Function: test_ShowAsymmetricRiskProfile()

**Contract**: [test/integration/SuperVault/RedemptionSlippageIssueDemo.t.sol/contract_RedemptionSlippageIssueDemo.md]

## Metadata

- **Contract**: RedemptionSlippageIssueDemo
- **Signature**: `test_ShowAsymmetricRiskProfile()`
- **Visibility**: public
- **Source Range**: 6056:2225:577

## Implementation

```solidity
function test_ShowAsymmetricRiskProfile() public pure {
    console2.log("\n=== Demonstrating Asymmetric Risk Profile ===\n");
    uint256 requestedShares = 1000e18;
    uint256 ppsAtRequest = 1.0e18;
    uint16 userSlippageBps = 500;
    uint256 minAssetsOut = computeMinNetOut_Current(requestedShares, ppsAtRequest, userSlippageBps);
    console2.log("Scenario A: PPS Increases to 1.1");
    uint256 ppsIncrease = 1.1e18;
    uint256 theoreticalA = (requestedShares * ppsIncrease) / PRECISION;
    uint256 totalAssetsOutA = 1100e18;
    console2.log("  minAssetsOut:", minAssetsOut / 1e18);
    console2.log("  totalAssetsOut:", totalAssetsOutA / 1e18);
    console2.log("  theoreticalAssets:", theoreticalA / 1e18);
    bool passesA = (totalAssetsOutA >= minAssetsOut) && (totalAssetsOutA <= theoreticalA);
    console2.log("  Result:", passesA ? " PASSES" : " FAILS");
    console2.log("  User gets UPSIDE (1100 instead of 1000)\n");
    console2.log("Scenario B: PPS Decreases to 0.9");
    uint256 ppsDecrease = 0.9e18;
    uint256 theoreticalB = (requestedShares * ppsDecrease) / PRECISION;
    uint256 totalAssetsOutB = 900e18;
    console2.log("  minAssetsOut:", minAssetsOut / 1e18);
    console2.log("  totalAssetsOut:", totalAssetsOutB / 1e18);
    console2.log("  theoreticalAssets:", theoreticalB / 1e18);
    bool passesB = (totalAssetsOutB >= minAssetsOut) && (totalAssetsOutB <= theoreticalB);
    console2.log("  Result:", passesB ? " PASSES" : " FAILS");
    console2.log("  Transaction REVERTS - user cannot exit even with fair loss distribution");
    console2.log("\n Summary:");
    console2.log(unicode" Price UP   → User gets upside ");
    console2.log(unicode" Price DOWN → Transaction fails");
    console2.log(" This is asymmetric: heads you win, tails the system breaks");
    assertTrue(passesA, "Should pass when PPS increases");
    assertFalse(passesB, "Should fail when PPS decreases (demonstrating the issue)");
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### log(string,string)

- **Kind**: internal
- **Source**: 7439:150:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,string)`

```solidity
function log(string memory p0, string memory p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,string)", p0, p1));
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

## State Variable Reads

- **PRECISION** (`uint256`)
- **BPS_PRECISION** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionSlippageIssueDemo.test_ShowAsymmetricRiskProfile() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["\n=== Demonstrating Asymmetric Risk Profile ===\n"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RedemptionSlippageIssueDemo.computeMinNetOut_Current(uint256,uint256,uint16) (NodeID: 4)
  │   💬 Args: [requestedShares, ppsAtRequest, userSlippageBps]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 5)
  │   💬 Args: ["Scenario A: PPS Increases to 1.1"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 6)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 7)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 8)
  │   💬 Args: ["  minAssetsOut:", minAssetsOut / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 11)
  │   💬 Args: ["  totalAssetsOut:", totalAssetsOutA / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 12)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 13)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 14)
  │   💬 Args: ["  theoreticalAssets:", theoreticalA / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 15)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 16)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,string) (NodeID: 17)
  │   💬 Args: ["  Result:", passesA ? " PASSES" : " FAILS"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 18)
  │     💬 Args: [abi.encodeWithSignature("log(string,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 19)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 20)
  │   💬 Args: ["  User gets UPSIDE (1100 instead of 1000)\n"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 23)
  │   💬 Args: ["Scenario B: PPS Decreases to 0.9"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 24)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 25)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 26)
  │   💬 Args: ["  minAssetsOut:", minAssetsOut / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 27)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 28)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 29)
  │   💬 Args: ["  totalAssetsOut:", totalAssetsOutB / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 30)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 31)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 32)
  │   💬 Args: ["  theoreticalAssets:", theoreticalB / 1e18]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 33)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 34)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,string) (NodeID: 35)
  │   💬 Args: ["  Result:", passesB ? " PASSES" : " FAILS"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 36)
  │     💬 Args: [abi.encodeWithSignature("log(string,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 37)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 38)
  │   💬 Args: ["  Transaction REVERTS - user cannot exit even with fair loss distribution"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 39)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 40)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 41)
  │   💬 Args: ["\n Summary:"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 42)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 43)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 44)
  │   💬 Args: [unicode" Price UP   → User gets upside "]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 45)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 46)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 47)
  │   💬 Args: [unicode" Price DOWN → Transaction fails"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 48)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 49)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 50)
  │   💬 Args: [" This is asymmetric: heads you win, tails the system breaks"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 51)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 52)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 53)
  │   💬 Args: [passesA, "Should pass when PPS increases"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 54)
      💬 Args: [passesB, "Should fail when PPS decreases (demonstrating the issue)"]
      👁️  Def: internal
```
