# Function: testOracleGasCheckDirectly()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `testOracleGasCheckDirectly()`
- **Visibility**: external
- **Source Range**: 5588:2015:624

## Implementation

```solidity
function testOracleGasCheckDirectly() external view {
    uint256 gasBefore = gasleft();
    console.log("Gas at start:", gasBefore);
    uint256 threshold = gasBefore / 64;
    console.log("Threshold (gasBefore/64):", threshold);
    uint256 maxIterations = 500;
    for (uint256 i = 0; i < maxIterations; i++) {
        uint256 temp = gasleft();
        if (temp <= (threshold + 500)) {
            console.log("Approaching threshold, stopping iterations");
            break;
        }
        assembly {
            let x := add(temp, i)
            let y := mul(x, 2)
            let z := div(y, 3)
            mstore(0x0, z)
        }
    }
    uint256 gasAfter = gasleft();
    console.log("Gas after consumption:", gasAfter);
    console.log("Check condition (gasAfter <= gasBefore/64):", gasAfter <= (gasBefore / 64));
    if (gasleft() <= (gasBefore / 64)) {
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, 0x24b593d900000000000000000000000000000000000000000000000000000000)
            revert(ptr, 4)
        }
    }
    console.log("Gas check passed - threshold not reached");
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

### log(string)

- **Kind**: internal
- **Source**: 6191:121:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.testOracleGasCheckDirectly() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1)
  │   💬 Args: ["Gas at start:", gasBefore]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 4)
  │   💬 Args: ["Threshold (gasBefore/64):", threshold]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 7)
  │   💬 Args: ["Approaching threshold, stopping iterations"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 10)
  │   💬 Args: ["Gas after consumption:", gasAfter]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 11)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 12)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 13)
  │   💬 Args: ["Check condition (gasAfter <= gasBefore/64):", gasAfter <= (gasBefore / 64)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │     💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 16)
      💬 Args: ["Gas check passed - threshold not reached"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 17)
        💬 Args: [abi.encodeWithSignature("log(string)", p0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 18)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```
