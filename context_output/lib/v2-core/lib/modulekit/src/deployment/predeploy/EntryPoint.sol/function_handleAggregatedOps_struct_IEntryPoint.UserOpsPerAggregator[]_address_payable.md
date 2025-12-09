# Function: handleAggregatedOps(struct IEntryPoint.UserOpsPerAggregator[],address payable)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `handleAggregatedOps(struct IEntryPoint.UserOpsPerAggregator[],address payable)`
- **Visibility**: public
- **Source Range**: 7480:2459:89
- **Inherited From**: EntryPoint

## Implementation

```solidity
/// @inheritdoc IEntryPoint
function handleAggregatedOps(UserOpsPerAggregator[] calldata opsPerAggregator, address payable beneficiary) public nonReentrant() {
    uint256 opasLen = opsPerAggregator.length;
    uint256 totalOps = 0;
    for (uint256 i = 0; i < opasLen; i++) {
        UserOpsPerAggregator calldata opa = opsPerAggregator[i];
        PackedUserOperation[] calldata ops = opa.userOps;
        IAggregator aggregator = opa.aggregator;
        require(address(aggregator) != address(1), "AA96 invalid aggregator");
        if (address(aggregator) != address(0)) {
            try aggregator.validateSignatures(ops, opa.signature) {} catch {
                revert SignatureValidationFailed(address(aggregator));
            }
        }
        totalOps += ops.length;
    }
    UserOpInfo[] memory opInfos = new UserOpInfo[](totalOps);
    uint256 opIndex = 0;
    for (uint256 a = 0; a < opasLen; a++) {
        UserOpsPerAggregator calldata opa = opsPerAggregator[a];
        PackedUserOperation[] calldata ops = opa.userOps;
        IAggregator aggregator = opa.aggregator;
        uint256 opslen = ops.length;
        for (uint256 i = 0; i < opslen; i++) {
            UserOpInfo memory opInfo = opInfos[opIndex];
            (uint256 validationData, uint256 paymasterValidationData) = _validatePrepayment(opIndex, ops[i], opInfo);
            _validateAccountAndPaymasterValidationData(i, validationData, paymasterValidationData, address(aggregator));
            opIndex++;
        }
    }
    emit BeforeExecution();
    uint256 collected = 0;
    opIndex = 0;
    for (uint256 a = 0; a < opasLen; a++) {
        UserOpsPerAggregator calldata opa = opsPerAggregator[a];
        emit SignatureAggregatorChanged(address(opa.aggregator));
        PackedUserOperation[] calldata ops = opa.userOps;
        uint256 opslen = ops.length;
        for (uint256 i = 0; i < opslen; i++) {
            collected += _executeUserOp(opIndex, ops[i], opInfos[opIndex]);
            opIndex++;
        }
    }
    emit SignatureAggregatorChanged(address(0));
    _compensate(beneficiary, collected);
}
```

## Related Implementations

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

### _validateAccountAndPaymasterValidationData(uint256,uint256,uint256,address)

- **Kind**: internal
- **Source**: 20688:1101:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_validateAccountAndPaymasterValidationData(uint256,uint256,uint256,address)`

```solidity
///  Revert if either account validationData or paymaster validationData is expired.
///  @param opIndex                 - The operation index.
///  @param validationData          - The account validationData.
///  @param paymasterValidationData - The paymaster validationData.
///  @param expectedAggregator      - The expected aggregator.
function _validateAccountAndPaymasterValidationData(uint256 opIndex, uint256 validationData, uint256 paymasterValidationData, address expectedAggregator) internal view {
    (address aggregator, bool outOfTimeRange) = _getValidationData(validationData);
    if (expectedAggregator != aggregator) {
        revert FailedOp(opIndex, "AA24 signature error");
    }
    if (outOfTimeRange) {
        revert FailedOp(opIndex, "AA22 expired or not due");
    }
    address pmAggregator;
    (pmAggregator, outOfTimeRange) = _getValidationData(paymasterValidationData);
    if (pmAggregator != address(0)) {
        revert FailedOp(opIndex, "AA34 signature error");
    }
    if (outOfTimeRange) {
        revert FailedOp(opIndex, "AA32 paymaster expired or not due");
    }
}
```

### _getValidationData(uint256)

- **Kind**: internal
- **Source**: 22119:500:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_getValidationData(uint256)`

```solidity
///  Parse validationData into its components.
///  @param validationData - The packed validation data (sigFailed, validAfter, validUntil).
///  @return aggregator the aggregator of the validationData
///  @return outOfTimeRange true if current time is outside the time range of this validationData.
function _getValidationData(uint256 validationData) internal view returns (address aggregator, bool outOfTimeRange) {
    if (validationData == 0) {
        return (address(0), false);
    }
    ValidationData memory data = _parseValidationData(validationData);
    outOfTimeRange = (block.timestamp > data.validUntil) || (block.timestamp < data.validAfter);
    aggregator = data.aggregator;
}
```

### _parseValidationData(uint256)

- **Kind**: free-function
- **Source**: 1370:416:92
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/Helpers.sol:_parseValidationData(uint256)`

```solidity
///  Extract sigFailed, validAfter, validUntil.
///  Also convert zero validUntil to type(uint48).max.
///  @param validationData - The packed validation data.
function _parseValidationData(uint256 validationData) pure returns (ValidationData memory data) {
    address aggregator = address(uint160(validationData));
    uint48 validUntil = uint48(validationData >> 160);
    if (validUntil == 0) {
        validUntil = type(uint48).max;
    }
    uint48 validAfter = uint48(validationData >> (48 + 160));
    return ValidationData(aggregator, validAfter, validUntil);
}
```

### _executeUserOp(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo)

- **Kind**: internal
- **Source**: 3053:2910:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_executeUserOp(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo)`

```solidity
///  Execute a user operation.
///  @param opIndex    - Index into the opInfo array.
///  @param userOp     - The userOp to execute.
///  @param opInfo     - The opInfo filled by validatePrepayment for this userOp.
///  @return collected - The total amount this userOp paid.
function _executeUserOp(uint256 opIndex, PackedUserOperation calldata userOp, UserOpInfo memory opInfo) internal returns (uint256 collected) {
    uint256 preGas = gasleft();
    bytes memory context = getMemoryBytesFromOffset(opInfo.contextOffset);
    bool success;
    {
        uint256 saveFreePtr;
        assembly ("memory-safe") {
            saveFreePtr := mload(0x40)
        }
        bytes calldata callData = userOp.callData;
        bytes memory innerCall;
        bytes4 methodSig;
        assembly {
            let len := callData.length
            if gt(len, 3) {
                methodSig := calldataload(callData.offset)
            }
        }
        if (methodSig == IAccountExecute.executeUserOp.selector) {
            bytes memory executeUserOp = abi.encodeCall(IAccountExecute.executeUserOp, (userOp, opInfo.userOpHash));
            innerCall = abi.encodeCall(this.innerHandleOp, (executeUserOp, opInfo, context));
        } else {
            innerCall = abi.encodeCall(this.innerHandleOp, (callData, opInfo, context));
        }
        assembly ("memory-safe") {
            success := call(gas(), address(), 0, add(innerCall, 0x20), mload(innerCall), 0, 32)
            collected := mload(0)
            mstore(0x40, saveFreePtr)
        }
    }
    if (!success) {
        bytes32 innerRevertCode;
        assembly ("memory-safe") {
            let len := returndatasize()
            if eq(32, len) {
                returndatacopy(0, 0, 32)
                innerRevertCode := mload(0)
            }
        }
        if (innerRevertCode == INNER_OUT_OF_GAS) {
            revert FailedOp(opIndex, "AA95 out of gas");
        } else if (innerRevertCode == INNER_REVERT_LOW_PREFUND) {
            uint256 actualGas = (preGas - gasleft()) + opInfo.preOpGas;
            uint256 actualGasCost = opInfo.prefund;
            emitPrefundTooLow(opInfo);
            emitUserOperationEvent(opInfo, false, actualGasCost, actualGas);
            collected = actualGasCost;
        } else {
            emit PostOpRevertReason(opInfo.userOpHash, opInfo.mUserOp.sender, opInfo.mUserOp.nonce, Exec.getReturnData(REVERT_REASON_MAX_LEN));
            uint256 actualGas = (preGas - gasleft()) + opInfo.preOpGas;
            collected = _postExecution(IPaymaster.PostOpMode.postOpReverted, opInfo, context, actualGas);
        }
    }
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

### emitPrefundTooLow(struct EntryPoint.UserOpInfo)

- **Kind**: internal
- **Source**: 6385:182:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:emitPrefundTooLow(struct EntryPoint.UserOpInfo)`

```solidity
function emitPrefundTooLow(UserOpInfo memory opInfo) virtual internal {
    emit UserOperationPrefundTooLow(opInfo.userOpHash, opInfo.mUserOp.sender, opInfo.mUserOp.nonce);
}
```

### emitUserOperationEvent(struct EntryPoint.UserOpInfo,bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5969:410:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:emitUserOperationEvent(struct EntryPoint.UserOpInfo,bool,uint256,uint256)`

```solidity
function emitUserOperationEvent(UserOpInfo memory opInfo, bool success, uint256 actualGasCost, uint256 actualGas) virtual internal {
    emit UserOperationEvent(opInfo.userOpHash, opInfo.mUserOp.sender, opInfo.mUserOp.paymaster, opInfo.mUserOp.nonce, success, actualGasCost, actualGas);
}
```

### _postExecution(enum IPaymaster.PostOpMode,struct EntryPoint.UserOpInfo,bytes,uint256)

- **Kind**: internal
- **Source**: 25547:2962:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_postExecution(enum IPaymaster.PostOpMode,struct EntryPoint.UserOpInfo,bytes,uint256)`

```solidity
///  Process post-operation, called just after the callData is executed.
///  If a paymaster is defined and its validation returned a non-empty context, its postOp is called.
///  The excess amount is refunded to the account (or paymaster - if it was used in the request).
///  @param mode      - Whether is called from innerHandleOp, or outside (postOpReverted).
///  @param opInfo    - UserOp fields and info collected during validation.
///  @param context   - The context returned in validatePaymasterUserOp.
///  @param actualGas - The gas used so far by this user operation.
function _postExecution(IPaymaster.PostOpMode mode, UserOpInfo memory opInfo, bytes memory context, uint256 actualGas) private returns (uint256 actualGasCost) {
    uint256 preGas = gasleft();
    unchecked {
        address refundAddress;
        MemoryUserOp memory mUserOp = opInfo.mUserOp;
        uint256 gasPrice = getUserOpGasPrice(mUserOp);
        address paymaster = mUserOp.paymaster;
        if (paymaster == address(0)) {
            refundAddress = mUserOp.sender;
        } else {
            refundAddress = paymaster;
            if (context.length > 0) {
                actualGasCost = actualGas * gasPrice;
                if (mode != IPaymaster.PostOpMode.postOpReverted) {
                    try IPaymaster(paymaster).postOp{gas: mUserOp.paymasterPostOpGasLimit}(mode, context, actualGasCost, gasPrice) {} catch {
                        bytes memory reason = Exec.getReturnData(REVERT_REASON_MAX_LEN);
                        revert PostOpReverted(reason);
                    }
                }
            }
        }
        actualGas += preGas - gasleft();
        {
            uint256 executionGasLimit = mUserOp.callGasLimit + mUserOp.paymasterPostOpGasLimit;
            uint256 executionGasUsed = actualGas - opInfo.preOpGas;
            if (executionGasLimit > executionGasUsed) {
                uint256 unusedGas = executionGasLimit - executionGasUsed;
                uint256 unusedGasPenalty = (unusedGas * PENALTY_PERCENT) / 100;
                actualGas += unusedGasPenalty;
            }
        }
        actualGasCost = actualGas * gasPrice;
        uint256 prefund = opInfo.prefund;
        if (prefund < actualGasCost) {
            if (mode == IPaymaster.PostOpMode.postOpReverted) {
                actualGasCost = prefund;
                emitPrefundTooLow(opInfo);
                emitUserOperationEvent(opInfo, false, actualGasCost, actualGas);
            } else {
                assembly ("memory-safe") {
                    mstore(0, INNER_REVERT_LOW_PREFUND)
                    revert(0, 32)
                }
            }
        } else {
            uint256 refund = prefund - actualGasCost;
            _incrementDeposit(refundAddress, refund);
            bool success = mode == IPaymaster.PostOpMode.opSucceeded;
            emitUserOperationEvent(opInfo, success, actualGasCost, actualGas);
        }
    }
}
```

### getUserOpGasPrice(struct EntryPoint.MemoryUserOp)

- **Kind**: internal
- **Source**: 28740:517:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:getUserOpGasPrice(struct EntryPoint.MemoryUserOp)`

```solidity
///  The gas price this UserOp agrees to pay.
///  Relayer/block builder might submit the TX with higher priorityFee, but the user should not.
///  @param mUserOp - The userOp to get the gas price from.
function getUserOpGasPrice(MemoryUserOp memory mUserOp) internal view returns (uint256) {
    unchecked {
        uint256 maxFeePerGas = mUserOp.maxFeePerGas;
        uint256 maxPriorityFeePerGas = mUserOp.maxPriorityFeePerGas;
        if (maxFeePerGas == maxPriorityFeePerGas) {
            return maxFeePerGas;
        }
        return min(maxFeePerGas, maxPriorityFeePerGas + block.basefee);
    }
}
```

### min(uint256,uint256)

- **Kind**: free-function
- **Source**: 3263:95:92
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/Helpers.sol:min(uint256,uint256)`

```solidity
///  The minimum of two numbers.
///  @param a - First number.
///  @param b - Second number.
function min(uint256 a, uint256 b) pure returns (uint256) {
    return (a < b) ? a : b;
}
```

### _incrementDeposit(address,uint256)

- **Kind**: internal
- **Source**: 1559:259:95
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/StakeManager.sol:StakeManager:_incrementDeposit(address,uint256)`

```solidity
///  Increments an account's deposit.
///  @param account - The account to increment.
///  @param amount  - The amount to increment by.
///  @return the updated deposit of this account
function _incrementDeposit(address account, uint256 amount) internal returns (uint256) {
    DepositInfo storage info = deposits[account];
    uint256 newAmount = info.deposit + amount;
    info.deposit = newAmount;
    return newAmount;
}
```

### _compensate(address payable,uint256)

- **Kind**: internal
- **Source**: 2468:278:89
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPoint.sol:EntryPoint:_compensate(address payable,uint256)`

```solidity
///  Compensate the caller's beneficiary address with the collected fees of all UserOperations.
///  @param beneficiary - The address to receive the fees.
///  @param amount      - Amount to transfer.
function _compensate(address payable beneficiary, uint256 amount) internal {
    require(beneficiary != address(0), "AA90 invalid beneficiary");
    (bool success, ) = beneficiary.call{value: amount}("");
    require(success, "AA91 failed send to beneficiary");
}
```

### nonReentrant()

- **Kind**: modifier
- **Source**: 2466:103:282
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:nonReentrant()`

```solidity
///  @dev Prevents a contract from calling itself, directly or indirectly.
///  Calling a `nonReentrant` function from another `nonReentrant`
///  function is not supported. It is possible to prevent this from happening
///  by making the `nonReentrant` function external, and making it call a
///  `private` function that does the actual work.
modifier nonReentrant() {
    _nonReentrantBefore();
    _;
    _nonReentrantAfter();
}
```

### _nonReentrantBefore()

- **Kind**: internal
- **Source**: 2575:307:282
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:_nonReentrantBefore()`

```solidity
function _nonReentrantBefore() private {
    if (_status == ENTERED) {
        revert ReentrancyGuardReentrantCall();
    }
    _status = ENTERED;
}
```

### _nonReentrantAfter()

- **Kind**: internal
- **Source**: 2888:208:282
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:_nonReentrantAfter()`

```solidity
function _nonReentrantAfter() private {
    _status = NOT_ENTERED;
}
```

## External Calls

- **IAggregator::validateSignatures(struct PackedUserOperation[],bytes)**

## State Variable Reads

- **PAYMASTER_VALIDATION_GAS_OFFSET** (`uint256`)
- **PAYMASTER_POSTOP_GAS_OFFSET** (`uint256`)
- **PAYMASTER_DATA_OFFSET** (`uint256`)
- **REVERT_REASON_MAX_LEN** (`uint256`)
- **_newSenderCreator** (`contract SenderCreator`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/SenderCreator.sol/contract_SenderCreator.md]
- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)
- **INNER_OUT_OF_GAS** (`bytes32`)
- **INNER_REVERT_LOW_PREFUND** (`bytes32`)
- **PENALTY_PERCENT** (`uint256`)
- **_status** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## State Variable Writes

- **gasConsumed** (`mapping(address => mapping(uint256 => uint256))`)
- **nonceSequenceNumber** (`mapping(address => mapping(uint192 => uint256))`)
- **_status** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EntryPoint.handleAggregatedOps(struct IEntryPoint.UserOpsPerAggregator[],address payable) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: EntryPoint._validatePrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo) (NodeID: 1)
  │   💬 Args: [opIndex, ops[i], opInfo]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint._copyUserOpToMemory(struct PackedUserOperation,struct EntryPoint.MemoryUserOp) (NodeID: 2)
  │ │   💬 Args: [userOp, mUserOp]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: UserOperationLib.unpackUints(bytes32) (NodeID: 3)
  │ │ │   💬 Args: [userOp.accountGasLimits]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: UserOperationLib.unpackUints(bytes32) (NodeID: 4)
  │ │ │   💬 Args: [userOp.gasFees]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: UserOperationLib.unpackPaymasterStaticFields(bytes) (NodeID: 5)
  │ │     💬 Args: [paymasterAndData]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint.getUserOpHash(struct PackedUserOperation) (NodeID: 6)
  │ │   💬 Args: [userOp]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: UserOperationLib.hash(struct PackedUserOperation) (NodeID: 7)
  │ │     💬 Args: [userOp]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: UserOperationLib.encode(struct PackedUserOperation) (NodeID: 8)
  │ │       💬 Args: [userOp]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: UserOperationLib.getSender(struct PackedUserOperation) (NodeID: 9)
  │ │     │   💬 Args: [userOp]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.calldataKeccak(bytes) (NodeID: 10)
  │ │     │   💬 Args: [userOp.initCode]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.calldataKeccak(bytes) (NodeID: 11)
  │ │     │   💬 Args: [userOp.callData]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Unknown.calldataKeccak(bytes) (NodeID: 12)
  │ │         💬 Args: [userOp.paymasterAndData]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint._getRequiredPrefund(struct EntryPoint.MemoryUserOp) (NodeID: 13)
  │ │   💬 Args: [mUserOp]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint._validateAccountPrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo,uint256,uint256) (NodeID: 14)
  │ │   💬 Args: [opIndex, userOp, outOpInfo, requiredPreFund, verificationGasLimit]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: EntryPoint._createSenderIfNeeded(uint256,struct EntryPoint.UserOpInfo,bytes) (NodeID: 15)
  │ │ │   💬 Args: [opIndex, opInfo, op.initCode]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: EntryPointSimulationsPatch.senderCreator() (NodeID: 16)
  │ │ │ │   💬 Args: [no args]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: GasDebug.setGasConsumed(address,uint256,uint256) (NodeID: 17)
  │ │ │     💬 Args: [sender, 0, _creationGas - gasleft()]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StakeManager.balanceOf(address) (NodeID: 18)
  │ │ │   💬 Args: [sender]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: GasDebug.setGasConsumed(address,uint256,uint256) (NodeID: 19)
  │ │ │   💬 Args: [sender, 1, _verificationGas - gasleft()]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Exec.getReturnData(uint256) (NodeID: 20)
  │ │     💬 Args: [REVERT_REASON_MAX_LEN]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: NonceManager._validateAndUpdateNonce(address,uint256) (NodeID: 21)
  │ │   💬 Args: [mUserOp.sender, mUserOp.nonce]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint._validatePaymasterPrepayment(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo,uint256) (NodeID: 22)
  │ │   💬 Args: [opIndex, userOp, outOpInfo, requiredPreFund]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Exec.getReturnData(uint256) (NodeID: 23)
  │ │     💬 Args: [REVERT_REASON_MAX_LEN]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EntryPoint.getOffsetOfMemoryBytes(bytes) (NodeID: 24)
  │     💬 Args: [context]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EntryPoint._validateAccountAndPaymasterValidationData(uint256,uint256,uint256,address) (NodeID: 25)
  │   💬 Args: [i, validationData, paymasterValidationData, address(aggregator)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint._getValidationData(uint256) (NodeID: 26)
  │ │   💬 Args: [validationData]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown._parseValidationData(uint256) (NodeID: 27)
  │ │     💬 Args: [validationData]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EntryPoint._getValidationData(uint256) (NodeID: 28)
  │     💬 Args: [paymasterValidationData]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Unknown._parseValidationData(uint256) (NodeID: 29)
  │       💬 Args: [validationData]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EntryPoint._executeUserOp(uint256,struct PackedUserOperation,struct EntryPoint.UserOpInfo) (NodeID: 30)
  │   💬 Args: [opIndex, ops[i], opInfos[opIndex]]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint.getMemoryBytesFromOffset(uint256) (NodeID: 31)
  │ │   💬 Args: [opInfo.contextOffset]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint.emitPrefundTooLow(struct EntryPoint.UserOpInfo) (NodeID: 32)
  │ │   💬 Args: [opInfo]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EntryPoint.emitUserOperationEvent(struct EntryPoint.UserOpInfo,bool,uint256,uint256) (NodeID: 33)
  │ │   💬 Args: [opInfo, false, actualGasCost, actualGas]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Exec.getReturnData(uint256) (NodeID: 34)
  │ │   💬 Args: [REVERT_REASON_MAX_LEN]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EntryPoint._postExecution(enum IPaymaster.PostOpMode,struct EntryPoint.UserOpInfo,bytes,uint256) (NodeID: 35)
  │     💬 Args: [IPaymaster.PostOpMode.postOpReverted, opInfo, context, actualGas]
  │     👁️  Def: private
  │   ├─ [3] ⚙️ FUNCTION: EntryPoint.getUserOpGasPrice(struct EntryPoint.MemoryUserOp) (NodeID: 36)
  │   │   💬 Args: [mUserOp]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.min(uint256,uint256) (NodeID: 37)
  │   │     💬 Args: [maxFeePerGas, maxPriorityFeePerGas + block.basefee]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Exec.getReturnData(uint256) (NodeID: 38)
  │   │   💬 Args: [REVERT_REASON_MAX_LEN]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: EntryPoint.emitPrefundTooLow(struct EntryPoint.UserOpInfo) (NodeID: 39)
  │   │   💬 Args: [opInfo]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: EntryPoint.emitUserOperationEvent(struct EntryPoint.UserOpInfo,bool,uint256,uint256) (NodeID: 40)
  │   │   💬 Args: [opInfo, false, actualGasCost, actualGas]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: StakeManager._incrementDeposit(address,uint256) (NodeID: 41)
  │   │   💬 Args: [refundAddress, refund]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EntryPoint.emitUserOperationEvent(struct EntryPoint.UserOpInfo,bool,uint256,uint256) (NodeID: 42)
  │       💬 Args: [opInfo, success, actualGasCost, actualGas]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EntryPoint._compensate(address payable,uint256) (NodeID: 43)
  │   💬 Args: [beneficiary, collected]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: ReentrancyGuard.nonReentrant() (NodeID: 44)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantBefore() (NodeID: 45)
    │   💬 Args: [no args]
    │   👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantAfter() (NodeID: 46)
        💬 Args: [no args]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IEntryPoint

### Interface Documentation

 Execute a batch of UserOperation with Aggregators
 @param opsPerAggregator - The operations to execute, grouped by aggregator (or address(0) for no-aggregator accounts).
 @param beneficiary      - The address to receive the fees.
