# Function: test_BasicDepositWithInsufficientGasCheck()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_BasicDepositWithInsufficientGasCheck()`
- **Visibility**: public
- **Source Range**: 25199:2482:565

## Implementation

```solidity
function test_BasicDepositWithInsufficientGasCheck() public {
    console.log("test_BasicDepositWithInsufficientGasCheck() Start");
    vm.startPrank(user);
    bytes4 expectedSelector = bytes4(keccak256("INSUFFICIENT_GAS_FOR_EXTERNAL_CALL()"));
    console.log("Expected error selector:");
    console.logBytes4(expectedSelector);
    uint256[] memory gasAmounts = new uint256[](8);
    gasAmounts[0] = 200_000;
    gasAmounts[1] = 150_000;
    gasAmounts[2] = 100_000;
    gasAmounts[3] = 80_000;
    gasAmounts[4] = 60_000;
    gasAmounts[5] = 40_000;
    gasAmounts[6] = 20_000;
    gasAmounts[7] = 10_000;
    for (uint256 i = 0; i < gasAmounts.length; i++) {
        console.log("\n--- Testing with gas:", gasAmounts[i], "---");
        try this.testGasCheckDirectly{gas: gasAmounts[i]}() {
            console.log("Call succeeded - no gas check triggered");
        } catch (bytes memory reason) {
            console.log("Call reverted");
            console.log("Error length:", reason.length);
            if (reason.length >= 4) {
                bytes4 actualSelector;
                assembly {
                    actualSelector := mload(add(reason, 0x20))
                }
                console.log("Actual error selector:");
                console.logBytes4(actualSelector);
                if (actualSelector == expectedSelector) {
                    console.log("SUCCESS: INSUFFICIENT_GAS_FOR_EXTERNAL_CALL triggered at gas:", gasAmounts[i]);
                    vm.stopPrank();
                    return;
                } else {
                    console.log("Different error received");
                }
            } else {
                console.log("Empty error - likely out of gas");
            }
            console.logBytes(reason);
        }
    }
    console.log("Test completed - check results above");
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

### logBytes4(bytes4)

- **Kind**: internal
- **Source**: 2226:120:26
- **Link**: `lib/forge-std/src/console.sol:console:logBytes4(bytes4)`

```solidity
function logBytes4(bytes4 p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(bytes4)", p0));
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### logBytes(bytes)

- **Kind**: internal
- **Source**: 1718:124:26
- **Link**: `lib/forge-std/src/console.sol:console:logBytes(bytes)`

```solidity
function logBytes(bytes memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(bytes)", p0));
}
```

## External Calls

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_BasicDepositWithInsufficientGasCheck() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["test_BasicDepositWithInsufficientGasCheck() Start"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 4)
  │   💬 Args: ["Expected error selector:"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.logBytes4(bytes4) (NodeID: 7)
  │   💬 Args: [expectedSelector]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(bytes4)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256,string) (NodeID: 10)
  │   💬 Args: ["\n--- Testing with gas:", gasAmounts[i], "---"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 11)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string)", p0, p1, p2)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 12)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 13)
  │   💬 Args: ["Call succeeded - no gas check triggered"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 16)
  │   💬 Args: ["Call reverted"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 17)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 18)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 19)
  │   💬 Args: ["Error length:", reason.length]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 20)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 21)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 22)
  │   💬 Args: ["Actual error selector:"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 23)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 24)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.logBytes4(bytes4) (NodeID: 25)
  │   💬 Args: [actualSelector]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 26)
  │     💬 Args: [abi.encodeWithSignature("log(bytes4)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 27)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 28)
  │   💬 Args: ["SUCCESS: INSUFFICIENT_GAS_FOR_EXTERNAL_CALL triggered at gas:", gasAmounts[i]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 29)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 30)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 31)
  │   💬 Args: ["Different error received"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 32)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 33)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 34)
  │   💬 Args: ["Empty error - likely out of gas"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 35)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 36)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.logBytes(bytes) (NodeID: 37)
  │   💬 Args: [reason]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 38)
  │     💬 Args: [abi.encodeWithSignature("log(bytes)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 39)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 40)
      💬 Args: ["Test completed - check results above"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 41)
        💬 Args: [abi.encodeWithSignature("log(string)", p0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 42)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```
