# Function: innerHandleOp(bytes,struct EntryPoint.UserOpInfo,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `innerHandleOp(bytes,struct EntryPoint.UserOpInfo,bytes)`
- **Visibility**: external
- **Source Range**: 11037:1587:89
- **Inherited From**: EntryPoint

## Implementation

```solidity
///  Inner function to handle a UserOperation.
///  Must be declared "external" to open a call context, but it can only be called by handleOps.
///  @param callData - The callData to execute.
///  @param opInfo   - The UserOpInfo struct.
///  @param context  - The context bytes.
///  @return actualGasCost - the actual cost in eth this UserOperation paid for gas
function innerHandleOp(bytes memory callData, UserOpInfo memory opInfo, bytes calldata context) external returns (uint256 actualGasCost) {
    uint256 preGas = gasleft();
    require(msg.sender == address(this), "AA92 internal call only");
    MemoryUserOp memory mUserOp = opInfo.mUserOp;
    uint256 callGasLimit = mUserOp.callGasLimit;
    unchecked {
        if (((gasleft() * 63) / 64) < ((callGasLimit + mUserOp.paymasterPostOpGasLimit) + INNER_GAS_OVERHEAD)) {
            assembly ("memory-safe") {
                mstore(0, INNER_OUT_OF_GAS)
                revert(0, 32)
            }
        }
    }
    IPaymaster.PostOpMode mode = IPaymaster.PostOpMode.opSucceeded;
    if (callData.length > 0) {
        uint256 _execGas = gasleft();
        bool success = Exec.call(mUserOp.sender, 0, callData, callGasLimit);
        setGasConsumed(mUserOp.sender, 2, _execGas - gasleft());
        if (!success) {
            bytes memory result = Exec.getReturnData(REVERT_REASON_MAX_LEN);
            if (result.length > 0) {
                emit UserOperationRevertReason(opInfo.userOpHash, mUserOp.sender, mUserOp.nonce, result);
            }
            mode = IPaymaster.PostOpMode.opReverted;
        }
    }
    unchecked {
        uint256 actualGas = (preGas - gasleft()) + opInfo.preOpGas;
        return _postExecution(mode, opInfo, context, actualGas);
    }
}
```

## Related Implementations

### call(address,uint256,bytes,uint256)

- **Kind**: internal
- **Source**: 223:279:106
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/utils/Exec.sol:Exec:call(address,uint256,bytes,uint256)`

```solidity
function call(address to, uint256 value, bytes memory data, uint256 txGas) internal returns (bool success) {
    assembly ("memory-safe") {
        success := call(txGas, to, value, add(data, 0x20), mload(data), 0, 0)
    }
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

## External Calls

- **unknown::call(address,uint256,bytes,uint256)**
- **unknown::unknown**

## Native Transfers

- **Exec** (computed)

## State Variable Reads

- **INNER_GAS_OVERHEAD** (`uint256`)
- **REVERT_REASON_MAX_LEN** (`uint256`)
- **PENALTY_PERCENT** (`uint256`)
- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## State Variable Writes

- **gasConsumed** (`mapping(address => mapping(uint256 => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EntryPoint.innerHandleOp(bytes,struct EntryPoint.UserOpInfo,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Exec.call(address,uint256,bytes,uint256) (NodeID: 1)
  │   💬 Args: [mUserOp.sender, 0, callData, callGasLimit]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GasDebug.setGasConsumed(address,uint256,uint256) (NodeID: 2)
  │   💬 Args: [mUserOp.sender, 2, _execGas - gasleft()]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Exec.getReturnData(uint256) (NodeID: 3)
  │   💬 Args: [REVERT_REASON_MAX_LEN]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: EntryPoint._postExecution(enum IPaymaster.PostOpMode,struct EntryPoint.UserOpInfo,bytes,uint256) (NodeID: 4)
      💬 Args: [mode, opInfo, context, actualGas]
      👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: EntryPoint.getUserOpGasPrice(struct EntryPoint.MemoryUserOp) (NodeID: 5)
    │   💬 Args: [mUserOp]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.min(uint256,uint256) (NodeID: 6)
    │     💬 Args: [maxFeePerGas, maxPriorityFeePerGas + block.basefee]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Exec.getReturnData(uint256) (NodeID: 7)
    │   💬 Args: [REVERT_REASON_MAX_LEN]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: EntryPoint.emitPrefundTooLow(struct EntryPoint.UserOpInfo) (NodeID: 8)
    │   💬 Args: [opInfo]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: EntryPoint.emitUserOperationEvent(struct EntryPoint.UserOpInfo,bool,uint256,uint256) (NodeID: 9)
    │   💬 Args: [opInfo, false, actualGasCost, actualGas]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StakeManager._incrementDeposit(address,uint256) (NodeID: 10)
    │   💬 Args: [refundAddress, refund]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EntryPoint.emitUserOperationEvent(struct EntryPoint.UserOpInfo,bool,uint256,uint256) (NodeID: 11)
        💬 Args: [opInfo, success, actualGasCost, actualGas]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 Inner function to handle a UserOperation.
 Must be declared "external" to open a call context, but it can only be called by handleOps.
 @param callData - The callData to execute.
 @param opInfo   - The UserOpInfo struct.
 @param context  - The context bytes.
 @return actualGasCost - the actual cost in eth this UserOperation paid for gas
