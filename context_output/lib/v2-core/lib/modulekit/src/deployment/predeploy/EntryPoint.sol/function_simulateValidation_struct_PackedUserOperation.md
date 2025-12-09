# Function: simulateValidation(struct PackedUserOperation)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `simulateValidation(struct PackedUserOperation)`
- **Visibility**: external
- **Source Range**: 1897:1671:90
- **Inherited From**: EntryPointSimulations

## Implementation

```solidity
/// @inheritdoc IEntryPointSimulations
function simulateValidation(PackedUserOperation calldata userOp) external returns (ValidationResult memory) {
    UserOpInfo memory outOpInfo;
    _simulationOnlyValidations(userOp);
    (uint256 validationData, uint256 paymasterValidationData) = _validatePrepayment(0, userOp, outOpInfo);
    StakeInfo memory paymasterInfo = _getStakeInfo(outOpInfo.mUserOp.paymaster);
    StakeInfo memory senderInfo = _getStakeInfo(outOpInfo.mUserOp.sender);
    StakeInfo memory factoryInfo;
    {
        bytes calldata initCode = userOp.initCode;
        address factory = (initCode.length >= 20) ? address(bytes20(initCode[0:20])) : address(0);
        factoryInfo = _getStakeInfo(factory);
    }
    address aggregator = address(uint160(validationData));
    ReturnInfo memory returnInfo = ReturnInfo(outOpInfo.preOpGas, outOpInfo.prefund, validationData, paymasterValidationData, getMemoryBytesFromOffset(outOpInfo.contextOffset));
    AggregatorStakeInfo memory aggregatorInfo = NOT_AGGREGATED;
    if ((uint160(aggregator) != SIG_VALIDATION_SUCCESS) && (uint160(aggregator) != SIG_VALIDATION_FAILED)) {
        aggregatorInfo = AggregatorStakeInfo(aggregator, _getStakeInfo(aggregator));
    }
    return ValidationResult(returnInfo, senderInfo, factoryInfo, paymasterInfo, aggregatorInfo);
}
```

## Related Implementations

### _simulationOnlyValidations(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 4498:595:90
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPointSimulations.sol:EntryPointSimulations:_simulationOnlyValidations(struct PackedUserOperation)`

```solidity
function _simulationOnlyValidations(PackedUserOperation calldata userOp) internal {
    initSenderCreator();
    try this._validateSenderAndPaymaster(userOp.initCode, userOp.sender, userOp.paymasterAndData) {} catch Error(string memory revertReason) {
        if (bytes(revertReason).length != 0) {
            revert FailedOp(0, revertReason);
        }
    }
}
```

### initSenderCreator()

- **Kind**: internal
- **Source**: 724:342:187
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol:EntryPointSimulationsPatch:initSenderCreator()`

```solidity
function initSenderCreator() override internal {
    address createdObj = address(uint160(uint256(keccak256(abi.encodePacked(hex"d694", _entrypointAddr, hex"01")))));
    _newSenderCreator = SenderCreator(createdObj);
}
```

### _validatePrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo)

- **Kind**: internal
- **Source**: 22987:1943:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_validatePrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo)`

```solidity
///  Validate account and paymaster (if defined) and
///  also make sure total validation doesn't exceed verificationGasLimit.
///  This method is called off-chain (simulateValidation()) and on-chain (from handleOps)
///  @param opIndex - The index of this userOp into the "opInfos" array.
///  @param userOp  - The userOp to validate.
function _validatePrepayment(uint256 opIndex, PackedUserOperation calldata userOp, UserOpInfo memory outOpInfo) internal returns (uint256 validationData, uint256 paymasterValidationData) {
    uint256 preGas = gasleft();
    MemoryUserOp memory mUserOp = outOpInfo.mUserOp;
    _copyUserOpToMemory(userOp, mUserOp);
    outOpInfo.userOpHash = getUserOpHash(userOp);
    uint256 verificationGasLimit = mUserOp.verificationGasLimit;
    uint256 maxGasValues = (((((mUserOp.preVerificationGas | verificationGasLimit) | mUserOp.callGasLimit) | mUserOp.paymasterVerificationGasLimit) | mUserOp.paymasterPostOpGasLimit) | mUserOp.maxFeePerGas) | mUserOp.maxPriorityFeePerGas;
    require(maxGasValues <= type(uint120).max, "AA94 gas values overflow");
    uint256 requiredPreFund = _getRequiredPrefund(mUserOp);
    validationData = _validateAccountPrepayment(opIndex, userOp, outOpInfo, requiredPreFund, verificationGasLimit);
    if (!_validateAndUpdateNonce(mUserOp.sender, mUserOp.nonce)) {
        revert FailedOp(opIndex, "AA25 invalid account nonce");
    }
    unchecked {
        if ((preGas - gasleft()) > verificationGasLimit) {
            revert FailedOp(opIndex, "AA26 over verificationGasLimit");
        }
    }
    bytes memory context;
    if (mUserOp.paymaster != address(0)) {
        (context, paymasterValidationData) = _validatePaymasterPrepayment(opIndex, userOp, outOpInfo, requiredPreFund);
    }
    unchecked {
        outOpInfo.prefund = requiredPreFund;
        outOpInfo.contextOffset = getOffsetOfMemoryBytes(context);
        outOpInfo.preOpGas = (preGas - gasleft()) + userOp.preVerificationGas;
    }
}
```

### _copyUserOpToMemory(struct PackedUserOperation,struct EntryPoint.MemoryUserOp)

- **Kind**: internal
- **Source**: 13032:1077:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_copyUserOpToMemory(struct PackedUserOperation,struct EntryPoint.MemoryUserOp)`

```solidity
///  Copy general fields from userOp into the memory opInfo structure.
///  @param userOp  - The user operation.
///  @param mUserOp - The memory user operation.
function _copyUserOpToMemory(PackedUserOperation calldata userOp, MemoryUserOp memory mUserOp) internal pure {
    mUserOp.sender = userOp.sender;
    mUserOp.nonce = userOp.nonce;
    (mUserOp.verificationGasLimit, mUserOp.callGasLimit) = UserOperationLib.unpackUints(userOp.accountGasLimits);
    mUserOp.preVerificationGas = userOp.preVerificationGas;
    (mUserOp.maxPriorityFeePerGas, mUserOp.maxFeePerGas) = UserOperationLib.unpackUints(userOp.gasFees);
    bytes calldata paymasterAndData = userOp.paymasterAndData;
    if (paymasterAndData.length > 0) {
        require(paymasterAndData.length >= UserOperationLib.PAYMASTER_DATA_OFFSET, "AA93 invalid paymasterAndData");
        (mUserOp.paymaster, mUserOp.paymasterVerificationGasLimit, mUserOp.paymasterPostOpGasLimit) = UserOperationLib.unpackPaymasterStaticFields(paymasterAndData);
    } else {
        mUserOp.paymaster = address(0);
        mUserOp.paymasterVerificationGasLimit = 0;
        mUserOp.paymasterPostOpGasLimit = 0;
    }
}
```

### unpackUints(bytes32)

- **Kind**: internal
- **Source**: 2535:183:96
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/UserOperationLib.sol:UserOperationLib:unpackUints(bytes32)`

```solidity
function unpackUints(bytes32 packed) internal pure returns (uint256 high128, uint256 low128) {
    return (uint128(bytes16(packed)), uint128(uint256(packed)));
}
```

### unpackPaymasterStaticFields(bytes)

- **Kind**: internal
- **Source**: 4234:507:96
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/UserOperationLib.sol:UserOperationLib:unpackPaymasterStaticFields(bytes)`

```solidity
function unpackPaymasterStaticFields(bytes calldata paymasterAndData) internal pure returns (address paymaster, uint256 validationGasLimit, uint256 postOpGasLimit) {
    return (address(bytes20(paymasterAndData[:PAYMASTER_VALIDATION_GAS_OFFSET])), uint128(bytes16(paymasterAndData[PAYMASTER_VALIDATION_GAS_OFFSET:PAYMASTER_POSTOP_GAS_OFFSET])), uint128(bytes16(paymasterAndData[PAYMASTER_POSTOP_GAS_OFFSET:PAYMASTER_DATA_OFFSET])));
}
```

### getUserOpHash(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 12662:180:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:getUserOpHash(struct PackedUserOperation)`

```solidity
/// @inheritdoc IEntryPoint
function getUserOpHash(PackedUserOperation calldata userOp) public view returns (bytes32) {
    return keccak256(abi.encode(userOp.hash(), address(this), block.chainid));
}
```

### hash(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 4848:146:96
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/UserOperationLib.sol:UserOperationLib:hash(struct PackedUserOperation)`

```solidity
///  Hash the user operation data.
///  @param userOp - The user operation data.
function hash(PackedUserOperation calldata userOp) internal pure returns (bytes32) {
    return keccak256(encode(userOp));
}
```

### encode(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 1760:769:96
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/UserOperationLib.sol:UserOperationLib:encode(struct PackedUserOperation)`

```solidity
///  Pack the user operation data into bytes for hashing.
///  @param userOp - The user operation data.
function encode(PackedUserOperation calldata userOp) internal pure returns (bytes memory ret) {
    address sender = getSender(userOp);
    uint256 nonce = userOp.nonce;
    bytes32 hashInitCode = calldataKeccak(userOp.initCode);
    bytes32 hashCallData = calldataKeccak(userOp.callData);
    bytes32 accountGasLimits = userOp.accountGasLimits;
    uint256 preVerificationGas = userOp.preVerificationGas;
    bytes32 gasFees = userOp.gasFees;
    bytes32 hashPaymasterAndData = calldataKeccak(userOp.paymasterAndData);
    return abi.encode(sender, nonce, hashInitCode, hashCallData, accountGasLimits, preVerificationGas, gasFees, hashPaymasterAndData);
}
```

### getSender(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 606:323:96
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/UserOperationLib.sol:UserOperationLib:getSender(struct PackedUserOperation)`

```solidity
///  Get sender from user operation data.
///  @param userOp - The user operation data.
function getSender(PackedUserOperation calldata userOp) internal pure returns (address) {
    address data;
    assembly {
        data := calldataload(userOp)
    }
    return address(uint160(data));
}
```

### calldataKeccak(bytes)

- **Kind**: free-function
- **Source**: 2879:281:92
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/Helpers.sol:calldataKeccak(bytes)`

```solidity
///  keccak function over calldata.
///  @dev copy calldata into memory, do keccak and drop allocated memory. Strangely, this is more efficient than letting solidity do it.
function calldataKeccak(bytes calldata data) pure returns (bytes32 ret) {
    assembly ("memory-safe") {
        let mem := mload(0x40)
        let len := data.length
        calldatacopy(mem, data.offset, len)
        ret := keccak256(mem, len)
    }
}
```

### _getRequiredPrefund(struct EntryPoint.MemoryUserOp)

- **Kind**: internal
- **Source**: 14252:416:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_getRequiredPrefund(struct EntryPoint.MemoryUserOp)`

```solidity
///  Get the required prefunded gas fee amount for an operation.
///  @param mUserOp - The user operation in memory.
function _getRequiredPrefund(MemoryUserOp memory mUserOp) internal pure returns (uint256 requiredPrefund) {
    unchecked {
        uint256 requiredGas = (((mUserOp.verificationGasLimit + mUserOp.callGasLimit) + mUserOp.paymasterVerificationGasLimit) + mUserOp.paymasterPostOpGasLimit) + mUserOp.preVerificationGas;
        requiredPrefund = requiredGas * mUserOp.maxFeePerGas;
    }
}
```

### _validateAccountPrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo,uint256,uint256)

- **Kind**: internal
- **Source**: 16682:1621:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_validateAccountPrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo,uint256,uint256)`

```solidity
///  Call account.validateUserOp.
///  Revert (with FailedOp) in case validateUserOp reverts, or account didn't send required prefund.
///  Decrement account's deposit if needed.
///  @param opIndex         - The operation index.
///  @param op              - The user operation.
///  @param opInfo          - The operation info.
///  @param requiredPrefund - The required prefund amount.
function _validateAccountPrepayment(uint256 opIndex, PackedUserOperation calldata op, UserOpInfo memory opInfo, uint256 requiredPrefund, uint256 verificationGasLimit) internal returns (uint256 validationData) {
    unchecked {
        MemoryUserOp memory mUserOp = opInfo.mUserOp;
        address sender = mUserOp.sender;
        _createSenderIfNeeded(opIndex, opInfo, op.initCode);
        address paymaster = mUserOp.paymaster;
        uint256 missingAccountFunds = 0;
        if (paymaster == address(0)) {
            uint256 bal = balanceOf(sender);
            missingAccountFunds = (bal > requiredPrefund) ? 0 : (requiredPrefund - bal);
        }
        uint256 _verificationGas = gasleft();
        try IAccount(sender).validateUserOp{gas: verificationGasLimit}(op, opInfo.userOpHash, missingAccountFunds) returns (uint256 _validationData) {
            validationData = _validationData;
            setGasConsumed(sender, 1, _verificationGas - gasleft());
        } catch {
            revert FailedOpWithRevert(opIndex, "AA23 reverted", Exec.getReturnData(REVERT_REASON_MAX_LEN));
        }
        if (paymaster == address(0)) {
            DepositInfo storage senderInfo = deposits[sender];
            uint256 deposit = senderInfo.deposit;
            if (requiredPrefund > deposit) {
                revert FailedOp(opIndex, "AA21 didn't pay prefund");
            }
            senderInfo.deposit = deposit - requiredPrefund;
        }
    }
}
```

### _createSenderIfNeeded(uint256,struct EntryPoint.UserOpInfo,bytes)

- **Kind**: internal
- **Source**: 14922:1123:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_createSenderIfNeeded(uint256,struct EntryPoint.UserOpInfo,bytes)`

```solidity
///  Create sender smart contract account if init code is provided.
///  @param opIndex  - The operation index.
///  @param opInfo   - The operation info.
///  @param initCode - The init code for the smart contract account.
function _createSenderIfNeeded(uint256 opIndex, UserOpInfo memory opInfo, bytes calldata initCode) internal {
    if (initCode.length != 0) {
        address sender = opInfo.mUserOp.sender;
        if (sender.code.length != 0) {
            revert FailedOp(opIndex, "AA10 sender already constructed");
        }
        uint256 _creationGas = gasleft();
        address sender1 = senderCreator().createSender{gas: opInfo.mUserOp.verificationGasLimit}(initCode);
        setGasConsumed(sender, 0, _creationGas - gasleft());
        if (sender1 == address(0)) {
            revert FailedOp(opIndex, "AA13 initCode failed or OOG");
        }
        if (sender1 != sender) {
            revert FailedOp(opIndex, "AA14 initCode must return sender");
        }
        if (sender1.code.length == 0) {
            revert FailedOp(opIndex, "AA15 initCode must create sender");
        }
        address factory = address(bytes20(initCode[0:20]));
        emit AccountDeployed(opInfo.userOpHash, sender, factory, opInfo.mUserOp.paymaster);
    }
}
```

### senderCreator()

- **Kind**: internal
- **Source**: 1072:121:187
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol:EntryPointSimulationsPatch:senderCreator()`

```solidity
function senderCreator() virtual override internal view returns (SenderCreator) {
    return _newSenderCreator;
}
```

### setGasConsumed(address,uint256,uint256)

- **Kind**: internal
- **Source**: 256:128:91
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/GasDebug.sol:GasDebug:setGasConsumed(address,uint256,uint256)`

```solidity
function setGasConsumed(address account, uint256 phase, uint256 gas) internal {
    gasConsumed[account][phase] = gas;
}
```

### balanceOf(address)

- **Kind**: internal
- **Source**: 1158:115:95
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/StakeManager.sol:StakeManager:balanceOf(address)`

```solidity
/// @inheritdoc IStakeManager
function balanceOf(address account) public view returns (uint256) {
    return deposits[account].deposit;
}
```

### getReturnData(uint256)

- **Kind**: internal
- **Source**: 1107:452:106
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/utils/Exec.sol:Exec:getReturnData(uint256)`

```solidity
function getReturnData(uint256 maxLen) internal pure returns (bytes memory returnData) {
    assembly ("memory-safe") {
        let len := returndatasize()
        if gt(len, maxLen) {
            len := maxLen
        }
        let ptr := mload(0x40)
        mstore(0x40, add(ptr, add(len, 0x20)))
        mstore(ptr, len)
        returndatacopy(add(ptr, 0x20), 0, len)
        returnData := ptr
    }
}
```

### _validateAndUpdateNonce(address,uint256)

- **Kind**: internal
- **Source**: 1187:234:93
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/NonceManager.sol:NonceManager:_validateAndUpdateNonce(address,uint256)`

```solidity
///  validate nonce uniqueness for this account.
///  called just after validateUserOp()
///  @return true if the nonce was incremented successfully.
///          false if the current nonce doesn't match the given one.
function _validateAndUpdateNonce(address sender, uint256 nonce) internal returns (bool) {
    uint192 key = uint192(nonce >> 64);
    uint64 seq = uint64(nonce);
    return (nonceSequenceNumber[sender][key]++) == seq;
}
```

### _validatePaymasterPrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo,uint256)

- **Kind**: internal
- **Source**: 18868:1447:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_validatePaymasterPrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo,uint256)`

```solidity
///  In case the request has a paymaster:
///   - Validate paymaster has enough deposit.
///   - Call paymaster.validatePaymasterUserOp.
///   - Revert with proper FailedOp in case paymaster reverts.
///   - Decrement paymaster's deposit.
///  @param opIndex                            - The operation index.
///  @param op                                 - The user operation.
///  @param opInfo                             - The operation info.
///  @param requiredPreFund                    - The required prefund amount.
function _validatePaymasterPrepayment(uint256 opIndex, PackedUserOperation calldata op, UserOpInfo memory opInfo, uint256 requiredPreFund) internal returns (bytes memory context, uint256 validationData) {
    unchecked {
        uint256 preGas = gasleft();
        MemoryUserOp memory mUserOp = opInfo.mUserOp;
        address paymaster = mUserOp.paymaster;
        DepositInfo storage paymasterInfo = deposits[paymaster];
        uint256 deposit = paymasterInfo.deposit;
        if (deposit < requiredPreFund) {
            revert FailedOp(opIndex, "AA31 paymaster deposit too low");
        }
        paymasterInfo.deposit = deposit - requiredPreFund;
        uint256 pmVerificationGasLimit = mUserOp.paymasterVerificationGasLimit;
        try IPaymaster(paymaster).validatePaymasterUserOp{gas: pmVerificationGasLimit}(op, opInfo.userOpHash, requiredPreFund) returns (bytes memory _context, uint256 _validationData) {
            context = _context;
            validationData = _validationData;
        } catch {
            revert FailedOpWithRevert(opIndex, "AA33 reverted", Exec.getReturnData(REVERT_REASON_MAX_LEN));
        }
        if ((preGas - gasleft()) > pmVerificationGasLimit) {
            revert FailedOp(opIndex, "AA36 over paymasterVerificationGasLimit");
        }
    }
}
```

### getOffsetOfMemoryBytes(bytes)

- **Kind**: internal
- **Source**: 29380:153:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:getOffsetOfMemoryBytes(bytes)`

```solidity
///  The offset of the given bytes in memory.
///  @param data - The bytes to get the offset of.
function getOffsetOfMemoryBytes(bytes memory data) internal pure returns (uint256 offset) {
    assembly {
        offset := data
    }
}
```

### _getStakeInfo(address)

- **Kind**: internal
- **Source**: 856:262:95
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/StakeManager.sol:StakeManager:_getStakeInfo(address)`

```solidity
///  Internal method to return just the stake info.
///  @param addr - The account to query.
function _getStakeInfo(address addr) internal view returns (StakeInfo memory info) {
    DepositInfo storage depositInfo = deposits[addr];
    info.stake = depositInfo.stake;
    info.unstakeDelaySec = depositInfo.unstakeDelaySec;
}
```

### getMemoryBytesFromOffset(uint256)

- **Kind**: internal
- **Source**: 29660:171:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:getMemoryBytesFromOffset(uint256)`

```solidity
///  The bytes in memory at the given offset.
///  @param offset - The offset to get the bytes from.
function getMemoryBytesFromOffset(uint256 offset) internal pure returns (bytes memory data) {
    assembly ("memory-safe") {
        data := offset
    }
}
```

## State Variable Reads

- **NOT_AGGREGATED** (`struct IEntryPoint.AggregatorStakeInfo`)
- **_entrypointAddr** (`address`)
- **PAYMASTER_VALIDATION_GAS_OFFSET** (`uint256`)
- **PAYMASTER_POSTOP_GAS_OFFSET** (`uint256`)
- **PAYMASTER_DATA_OFFSET** (`uint256`)
- **REVERT_REASON_MAX_LEN** (`uint256`)
- **_newSenderCreator** (`contract SenderCreator`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/SenderCreator.sol/contract_SenderCreator.md]
- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## State Variable Writes

- **_newSenderCreator** (`contract SenderCreator`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/SenderCreator.sol/contract_SenderCreator.md]
- **gasConsumed** (`mapping(address => mapping(uint256 => uint256))`)
- **nonceSequenceNumber** (`mapping(address => mapping(uint192 => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EntryPointSimulations.simulateValidation(struct PackedUserOperation) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EntryPointSimulations._simulationOnlyValidations(struct PackedUserOperation) (NodeID: 1)
  │   💬 Args: [userOp]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EntryPointSimulationsPatch.initSenderCreator() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EntryPoint._validatePrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo) (NodeID: 3)
  │   💬 Args: [0, userOp, outOpInfo]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint._copyUserOpToMemory(struct PackedUserOperation,struct EntryPoint.MemoryUserOp) (NodeID: 4)
  │ │   💬 Args: [userOp, mUserOp]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: UserOperationLib.unpackUints(bytes32) (NodeID: 5)
  │ │ │   💬 Args: [userOp.accountGasLimits]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: UserOperationLib.unpackUints(bytes32) (NodeID: 6)
  │ │ │   💬 Args: [userOp.gasFees]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: UserOperationLib.unpackPaymasterStaticFields(bytes) (NodeID: 7)
  │ │     💬 Args: [paymasterAndData]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint.getUserOpHash(struct PackedUserOperation) (NodeID: 8)
  │ │   💬 Args: [userOp]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: UserOperationLib.hash(struct PackedUserOperation) (NodeID: 9)
  │ │     💬 Args: [userOp]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: UserOperationLib.encode(struct PackedUserOperation) (NodeID: 10)
  │ │       💬 Args: [userOp]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: UserOperationLib.getSender(struct PackedUserOperation) (NodeID: 11)
  │ │     │   💬 Args: [userOp]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.calldataKeccak(bytes) (NodeID: 12)
  │ │     │   💬 Args: [userOp.initCode]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.calldataKeccak(bytes) (NodeID: 13)
  │ │     │   💬 Args: [userOp.callData]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Unknown.calldataKeccak(bytes) (NodeID: 14)
  │ │         💬 Args: [userOp.paymasterAndData]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint._getRequiredPrefund(struct EntryPoint.MemoryUserOp) (NodeID: 15)
  │ │   💬 Args: [mUserOp]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint._validateAccountPrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo,uint256,uint256) (NodeID: 16)
  │ │   💬 Args: [opIndex, userOp, outOpInfo, requiredPreFund, verificationGasLimit]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: EntryPoint._createSenderIfNeeded(uint256,struct EntryPoint.UserOpInfo,bytes) (NodeID: 17)
  │ │ │   💬 Args: [opIndex, opInfo, op.initCode]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: EntryPointSimulationsPatch.senderCreator() (NodeID: 18)
  │ │ │ │   💬 Args: [no args]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: GasDebug.setGasConsumed(address,uint256,uint256) (NodeID: 19)
  │ │ │     💬 Args: [sender, 0, _creationGas - gasleft()]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StakeManager.balanceOf(address) (NodeID: 20)
  │ │ │   💬 Args: [sender]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: GasDebug.setGasConsumed(address,uint256,uint256) (NodeID: 21)
  │ │ │   💬 Args: [sender, 1, _verificationGas - gasleft()]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Exec.getReturnData(uint256) (NodeID: 22)
  │ │     💬 Args: [REVERT_REASON_MAX_LEN]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: NonceManager._validateAndUpdateNonce(address,uint256) (NodeID: 23)
  │ │   💬 Args: [mUserOp.sender, mUserOp.nonce]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint._validatePaymasterPrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo,uint256) (NodeID: 24)
  │ │   💬 Args: [opIndex, userOp, outOpInfo, requiredPreFund]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Exec.getReturnData(uint256) (NodeID: 25)
  │ │     💬 Args: [REVERT_REASON_MAX_LEN]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EntryPoint.getOffsetOfMemoryBytes(bytes) (NodeID: 26)
  │     💬 Args: [context]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StakeManager._getStakeInfo(address) (NodeID: 27)
  │   💬 Args: [outOpInfo.mUserOp.paymaster]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StakeManager._getStakeInfo(address) (NodeID: 28)
  │   💬 Args: [outOpInfo.mUserOp.sender]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StakeManager._getStakeInfo(address) (NodeID: 29)
  │   💬 Args: [factory]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EntryPoint.getMemoryBytesFromOffset(uint256) (NodeID: 30)
  │   💬 Args: [outOpInfo.contextOffset]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StakeManager._getStakeInfo(address) (NodeID: 31)
      💬 Args: [aggregator]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IEntryPointSimulations

### Interface Documentation

 Simulate a call to account.validateUserOp and paymaster.validatePaymasterUserOp.
 @dev The node must also verify it doesn't use banned opcodes, and that it doesn't reference storage
      outside the account's data.
 @param userOp - The user operation to validate.
 @return the validation result structure
