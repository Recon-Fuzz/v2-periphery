# Function: setData(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `setData(uint256)`
- **Visibility**: external
- **Source Range**: 1755:382:165

## Implementation

```solidity
function setData(uint256 value) external {
    valueStored = value;
    if (isExecutor) {
        IERC7579Account(msg.sender).executeFromExecutor(ExecLib.encodeSimpleSingle(), ExecLib.encodeSingle(address(callee), 0, abi.encodeWithSelector(Callee.calleeTest.selector)));
    }
}
```

## Related Implementations

### encodeSimpleSingle()

- **Kind**: internal
- **Source**: 7150:192:163
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/kernel/lib/ExecLib.sol:ExecLib:encodeSimpleSingle()`

```solidity
function encodeSimpleSingle() internal pure returns (ExecMode mode) {
    mode = encode(CALLTYPE_SINGLE, EXECTYPE_DEFAULT, EXEC_MODE_DEFAULT, ExecModePayload.wrap(0x00));
}
```

### encode(CallType,ExecType,ExecModeSelector,ExecModePayload)

- **Kind**: internal
- **Source**: 6522:426:163
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/kernel/lib/ExecLib.sol:ExecLib:encode(CallType,ExecType,ExecModeSelector,ExecModePayload)`

```solidity
function encode(CallType callType, ExecType execType, ExecModeSelector mode, ExecModePayload payload) internal pure returns (ExecMode) {
    return ExecMode.wrap(bytes32(abi.encodePacked(callType, execType, bytes4(0), ExecModeSelector.unwrap(mode), payload)));
}
```

### encodeSingle(address,uint256,bytes)

- **Kind**: internal
- **Source**: 8824:261:163
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/kernel/lib/ExecLib.sol:ExecLib:encodeSingle(address,uint256,bytes)`

```solidity
function encodeSingle(address target, uint256 value, bytes memory callData) internal pure returns (bytes memory userOpCalldata) {
    userOpCalldata = abi.encodePacked(target, value, callData);
}
```

## External Calls

- **IERC7579Account::executeFromExecutor(ExecMode,bytes)**

## State Variable Reads

- **isExecutor** (`bool`)
- **callee** (`contract Callee`) [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_Callee.md]

## State Variable Writes

- **valueStored** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFallback.setData(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ExecLib.encodeSimpleSingle() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ExecLib.encode(CallType,ExecType,ExecModeSelector,ExecModePayload) (NodeID: 2)
  │     💬 Args: [CALLTYPE_SINGLE, EXECTYPE_DEFAULT, EXEC_MODE_DEFAULT, ExecModePayload.wrap(0x00)]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ExecLib.encodeSingle(address,uint256,bytes) (NodeID: 3)
      💬 Args: [address(callee), 0, abi.encodeWithSelector(Callee.calleeTest.selector)]
      👁️  Def: internal
```
