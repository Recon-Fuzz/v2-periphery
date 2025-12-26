# Function: execute(bytes)

**Contract**: [lib/v2-core/src/executors/SuperExecutor.sol/contract_SuperExecutor.md]

## Metadata

- **Contract**: SuperExecutor
- **Signature**: `execute(bytes)`
- **Visibility**: external
- **Source Range**: 5201:216:362
- **Inherited From**: SuperExecutorBase

## Implementation

```solidity
/// @inheritdoc ISuperExecutor
function execute(bytes calldata data) virtual external {
    if (!_initialized[msg.sender]) {
        revert NOT_INITIALIZED();
    }
    _execute(msg.sender, abi.decode(data, (ExecutorEntry)));
}
```

## Related Implementations

### _execute(address,struct ISuperExecutor.ExecutorEntry)

- **Kind**: internal
- **Source**: 7331:1034:362
- **Link**: `lib/v2-core/src/executors/SuperExecutorBase.sol:SuperExecutorBase:_execute(address,struct ISuperExecutor.ExecutorEntry)`

```solidity
/// @notice Processes a set of hooks in sequence
///  @dev Core execution flow handler that iterates through hooks and processes them
///       Hooks are executed in sequence with results from previous hooks available to later ones
///       Each hook is processed through the _processHook method
///  @param account The smart account executing the operation
///  @param entry The executor entry containing hook addresses and their data
function _execute(address account, ExecutorEntry memory entry) virtual internal {
    uint256 hooksLen = entry.hooksAddresses.length;
    if (hooksLen == 0) revert NO_HOOKS();
    if (hooksLen != entry.hooksData.length) revert LENGTH_MISMATCH();
    address prevHook;
    address currentHook;
    for (uint256 i; i < hooksLen; ++i) {
        currentHook = entry.hooksAddresses[i];
        if (currentHook == address(0)) revert ADDRESS_NOT_VALID();
        _processHook(account, ISuperHook(currentHook), prevHook, entry.hooksData[i]);
        prevHook = currentHook;
    }
}
```

### _processHook(address,contract ISuperHook,address,bytes)

- **Kind**: internal
- **Source**: 15123:1102:362
- **Link**: `lib/v2-core/src/executors/SuperExecutorBase.sol:SuperExecutorBase:_processHook(address,contract ISuperHook,address,bytes)`

```solidity
/// @notice Processes a single hook through its complete lifecycle
///  @dev Manages the hook execution flow with these stages:
///       1. preExecute - Prepares the hook and validates inputs
///       2. build - Generates the execution instructions
///       3. execute - Performs the generated executions
///       4. postExecute - Finalizes the execution and sets output values
///       5. updateAccounting - Updates ledger records based on hook results
///       6. checkAndLockForSuperPosition - Handles cross-chain asset locking if needed
///  @param account The smart account executing the operation
///  @param hook The hook to process
///  @param prevHook The previous hook in the sequence (or address(0) if first)
///  @param hookData The data provided to the hook for execution
function _processHook(address account, ISuperHook hook, address prevHook, bytes memory hookData) internal nonReentrant() {
    Execution[] memory executions = validateHookCompliance(address(hook), prevHook, account, hookData);
    if (executions.length == 0) {
        revert MALICIOUS_HOOK_DETECTED();
    }
    hook.setExecutionContext(account);
    _execute(account, executions);
    address _lastCaller = hook.lastCaller();
    if (_lastCaller != address(this)) {
        revert INVALID_CALLER();
    }
    hook.resetExecutionState(account);
    _updateAccounting(account, address(hook), hookData);
}
```

### validateHookCompliance(address,address,address,bytes)

- **Kind**: internal
- **Source**: 5492:1189:362
- **Link**: `lib/v2-core/src/executors/SuperExecutorBase.sol:SuperExecutorBase:validateHookCompliance(address,address,address,bytes)`

```solidity
/// @notice Validates that hook follows secure execution pattern
function validateHookCompliance(address hook, address prevHook, address account, bytes memory hookData) public view returns (Execution[] memory) {
    Execution[] memory empty = new Execution[](0);
    Execution[] memory executions = ISuperHook(hook).build(prevHook, account, hookData);
    if (executions.length < 2) return empty;
    if (executions[0].target != hook) return empty;
    bytes4 firstSelector = bytes4(executions[0].callData);
    if (firstSelector != ISuperHook.preExecute.selector) return empty;
    uint256 lastIdx = executions.length - 1;
    if (executions[lastIdx].target != hook) return empty;
    bytes4 lastSelector = bytes4(executions[lastIdx].callData);
    if (lastSelector != ISuperHook.postExecute.selector) return empty;
    for (uint256 i = 1; i < lastIdx; i++) {
        if (executions[i].target == hook) return empty;
    }
    return executions;
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
- **Source**: 8911:2672:362
- **Link**: `lib/v2-core/src/executors/SuperExecutorBase.sol:SuperExecutorBase:_updateAccounting(address,address,bytes)`

```solidity
/// @notice Updates accounting records after hook execution
///  @dev Integrates with the ledger system to record inflows and outflows
///       For INFLOW hooks: Records new share acquisition
///       For OUTFLOW hooks: Records share consumption and calculates yield fees
///       For NONACCOUNTING hooks: No ledger update is performed
///  @param account The smart account executing the operation
///  @param hook The hook that was just executed
///  @param hookData The data provided to the hook for execution
function _updateAccounting(address account, address hook, bytes memory hookData) virtual internal {
    uint256 feeAmount;
    ISuperHook.HookType _type = ISuperHookResult(hook).hookType();
    if ((_type == ISuperHook.HookType.INFLOW) || (_type == ISuperHook.HookType.OUTFLOW)) {
        bytes32 yieldSourceOracleId = hookData.extractYieldSourceOracleId();
        address yieldSource = hookData.extractYieldSource();
        ISuperLedgerConfiguration.YieldSourceOracleConfig memory config = LEDGER_CONFIGURATION.getYieldSourceOracleConfig(yieldSourceOracleId);
        if (config.manager == address(0)) revert MANAGER_NOT_SET();
        uint256 _outAmount = ISuperHookResult(address(hook)).getOutAmount(account);
        feeAmount = ISuperLedger(config.ledger).updateAccounting(account, yieldSource, yieldSourceOracleId, _type == ISuperHook.HookType.INFLOW, _outAmount, ISuperHookResultOutflow(address(hook)).usedShares());
        if ((feeAmount > 0) && (_type == ISuperHook.HookType.OUTFLOW)) {
            if (feeAmount > _outAmount) revert INVALID_FEE();
            address assetToken = ISuperHookResultOutflow(hook).asset();
            if ((assetToken == address(0)) || (assetToken == NATIVE_TOKEN_SENTINEL)) {
                if (account.balance < feeAmount) revert INSUFFICIENT_BALANCE_FOR_FEE();
                _performNativeFeeTransfer(account, config.feeRecipient, feeAmount);
            } else {
                if (IERC20(assetToken).balanceOf(account) < feeAmount) revert INSUFFICIENT_BALANCE_FOR_FEE();
                _performErc20FeeTransfer(account, assetToken, config.feeRecipient, feeAmount);
            }
            ISuperHookSetter(hook).setOutAmount(_outAmount - feeAmount, account);
        }
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

### _performNativeFeeTransfer(address,address,uint256)

- **Kind**: internal
- **Source**: 13675:614:362
- **Link**: `lib/v2-core/src/executors/SuperExecutorBase.sol:SuperExecutorBase:_performNativeFeeTransfer(address,address,uint256)`

```solidity
/// @notice Executes a native token (ETH/MATIC) fee transfer from the account
///  @dev Creates and executes a native transfer operation on behalf of the account
///       Verifies the transfer was successful by checking recipient balance changes
///  @param account The smart account executing the operation
///  @param feeRecipient The address to receive the fee
///  @param feeAmount The amount of native tokens to transfer as a fee
function _performNativeFeeTransfer(address account, address feeRecipient, uint256 feeAmount) virtual internal {
    uint256 balanceBefore = feeRecipient.balance;
    _execute(account, feeRecipient, feeAmount, "");
    uint256 balanceAfter = feeRecipient.balance;
    if ((balanceAfter - balanceBefore) != feeAmount) revert FEE_NOT_TRANSFERRED();
}
```

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

### encodeSingle(address,uint256,bytes)

- **Kind**: internal
- **Source**: 2879:261:154
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/erc7579/lib/ExecutionLib.sol:ExecutionLib:encodeSingle(address,uint256,bytes)`

```solidity
function encodeSingle(address target, uint256 value, bytes memory callData) internal pure returns (bytes memory userOpCalldata) {
    userOpCalldata = abi.encodePacked(target, value, callData);
}
```

### _performErc20FeeTransfer(address,address,address,uint256)

- **Kind**: internal
- **Source**: 12153:1061:362
- **Link**: `lib/v2-core/src/executors/SuperExecutorBase.sol:SuperExecutorBase:_performErc20FeeTransfer(address,address,address,uint256)`

```solidity
/// @notice Executes an ERC20 token fee transfer from the account
///  @dev Creates and executes a transfer operation on behalf of the account
///       Verifies the transfer was successful by checking recipient balance changes
///       Includes tolerance for tokens with transfer fees or rounding issues
///  @param account The smart account executing the operation
///  @param assetToken The ERC20 token to transfer
///  @param feeRecipient The address to receive the fee
///  @param feeAmount The amount of tokens to transfer as a fee
function _performErc20FeeTransfer(address account, address assetToken, address feeRecipient, uint256 feeAmount) virtual internal {
    uint256 balanceBefore = IERC20(assetToken).balanceOf(feeRecipient);
    _execute(account, assetToken, 0, abi.encodeCall(IERC20.transfer, (feeRecipient, feeAmount)));
    uint256 balanceAfter = IERC20(assetToken).balanceOf(feeRecipient);
    uint256 actualFee = balanceAfter - balanceBefore;
    uint256 maxAllowedDeviation = feeAmount.mulDiv(FEE_TOLERANCE, FEE_TOLERANCE_DENOMINATOR);
    if ((actualFee < (feeAmount - maxAllowedDeviation)) || (actualFee > (feeAmount + maxAllowedDeviation))) {
        revert FEE_NOT_TRANSFERRED();
    }
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

```solidity
///  @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
///  denominator == 0.
///  Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
///  Uniswap Labs also under MIT license.
function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
    unchecked {
        (uint256 high, uint256 low) = mul512(x, y);
        if (high == 0) {
            return low / denominator;
        }
        if (denominator <= high) {
            Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
        }
        uint256 remainder;
        assembly ("memory-safe") {
            remainder := mulmod(x, y, denominator)
            high := sub(high, gt(remainder, low))
            low := sub(low, remainder)
        }
        uint256 twos = denominator & (0 - denominator);
        assembly ("memory-safe") {
            denominator := div(denominator, twos)
            low := div(low, twos)
            twos := add(div(sub(0, twos), twos), 1)
        }
        low |= high * twos;
        uint256 inverse = (3 * denominator) ^ 2;
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        result = low * inverse;
        return result;
    }
}
```

### mul512(uint256,uint256)

- **Kind**: internal
- **Source**: 1027:550:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

```solidity
///  @dev Return the 512-bit multiplication of two uint256.
///  The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
function mul512(uint256 a, uint256 b) internal pure returns (uint256 high, uint256 low) {
    assembly ("memory-safe") {
        let mm := mulmod(a, b, not(0))
        low := mul(a, b)
        high := sub(sub(mm, low), lt(mm, low))
    }
}
```

### panic(uint256)

- **Kind**: internal
- **Source**: 1776:194:281
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

```solidity
/// @dev Reverts with a panic code. Recommended to use with
///  the internal constants with predefined codes.
function panic(uint256 code) internal pure {
    assembly ("memory-safe") {
        mstore(0x00, 0x4e487b71)
        mstore(0x20, code)
        revert(0x1c, 0x24)
    }
}
```

### ternary(bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5071:294:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

```solidity
///  @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
///  IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
///  However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
///  one branch when needed, making this function more expensive.
function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
    unchecked {
        return b ^ ((a ^ b) * SafeCast.toUint(condition));
    }
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

```solidity
///  @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
function toUint(bool b) internal pure returns (uint256 u) {
    assembly ("memory-safe") {
        u := iszero(iszero(b))
    }
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

- **ISuperHook::setExecutionContext(address)**
- **ISuperHook::lastCaller()**
- **ISuperHook::resetExecutionState(address)**
- **ISuperHook::build(address,address,bytes)**
- **IERC7579Account::executeFromExecutor(ModeCode,bytes)**
- **ISuperHookResult::hookType()**
- **ISuperLedgerConfiguration::getYieldSourceOracleConfig(bytes32)**
- **ISuperHookResult::getOutAmount(address)**
- **ISuperLedger::updateAccounting(address,address,bytes32,bool,uint256,uint256)**
- **ISuperHookResultOutflow::usedShares()**
- **ISuperHookResultOutflow::asset()**
- **IERC20::balanceOf(address)**
- **ISuperHookSetter::setOutAmount(uint256,address)**

## State Variable Reads

- **_initialized** (`mapping(address => bool)`)
- **LEDGER_CONFIGURATION** (`contract ISuperLedgerConfiguration`) [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]
- **NATIVE_TOKEN_SENTINEL** (`address`)
- **FEE_TOLERANCE** (`uint256`)
- **FEE_TOLERANCE_DENOMINATOR** (`uint256`)
- **_status** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## State Variable Writes

- **_status** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperExecutorBase.execute(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperExecutorBase._execute(address,struct ISuperExecutor.ExecutorEntry) (NodeID: 1)
      💬 Args: [msg.sender, abi.decode(data, (ExecutorEntry))]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperExecutorBase._processHook(address,contract ISuperHook,address,bytes) (NodeID: 2)
        💬 Args: [account, ISuperHook(currentHook), prevHook, entry.hooksData[i]]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SuperExecutorBase.validateHookCompliance(address,address,address,bytes) (NodeID: 3)
      │   💬 Args: [address(hook), prevHook, account, hookData]
      │   👁️  Def: public
      ├─ [3] ⚙️ FUNCTION: ERC7579ExecutorBase._execute(address,struct Execution[]) (NodeID: 4)
      │   💬 Args: [account, executions]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 5)
      │ │   💬 Args: [CALLTYPE_BATCH, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ExecutionLib.encodeBatch(struct Execution[]) (NodeID: 6)
      │     💬 Args: [execs]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SuperExecutorBase._updateAccounting(address,address,bytes) (NodeID: 7)
      │   💬 Args: [account, address(hook), hookData]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: HookDataDecoder.extractYieldSourceOracleId(bytes) (NodeID: 8)
      │ │   💬 Args: [hookData]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 9)
      │ │     💬 Args: [data, 0, 32]
      │ │     👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 10)
      │ │   💬 Args: [hookData]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 11)
      │ │     💬 Args: [data, 32]
      │ │     👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SuperExecutorBase._performNativeFeeTransfer(address,address,uint256) (NodeID: 12)
      │ │   💬 Args: [account, config.feeRecipient, feeAmount]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: ERC7579ExecutorBase._execute(address,address,uint256,bytes) (NodeID: 13)
      │ │     💬 Args: [account, feeRecipient, feeAmount, ""]
      │ │     👁️  Def: internal
      │ │   ├─ [6] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 14)
      │ │   │   💬 Args: [CALLTYPE_SINGLE, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
      │ │   │   👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: ExecutionLib.encodeSingle(address,uint256,bytes) (NodeID: 15)
      │ │       💬 Args: [to, value, data]
      │ │       👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: SuperExecutorBase._performErc20FeeTransfer(address,address,address,uint256) (NodeID: 16)
      │     💬 Args: [account, assetToken, config.feeRecipient, feeAmount]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: ERC7579ExecutorBase._execute(address,address,uint256,bytes) (NodeID: 17)
      │   │   💬 Args: [account, assetToken, 0, abi.encodeCall(IERC20.transfer, (feeRecipient, feeAmount))]
      │   │   👁️  Def: internal
      │   │ ├─ [6] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 18)
      │   │ │   💬 Args: [CALLTYPE_SINGLE, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
      │   │ │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: ExecutionLib.encodeSingle(address,uint256,bytes) (NodeID: 19)
      │   │     💬 Args: [to, value, data]
      │   │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 20)
      │       💬 Args: [feeAmount, FEE_TOLERANCE, FEE_TOLERANCE_DENOMINATOR]
      │       👁️  Def: internal
      │     ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 21)
      │     │   💬 Args: [x, y]
      │     │   👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 22)
      │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │         👁️  Def: internal
      │       └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 23)
      │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │           👁️  Def: internal
      │         └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 24)
      │             💬 Args: [condition]
      │             👁️  Def: internal
      └─ [3] 🔒 MODIFIER: ReentrancyGuard.nonReentrant() (NodeID: 25)
          💬 Args: [no args]
        ├─ [4] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantBefore() (NodeID: 26)
        │   💬 Args: [no args]
        │   👁️  Def: private
        └─ [4] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantAfter() (NodeID: 27)
            💬 Args: [no args]
            👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperExecutor

### Interface Documentation

@notice Executes a sequence of hooks with their respective parameters
 @dev The main entry point for executing hook sequences
      The input data should be encoded ExecutorEntry struct
      Hooks are executed in sequence, with results from each hook potentially
      influencing the execution of subsequent hooks
      Each hook's execution involves calling preExecute, build, and postExecute
 @param data ABI-encoded ExecutorEntry containing hooks and their parameters
