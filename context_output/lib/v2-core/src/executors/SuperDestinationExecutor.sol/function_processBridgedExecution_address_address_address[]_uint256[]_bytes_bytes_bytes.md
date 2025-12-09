# Function: processBridgedExecution(address,address,address[],uint256[],bytes,bytes,bytes)

**Contract**: [lib/v2-core/src/executors/SuperDestinationExecutor.sol/contract_SuperDestinationExecutor.md]

## Metadata

- **Contract**: SuperDestinationExecutor
- **Signature**: `processBridgedExecution(address,address,address[],uint256[],bytes,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 4569:1970:360

## Implementation

```solidity
/// @inheritdoc ISuperDestinationExecutor
function processBridgedExecution(address, address account, address[] memory dstTokens, uint256[] memory intentAmounts, bytes memory initData, bytes memory executorCalldata, bytes memory userSignatureData) override external {
    uint256 dstTokensLen = dstTokens.length;
    if (dstTokensLen != intentAmounts.length) revert ARRAY_LENGTH_MISMATCH();
    _validateOrCreateAccount(account, initData);
    bytes32 merkleRoot = _decodeMerkleRoot(userSignatureData);
    bytes memory destinationData = abi.encode(executorCalldata, uint64(block.chainid), account, address(this), dstTokens, intentAmounts);
    bytes4 validationResult = ISuperDestinationValidator(SUPER_DESTINATION_VALIDATOR).isValidDestinationSignature(account, abi.encode(userSignatureData, destinationData));
    if (validationResult != DESTINATION_SIGNATURE_MAGIC_VALUE) revert INVALID_SIGNATURE();
    if (!_validateBalances(account, dstTokens, intentAmounts)) return;
    if (usedMerkleRoots[account][merkleRoot]) {
        emit SuperDestinationExecutorReceivedButRootUsedAlready(account, merkleRoot);
        return;
    }
    usedMerkleRoots[account][merkleRoot] = true;
    if (_shouldSkipCalldata(executorCalldata)) {
        emit SuperDestinationExecutorReceivedButNoHooks(account);
        return;
    }
    Execution[] memory execs = new Execution[](1);
    execs[0] = Execution({target: address(this), value: 0, callData: executorCalldata});
    _execute(account, execs);
    emit SuperDestinationExecutorExecuted(account);
}
```

## Related Implementations

### _validateOrCreateAccount(address,bytes)

- **Kind**: internal
- **Source**: 7370:391:360
- **Link**: `lib/v2-core/src/executors/SuperDestinationExecutor.sol:SuperDestinationExecutor:_validateOrCreateAccount(address,bytes)`

```solidity
function _validateOrCreateAccount(address account, bytes memory initData) internal {
    if ((initData.length > 0) && (account.code.length == 0)) {
        address computedAddress = _createAccount(initData);
        if (account != computedAddress) revert INVALID_ACCOUNT();
    }
    if ((account == address(0)) || (account.code.length == 0)) revert ACCOUNT_NOT_CREATED();
}
```

### _createAccount(bytes)

- **Kind**: internal
- **Source**: 9340:572:360
- **Link**: `lib/v2-core/src/executors/SuperDestinationExecutor.sol:SuperDestinationExecutor:_createAccount(bytes)`

```solidity
function _createAccount(bytes memory initCode) internal returns (address account) {
    address senderCreator = BytesLib.toAddress(initCode, 0);
    if (senderCreator == address(0)) revert ADDRESS_NOT_VALID();
    if (senderCreator.code.length == 0) revert SENDER_CREATOR_NOT_VALID();
    bytes memory senderData = BytesLib.slice(initCode, 20, initCode.length - 20);
    return ISuperSenderCreator(senderCreator).createSender(senderData);
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

### _decodeMerkleRoot(bytes)

- **Kind**: internal
- **Source**: 7767:298:360
- **Link**: `lib/v2-core/src/executors/SuperDestinationExecutor.sol:SuperDestinationExecutor:_decodeMerkleRoot(bytes)`

```solidity
function _decodeMerkleRoot(bytes memory userSignatureData) private pure returns (bytes32) {
    (, , , bytes32 merkleRoot, , , ) = abi.decode(userSignatureData, (uint64[], uint48, uint48, bytes32, bytes32[], ISuperValidator.DstProof[], bytes));
    return merkleRoot;
}
```

### _validateBalances(address,address[],uint256[])

- **Kind**: internal
- **Source**: 8071:1263:360
- **Link**: `lib/v2-core/src/executors/SuperDestinationExecutor.sol:SuperDestinationExecutor:_validateBalances(address,address[],uint256[])`

```solidity
function _validateBalances(address account, address[] memory dstTokens, uint256[] memory intentAmounts) private returns (bool) {
    uint256 len = dstTokens.length;
    for (uint256 i; i < len; i++) {
        address _token = dstTokens[i];
        uint256 _intentAmount = intentAmounts[i];
        if (_intentAmount == 0) {
            emit SuperDestinationExecutorInvalidIntentAmount(account, _token, _intentAmount);
            return false;
        }
        if (_token == address(0)) {
            if ((_intentAmount != 0) && (account.balance < _intentAmount)) {
                emit SuperDestinationExecutorReceivedButNotEnoughBalance(account, _token, _intentAmount, account.balance);
                return false;
            }
        } else {
            uint256 _balance = IERC20(_token).balanceOf(account);
            if ((_intentAmount != 0) && (_balance < _intentAmount)) {
                emit SuperDestinationExecutorReceivedButNotEnoughBalance(account, _token, _intentAmount, _balance);
                return false;
            }
        }
    }
    return true;
}
```

### _shouldSkipCalldata(bytes)

- **Kind**: internal
- **Source**: 7058:306:360
- **Link**: `lib/v2-core/src/executors/SuperDestinationExecutor.sol:SuperDestinationExecutor:_shouldSkipCalldata(bytes)`

```solidity
function _shouldSkipCalldata(bytes memory executorCalldata) internal pure returns (bool) {
    bytes4 selector = bytes4(BytesLib.slice(executorCalldata, 0, 4));
    if (selector != ISuperExecutor.execute.selector) return true;
    return executorCalldata.length <= EMPTY_EXECUTION_LENGTH;
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

## External Calls

- **ISuperDestinationValidator::isValidDestinationSignature(address,bytes)**

## State Variable Reads

- **SUPER_DESTINATION_VALIDATOR** (`address`)
- **DESTINATION_SIGNATURE_MAGIC_VALUE** (`bytes4`)
- **usedMerkleRoots** (`mapping(address => mapping(bytes32 => bool))`)
- **EMPTY_EXECUTION_LENGTH** (`uint256`)

## State Variable Writes

- **usedMerkleRoots** (`mapping(address => mapping(bytes32 => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperDestinationExecutor.processBridgedExecution(address,address,address[],uint256[],bytes,bytes,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperDestinationExecutor._validateOrCreateAccount(address,bytes) (NodeID: 1)
  │   💬 Args: [account, initData]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperDestinationExecutor._createAccount(bytes) (NodeID: 2)
  │     💬 Args: [initData]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
  │   │   💬 Args: [initCode, 0]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 4)
  │       💬 Args: [initCode, 20, initCode.length - 20]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperDestinationExecutor._decodeMerkleRoot(bytes) (NodeID: 5)
  │   💬 Args: [userSignatureData]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperDestinationExecutor._validateBalances(address,address[],uint256[]) (NodeID: 6)
  │   💬 Args: [account, dstTokens, intentAmounts]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperDestinationExecutor._shouldSkipCalldata(bytes) (NodeID: 7)
  │   💬 Args: [executorCalldata]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 8)
  │     💬 Args: [executorCalldata, 0, 4]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC7579ExecutorBase._execute(address,struct Execution[]) (NodeID: 9)
      💬 Args: [account, execs]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 10)
    │   💬 Args: [CALLTYPE_BATCH, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ExecutionLib.encodeBatch(struct Execution[]) (NodeID: 11)
        💬 Args: [execs]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperDestinationExecutor

### Interface Documentation

@notice Processes a cross-chain execution request that was bridged from another blockchain
 @dev This is the main entry point for cross-chain operations on the destination chain
      The function handles several key tasks:
      1. Verifies the bridged message using signature or merkle proof
      2. Creates the target account if it doesn't exist yet
      3. Ensures the account has sufficient balance for the operation
      4. Executes the requested operation on the target account
      Typically called by a bridge adapter contract after receiving a cross-chain message
 @param tokenSent The token address that was bridged to be used in the execution
 @param targetAccount The destination smart contract account to execute the operation on
 @param dstTokens The tokens required in the target account to proceed with the execution.
 @param intentAmounts The amounts required in the target account to proceed with the execution.
 @param initData Optional initialization data for creating a new account if needed
 @param executorCalldata The encoded execution data (typically a SuperExecutor entry)
 @param userSignatureData Verification data (signature or merkle proof) to validate the request
