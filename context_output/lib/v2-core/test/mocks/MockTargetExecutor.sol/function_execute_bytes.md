# Function: execute(bytes)

**Contract**: [lib/v2-core/test/mocks/MockTargetExecutor.sol/contract_MockTargetExecutor.md]

## Metadata

- **Contract**: MockTargetExecutor
- **Signature**: `execute(bytes)`
- **Visibility**: external
- **Source Range**: 4382:184:487

## Implementation

```solidity
function execute(bytes calldata data) external {
    if (!_initialized[msg.sender]) revert NOT_INITIALIZED();
    _execute(msg.sender, abi.decode(data, (ExecutorEntry)));
}
```

## Related Implementations

### _execute(address,struct ISuperExecutor.ExecutorEntry)

- **Kind**: internal
- **Source**: 4759:473:487
- **Link**: `lib/v2-core/test/mocks/MockTargetExecutor.sol:MockTargetExecutor:_execute(address,struct ISuperExecutor.ExecutorEntry)`

```solidity
function _execute(address account, ExecutorEntry memory entry) private {
    uint256 hooksLen = entry.hooksAddresses.length;
    for (uint256 i; i < hooksLen; ++i) {
        address prevHook = (i != 0) ? entry.hooksAddresses[i - 1] : address(0);
        _processHook(account, ISuperHook(entry.hooksAddresses[i]), prevHook, entry.hooksData[i]);
    }
}
```

### _processHook(address,contract ISuperHook,address,bytes)

- **Kind**: internal
- **Source**: 5238:677:487
- **Link**: `lib/v2-core/test/mocks/MockTargetExecutor.sol:MockTargetExecutor:_processHook(address,contract ISuperHook,address,bytes)`

```solidity
function _processHook(address account, ISuperHook hook, address prevHook, bytes memory hookData) private {
    hook.preExecute(prevHook, account, hookData);
    Execution[] memory executions = hook.build(prevHook, account, hookData);
    if (executions.length > 0) {
        _execute(account, executions);
    }
    hook.postExecute(prevHook, account, hookData);
    _updateAccounting(account, address(hook), hookData);
    _lockForSuperPositions(account, address(hook));
}
```

### _execute(address,struct Execution[])

- **Kind**: internal
- **Source**: 1565:512:201
- **Link**: `lib/v2-core/lib/modulekit/src/module-bases/ERC7579ExecutorBase.sol:ERC7579ExecutorBase:_execute(address,struct Execution[])`

```solidity
function _execute(address account, Execution[] memory execs) internal returns (bytes[] memory results) {
    ModeCode modeCode = ERC7579ModeLib.encode({callType: CALLTYPE_BATCH, execType: EXECTYPE_DEFAULT, mode: MODE_DEFAULT, payload: ModePayload.wrap(bytes22(0))});
    results = IERC7579Account(account).executeFromExecutor(modeCode, ERC7579ExecutionLib.encodeBatch(execs));
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

### encodeBatch(struct Execution[])

- **Kind**: internal
- **Source**: 2358:176:154
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/erc7579/lib/ExecutionLib.sol:ExecutionLib:encodeBatch(struct Execution[])`

```solidity
function encodeBatch(Execution[] memory executions) internal pure returns (bytes memory callData) {
    callData = abi.encode(executions);
}
```

### _updateAccounting(address,address,bytes)

- **Kind**: internal
- **Source**: 5921:885:487
- **Link**: `lib/v2-core/test/mocks/MockTargetExecutor.sol:MockTargetExecutor:_updateAccounting(address,address,bytes)`

```solidity
function _updateAccounting(address account, address hook, bytes memory hookData) private {
    ISuperHook.HookType _type = ISuperHookResult(hook).hookType();
    if ((_type == ISuperHook.HookType.INFLOW) || (_type == ISuperHook.HookType.OUTFLOW)) {
        bytes32 yieldSourceOracleId = hookData.extractYieldSourceOracleId();
        address yieldSource = hookData.extractYieldSource();
        ISuperLedgerConfiguration.YieldSourceOracleConfig memory config = LEDGER_CONFIGURATION.getYieldSourceOracleConfig(yieldSourceOracleId);
        ISuperLedger(config.ledger).updateAccounting(account, yieldSource, yieldSourceOracleId, _type == ISuperHook.HookType.INFLOW, ISuperHookResult(address(hook)).getOutAmount(account), 0);
    }
}
```

### extractYieldSourceOracleId(bytes)

- **Kind**: internal
- **Source**: 243:147:432
- **Link**: `lib/v2-core/src/libraries/HookDataDecoder.sol:HookDataDecoder:extractYieldSourceOracleId(bytes)`

```solidity
function extractYieldSourceOracleId(bytes memory data) internal pure returns (bytes32) {
    return bytes32(BytesLib.slice(data, 0, 32));
}
```

### slice(bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 9250:2874:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:slice(bytes,uint256,uint256)`

```solidity
function slice(bytes memory _bytes, uint256 _start, uint256 _length) internal pure returns (bytes memory) {
    unchecked {
        require((_length + 31) >= _length, "slice_overflow");
    }
    require(_bytes.length >= (_start + _length), "slice_outOfBounds");
    bytes memory tempBytes;
    assembly {
        switch iszero(_length)
        case 0 {
            tempBytes := mload(0x40)
            let lengthmod := and(_length, 31)
            let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
            let end := add(mc, _length)
            for {
                let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
            } lt(mc, end) {
                mc := add(mc, 0x20)
                cc := add(cc, 0x20)
            } {
                mstore(mc, mload(cc))
            }
            mstore(tempBytes, _length)
            mstore(0x40, and(add(mc, 31), not(31)))
        }
        default {
            tempBytes := mload(0x40)
            mstore(tempBytes, 0)
            mstore(0x40, add(tempBytes, 0x20))
        }
    }
    return tempBytes;
}
```

### extractYieldSource(bytes)

- **Kind**: internal
- **Source**: 396:131:432
- **Link**: `lib/v2-core/src/libraries/HookDataDecoder.sol:HookDataDecoder:extractYieldSource(bytes)`

```solidity
function extractYieldSource(bytes memory data) internal pure returns (address) {
    return BytesLib.toAddress(data, 32);
}
```

### toAddress(bytes,uint256)

- **Kind**: internal
- **Source**: 12130:354:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toAddress(bytes,uint256)`

```solidity
function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
    require(_bytes.length >= (_start + 20), "toAddress_outOfBounds");
    address tempAddress;
    assembly {
        tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }
    return tempAddress;
}
```

### _lockForSuperPositions(address,address)

- **Kind**: internal
- **Source**: 6812:914:487
- **Link**: `lib/v2-core/test/mocks/MockTargetExecutor.sol:MockTargetExecutor:_lockForSuperPositions(address,address)`

```solidity
function _lockForSuperPositions(address account, address hook) private {
    bool lockForSP = ISuperLockableHook(address(hook)).vaultBank() != address(0);
    if (lockForSP) {
        address spToken = ISuperHookResult(hook).spToken();
        uint256 amount = ISuperHookResult(hook).getOutAmount(account);
        ISuperCollectiveVault vault = ISuperCollectiveVault(SUPER_COLLECTIVE_VAULT);
        if (address(vault) != address(0)) {
            Execution[] memory execs = new Execution[](1);
            execs[0] = Execution({target: spToken, value: 0, callData: abi.encodeCall(IERC20.approve, (address(vault), amount))});
            _execute(account, execs);
            vault.lock(account, spToken, hook, amount);
        }
    }
}
```

## State Variable Reads

- **_initialized** (`mapping(address => bool)`)
- **LEDGER_CONFIGURATION** (`contract ISuperLedgerConfiguration`) [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]
- **SUPER_COLLECTIVE_VAULT** (`contract ISuperCollectiveVault`) [lib/v2-core/test/mocks/ISuperCollectiveVault.sol/interface_ISuperCollectiveVault.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTargetExecutor.execute(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MockTargetExecutor._execute(address,struct ISuperExecutor.ExecutorEntry) (NodeID: 1)
      💬 Args: [msg.sender, abi.decode(data, (ExecutorEntry))]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: MockTargetExecutor._processHook(address,contract ISuperHook,address,bytes) (NodeID: 2)
        💬 Args: [account, ISuperHook(entry.hooksAddresses[i]), prevHook, entry.hooksData[i]]
        👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: ERC7579ExecutorBase._execute(address,struct Execution[]) (NodeID: 3)
      │   💬 Args: [account, executions]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 4)
      │ │   💬 Args: [CALLTYPE_BATCH, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ExecutionLib.encodeBatch(struct Execution[]) (NodeID: 5)
      │     💬 Args: [execs]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: MockTargetExecutor._updateAccounting(address,address,bytes) (NodeID: 6)
      │   💬 Args: [account, address(hook), hookData]
      │   👁️  Def: private
      │ ├─ [4] ⚙️ FUNCTION: HookDataDecoder.extractYieldSourceOracleId(bytes) (NodeID: 7)
      │ │   💬 Args: [hookData]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 8)
      │ │     💬 Args: [data, 0, 32]
      │ │     👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 9)
      │     💬 Args: [hookData]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 10)
      │       💬 Args: [data, 32]
      │       👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: MockTargetExecutor._lockForSuperPositions(address,address) (NodeID: 11)
          💬 Args: [account, address(hook)]
          👁️  Def: private
        └─ [4] ⚙️ FUNCTION: ERC7579ExecutorBase._execute(address,struct Execution[]) (NodeID: 12)
            💬 Args: [account, execs]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 13)
          │   💬 Args: [CALLTYPE_BATCH, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
          │   👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: ExecutionLib.encodeBatch(struct Execution[]) (NodeID: 14)
              💬 Args: [execs]
              👁️  Def: internal
```

## Documentation

### Interface Documentation

@notice Executes a sequence of hooks with their respective parameters
 @dev The main entry point for executing hook sequences
      The input data should be encoded ExecutorEntry struct
      Hooks are executed in sequence, with results from each hook potentially
      influencing the execution of subsequent hooks
      Each hook's execution involves calling preExecute, build, and postExecute
 @param data ABI-encoded ExecutorEntry containing hooks and their parameters
