# Function: preExecute(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol/contract_SwapUniswapV4Hook.md]

## Metadata

- **Contract**: SwapUniswapV4Hook
- **Signature**: `preExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 6572:390:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @inheritdoc ISuperHook
function preExecute(address prevHook, address account, bytes calldata data) external {
    if (msg.sender != account) revert UNAUTHORIZED_CALLER();
    uint256 context = _getCurrentExecutionContext(account);
    if (_getPreExecuteMutex(context)) revert PRE_EXECUTE_ALREADY_CALLED();
    _setPreExecuteMutex(context, true);
    _preExecute(prevHook, account, data);
}
```

## Related Implementations

### _getCurrentExecutionContext(address)

- **Kind**: internal
- **Source**: 13205:216:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_getCurrentExecutionContext(address)`

```solidity
function _getCurrentExecutionContext(address caller) private view returns (uint256 context) {
    bytes32 key = _makeAccountContextKey(caller);
    assembly {
        context := tload(key)
    }
}
```

### _makeAccountContextKey(address)

- **Kind**: internal
- **Source**: 12565:165:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_makeAccountContextKey(address)`

```solidity
function _makeAccountContextKey(address account) private pure returns (bytes32) {
    return keccak256(abi.encodePacked(ACCOUNT_CONTEXT_STORAGE, account));
}
```

### _getPreExecuteMutex(uint256)

- **Kind**: internal
- **Source**: 14077:215:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_getPreExecuteMutex(uint256)`

```solidity
function _getPreExecuteMutex(uint256 context) private view returns (bool value) {
    bytes32 key = _makeKey(context, PRE_EXECUTE_MUTEX_OFFSET);
    assembly {
        value := tload(key)
    }
}
```

### _makeKey(uint256,uint256)

- **Kind**: internal
- **Source**: 13427:174:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_makeKey(uint256,uint256)`

```solidity
function _makeKey(uint256 context, uint256 offset) private pure returns (bytes32) {
    return keccak256(abi.encodePacked(HOOK_EXECUTION_STORAGE, context, offset));
}
```

### _setPreExecuteMutex(uint256,bool)

- **Kind**: internal
- **Source**: 14298:200:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_setPreExecuteMutex(uint256,bool)`

```solidity
function _setPreExecuteMutex(uint256 context, bool value) private {
    bytes32 key = _makeKey(context, PRE_EXECUTE_MUTEX_OFFSET);
    assembly {
        tstore(key, value)
    }
}
```

### _preExecute(address,address,bytes)

- **Kind**: internal
- **Source**: 8841:822:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_preExecute(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _preExecute(address prevHook, address account, bytes calldata data) override internal {
    (asset, ) = _getTransferParams(prevHook, account, data);
    address outputToken = _getOutputToken(data);
    address dstReceiver = data.toAddress(68);
    if (outputToken == address(0)) {
        initialBalance = dstReceiver.balance;
    } else {
        initialBalance = IERC20(outputToken).balanceOf(dstReceiver);
    }
    bytes memory unlockData = _prepareUnlockData(prevHook, account, data);
    _storeUnlockData(unlockData);
}
```

### _getTransferParams(address,address,bytes)

- **Kind**: internal
- **Source**: 23930:841:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_getTransferParams(address,address,bytes)`

```solidity
/// @notice Extract transfer parameters without causing stack depth issues
///  @param prevHook The previous hook in the chain
///  @param account The account executing the hook
///  @param data The encoded hook data
///  @return inputToken The input token address
///  @return amountIn The amount to transfer
function _getTransferParams(address prevHook, address account, bytes calldata data) internal view returns (address inputToken, uint256 amountIn) {
    address currency0 = data.toAddress(0);
    address currency1 = data.toAddress(20);
    bool zeroForOne = _decodeBool(data, 216);
    bool usePrevHookAmount = _decodeBool(data, 217);
    inputToken = zeroForOne ? currency0 : currency1;
    if (usePrevHookAmount) {
        amountIn = ISuperHookResult(prevHook).getOutAmount(account);
    } else {
        amountIn = data.toUint256(120);
    }
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

### _decodeBool(bytes,uint256)

- **Kind**: internal
- **Source**: 11462:126:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_decodeBool(bytes,uint256)`

```solidity
/// @notice Decodes a boolean value from a byte array at the specified offset
///  @dev Helper function for extracting boolean values from packed data
///       Used when parsing hook-specific data parameters
///  @param data The byte array containing the encoded data
///  @param offset The position in the array to read from
///  @return The decoded boolean value (true if byte is non-zero)
function _decodeBool(bytes memory data, uint256 offset) internal pure returns (bool) {
    return data[offset] != 0;
}
```

### toUint256(bytes,uint256)

- **Kind**: internal
- **Source**: 14359:311:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint256(bytes,uint256)`

```solidity
function toUint256(bytes memory _bytes, uint256 _start) internal pure returns (uint256) {
    require(_bytes.length >= (_start + 32), "toUint256_outOfBounds");
    uint256 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x20), _start))
    }
    return tempUint;
}
```

### _getOutputToken(bytes)

- **Kind**: internal
- **Source**: 29198:419:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_getOutputToken(bytes)`

```solidity
/// @notice Gets the output token from hook data
///  @param data The hook data
///  @return outputToken The output token address
function _getOutputToken(bytes calldata data) internal pure returns (address outputToken) {
    address currency0 = data.toAddress(0);
    address currency1 = data.toAddress(20);
    bool zeroForOne = _decodeBool(data, 216);
    outputToken = zeroForOne ? currency1 : currency0;
}
```

### _prepareUnlockData(address,address,bytes)

- **Kind**: internal
- **Source**: 25053:1349:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_prepareUnlockData(address,address,bytes)`

```solidity
/// @notice Prepare unlock data for the pool manager
///  @param prevHook The previous hook in the chain
///  @param account The account executing the hook
///  @param data The encoded hook data
///  @return unlockData The encoded data for the unlock callback
function _prepareUnlockData(address prevHook, address account, bytes calldata data) internal view returns (bytes memory unlockData) {
    (PoolKey memory poolKey, address dstReceiver, uint160 sqrtPriceLimitX96, uint256 originalAmountIn, uint256 originalMinAmountOut, uint256 maxSlippageDeviationBps, bool zeroForOne, bool usePrevHookAmount, bytes memory additionalData) = _decodeHookData(data);
    uint256 actualAmountIn = usePrevHookAmount ? ISuperHookResult(prevHook).getOutAmount(account) : originalAmountIn;
    uint256 dynamicMinAmountOut = _calculateDynamicMinAmount(RecalculationParams({originalAmountIn: originalAmountIn, originalMinAmountOut: originalMinAmountOut, actualAmountIn: actualAmountIn, maxSlippageDeviationBps: maxSlippageDeviationBps}));
    unlockData = abi.encode(poolKey, actualAmountIn, dynamicMinAmountOut, dstReceiver, sqrtPriceLimitX96, zeroForOne, additionalData);
}
```

### _decodeHookData(bytes)

- **Kind**: internal
- **Source**: 27107:1945:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_decodeHookData(bytes)`

```solidity
/// @notice Decodes the enhanced hook data structure
///  @param data The encoded hook data
///  @return poolKey The Uniswap V4 pool key
///  @return dstReceiver The destination receiver address
///  @return sqrtPriceLimitX96 The price limit for the swap
///  @return originalAmountIn The original user-provided amount in
///  @return originalMinAmountOut The original user-provided minimum amount out
///  @return maxSlippageDeviationBps The maximum allowed slippage deviation
///  @return zeroForOne Whether swapping token0 for token1
///  @return usePrevHookAmount Whether to use previous hook amount
///  @return additionalData Any additional data for the swap
function _decodeHookData(bytes calldata data) internal pure returns (PoolKey memory poolKey, address dstReceiver, uint160 sqrtPriceLimitX96, uint256 originalAmountIn, uint256 originalMinAmountOut, uint256 maxSlippageDeviationBps, bool zeroForOne, bool usePrevHookAmount, bytes memory additionalData) {
    if (data.length < 218) {
        revert INVALID_HOOK_DATA();
    }
    poolKey = PoolKey({currency0: Currency.wrap(data.toAddress(0)), currency1: Currency.wrap(data.toAddress(20)), fee: uint24(data.toUint32(40)), tickSpacing: int24(int32(data.toUint32(44))), hooks: IHooks(data.toAddress(48))});
    if (Currency.unwrap(poolKey.currency0) == Currency.unwrap(poolKey.currency1)) revert INVALID_HOOK_DATA();
    if (poolKey.fee == 0) revert INVALID_HOOK_DATA();
    if (poolKey.tickSpacing == 0) revert INVALID_HOOK_DATA();
    dstReceiver = data.toAddress(68);
    sqrtPriceLimitX96 = uint160(data.toUint256(88));
    originalAmountIn = data.toUint256(120);
    originalMinAmountOut = data.toUint256(152);
    maxSlippageDeviationBps = data.toUint256(184);
    zeroForOne = _decodeBool(data, 216);
    usePrevHookAmount = _decodeBool(data, 217);
    uint256 dataLength = data.length;
    if (dataLength > 218) {
        if ((dataLength - 218) > MAX_ADDITIONAL_DATA_LEN) {
            revert EXCESSIVE_ADDITIONAL_DATA();
        }
        additionalData = data.slice(218, data.length - 218);
    }
}
```

### toUint32(bytes,uint256)

- **Kind**: internal
- **Source**: 13108:305:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint32(bytes,uint256)`

```solidity
function toUint32(bytes memory _bytes, uint256 _start) internal pure returns (uint32) {
    require(_bytes.length >= (_start + 4), "toUint32_outOfBounds");
    uint32 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x4), _start))
    }
    return tempUint;
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

### _calculateDynamicMinAmount(struct SwapUniswapV4Hook.RecalculationParams)

- **Kind**: internal
- **Source**: 21446:1437:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_calculateDynamicMinAmount(struct SwapUniswapV4Hook.RecalculationParams)`

```solidity
/// @notice Calculates new minAmountOut ensuring ratio protection
///  @dev Formula: newMinAmount = originalMinAmount * (actualAmountIn / originalAmountIn)
///       Validates that ratio change doesn't exceed maxSlippageDeviationBps
///  @param params The recalculation parameters
///  @return newMinAmountOut The calculated minAmountOut with ratio protection
function _calculateDynamicMinAmount(RecalculationParams memory params) internal pure returns (uint256 newMinAmountOut) {
    if ((params.originalAmountIn == 0) || (params.originalMinAmountOut == 0)) {
        revert INVALID_ORIGINAL_AMOUNTS();
    }
    if (params.actualAmountIn == 0) {
        revert INVALID_ACTUAL_AMOUNT();
    }
    newMinAmountOut = Math.mulDiv(params.originalMinAmountOut, params.actualAmountIn, params.originalAmountIn);
    if (newMinAmountOut == 0) revert INVALID_OUTPUT_DELTA();
    uint256 amountRatio = (params.actualAmountIn * 1e18) / params.originalAmountIn;
    uint256 ratioDeviationBps = _calculateRatioDeviationBps(amountRatio);
    if (ratioDeviationBps > params.maxSlippageDeviationBps) {
        revert EXCESSIVE_SLIPPAGE_DEVIATION(ratioDeviationBps, params.maxSlippageDeviationBps);
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

### _calculateRatioDeviationBps(uint256)

- **Kind**: internal
- **Source**: 23156:439:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_calculateRatioDeviationBps(uint256)`

```solidity
/// @notice Internal function to calculate ratio deviation in basis points
///  @dev Handles both increases and decreases from the 1:1 ratio
///  @param amountRatio The ratio in 1e18 precision
///  @return ratioDeviationBps The deviation in basis points
function _calculateRatioDeviationBps(uint256 amountRatio) private pure returns (uint256 ratioDeviationBps) {
    if (amountRatio > 1e18) {
        ratioDeviationBps = ((amountRatio - 1e18) * MAX_BPS) / 1e18;
    } else {
        ratioDeviationBps = ((1e18 - amountRatio) * MAX_BPS) / 1e18;
    }
}
```

### _storeUnlockData(bytes)

- **Kind**: internal
- **Source**: 30037:530:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_storeUnlockData(bytes)`

```solidity
/// @notice Stores unlock data in transient storage using the correct pattern
///  @dev Follows SignatureTransientStorage pattern: stores length first, then data chunks
///  @param data The unlock data to store
function _storeUnlockData(bytes memory data) private {
    bytes32 storageKey = PENDING_UNLOCK_DATA_SLOT;
    uint256 len = data.length;
    assembly {
        tstore(storageKey, len)
    }
    for (uint256 i; i < len; i += 32) {
        bytes32 word;
        assembly {
            word := mload(add(add(data, 0x20), i))
            tstore(add(storageKey, div(add(i, 32), 32)), word)
        }
    }
}
```

## State Variable Reads

- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)
- **PRE_EXECUTE_MUTEX_OFFSET** (`uint256`)
- **HOOK_EXECUTION_STORAGE** (`bytes32`)
- **MAX_ADDITIONAL_DATA_LEN** (`uint256`)
- **MAX_BPS** (`uint256`)
- **PENDING_UNLOCK_DATA_SLOT** (`bytes32`)

## State Variable Writes

- **initialBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.preExecute(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 1)
  │   💬 Args: [account]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 2)
  │     💬 Args: [caller]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: BaseHook._getPreExecuteMutex(uint256) (NodeID: 3)
  │   💬 Args: [context]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 4)
  │     💬 Args: [context, PRE_EXECUTE_MUTEX_OFFSET]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: BaseHook._setPreExecuteMutex(uint256,bool) (NodeID: 5)
  │   💬 Args: [context, true]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 6)
  │     💬 Args: [context, PRE_EXECUTE_MUTEX_OFFSET]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: SwapUniswapV4Hook._preExecute(address,address,bytes) (NodeID: 7)
      💬 Args: [prevHook, account, data]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SwapUniswapV4Hook._getTransferParams(address,address,bytes) (NodeID: 8)
    │   💬 Args: [prevHook, account, data]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 9)
    │ │   💬 Args: [data, 0]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 10)
    │ │   💬 Args: [data, 20]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 11)
    │ │   💬 Args: [data, 216]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 12)
    │ │   💬 Args: [data, 217]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 13)
    │     💬 Args: [data, 120]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SwapUniswapV4Hook._getOutputToken(bytes) (NodeID: 14)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 15)
    │ │   💬 Args: [data, 0]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 16)
    │ │   💬 Args: [data, 20]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 17)
    │     💬 Args: [data, 216]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 18)
    │   💬 Args: [data, 68]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SwapUniswapV4Hook._prepareUnlockData(address,address,bytes) (NodeID: 19)
    │   💬 Args: [prevHook, account, data]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SwapUniswapV4Hook._decodeHookData(bytes) (NodeID: 20)
    │ │   💬 Args: [data]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 21)
    │ │ │   💬 Args: [data, 0]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 22)
    │ │ │   💬 Args: [data, 20]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toUint32(bytes,uint256) (NodeID: 23)
    │ │ │   💬 Args: [data, 40]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toUint32(bytes,uint256) (NodeID: 24)
    │ │ │   💬 Args: [data, 44]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 25)
    │ │ │   💬 Args: [data, 48]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 26)
    │ │ │   💬 Args: [data, 68]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 27)
    │ │ │   💬 Args: [data, 88]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 28)
    │ │ │   💬 Args: [data, 120]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 29)
    │ │ │   💬 Args: [data, 152]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 30)
    │ │ │   💬 Args: [data, 184]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 31)
    │ │ │   💬 Args: [data, 216]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 32)
    │ │ │   💬 Args: [data, 217]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 33)
    │ │     💬 Args: [data, 218, data.length - 218]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SwapUniswapV4Hook._calculateDynamicMinAmount(struct SwapUniswapV4Hook.RecalculationParams) (NodeID: 34)
    │     💬 Args: [RecalculationParams({originalAmountIn: originalAmountIn, originalMinAmountOut: originalMinAmountOut, actualAmountIn: actualAmountIn, maxSlippageDeviationBps: maxSlippageDeviationBps})]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 35)
    │   │   💬 Args: [params.originalMinAmountOut, params.actualAmountIn, params.originalAmountIn]
    │   │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 36)
    │   │ │   💬 Args: [x, y]
    │   │ │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 37)
    │   │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
    │   │     👁️  Def: internal
    │   │   └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 38)
    │   │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
    │   │       👁️  Def: internal
    │   │     └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 39)
    │   │         💬 Args: [condition]
    │   │         👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SwapUniswapV4Hook._calculateRatioDeviationBps(uint256) (NodeID: 40)
    │       💬 Args: [amountRatio]
    │       👁️  Def: private
    └─ [2] ⚙️ FUNCTION: SwapUniswapV4Hook._storeUnlockData(bytes) (NodeID: 41)
        💬 Args: [unlockData]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperHook

### Interface Documentation

@notice Prepares the hook for execution
 @dev Called before the main execution, used to validate inputs and set execution context
      This method may perform state changes to set up the hook's execution state
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account to perform operations for
 @param data The hook-specific parameters and configuration data
