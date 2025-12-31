# Function: exec(address,address,uint256,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockExecutor.sol/contract_MockExecutor.md]

## Metadata

- **Contract**: MockExecutor
- **Signature**: `exec(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 453:235:219

## Implementation

```solidity
function exec(address account, address to, uint256 value, bytes calldata callData) external returns (bytes memory) {
    return _execute(account, to, value, callData);
}
```

## Related Implementations

### _execute(address,address,uint256,bytes)

- **Kind**: internal
- **Source**: 781:558:201
- **Link**: `lib/v2-core/lib/modulekit/src/module-bases/ERC7579ExecutorBase.sol:ERC7579ExecutorBase:_execute(address,address,uint256,bytes)`

```solidity
function _execute(address account, address to, uint256 value, bytes memory data) internal returns (bytes memory result) {
    ModeCode modeCode = ERC7579ModeLib.encode({callType: CALLTYPE_SINGLE, execType: EXECTYPE_DEFAULT, mode: MODE_DEFAULT, payload: ModePayload.wrap(bytes22(0))});
    return IERC7579Account(account).executeFromExecutor(modeCode, ERC7579ExecutionLib.encodeSingle(to, value, data))[0];
}
```

### encode(CallType,ExecType,ModeSelector,ModePayload)

- **Kind**: internal
- **Source**: 4337:376:150
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/common/lib/ModeLib.sol:ModeLib:encode(CallType,ExecType,ModeSelector,ModePayload)`

```solidity
function encode(CallType callType, ExecType execType, ModeSelector mode, ModePayload payload) internal pure returns (ModeCode) {
    return ModeCode.wrap(bytes32(abi.encodePacked(callType, execType, bytes4(0), ModeSelector.unwrap(mode), payload)));
}
```

### encodeSingle(address,uint256,bytes)

- **Kind**: internal
- **Source**: 2879:261:154
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/erc7579/lib/ExecutionLib.sol:ExecutionLib:encodeSingle(address,uint256,bytes)`

```solidity
function encodeSingle(address target, uint256 value, bytes memory callData) internal pure returns (bytes memory userOpCalldata) {
    userOpCalldata = abi.encodePacked(target, value, callData);
}
```

## External Calls

- **IERC7579Account::executeFromExecutor(ModeCode,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockExecutor.exec(address,address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC7579ExecutorBase._execute(address,address,uint256,bytes) (NodeID: 1)
      💬 Args: [account, to, value, callData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 2)
    │   💬 Args: [CALLTYPE_SINGLE, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ExecutionLib.encodeSingle(address,uint256,bytes) (NodeID: 3)
        💬 Args: [to, value, data]
        👁️  Def: internal
```
