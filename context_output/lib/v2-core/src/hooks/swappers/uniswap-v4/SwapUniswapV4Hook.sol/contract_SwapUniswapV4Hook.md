# Contract: SwapUniswapV4Hook

## Metadata

- **Name**: SwapUniswapV4Hook
- **Type**: Contract
- **Path**: lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol
- **Documentation**: @title SwapUniswapV4Hook
   @author Superform Labs
   @notice Hook for executing swaps via Uniswap V4 with dynamic minAmountOut recalculation
   @dev Implements dynamic slippage protection and on-chain quote generation
   @dev data has the following structure
   @notice         address currency0 = BytesLib.toAddress(data, 0);
   @notice         address currency1 = BytesLib.toAddress(data, 20);
   @notice         uint24 fee = uint24(BytesLib.toUint32(data, 40));
   @notice         int24 tickSpacing = int24(BytesLib.toUint32(data, 44));
   @notice         address hooks = BytesLib.toAddress(data, 48);
   @notice         address dstReceiver = BytesLib.toAddress(data, 68);
   @notice         uint160 sqrtPriceLimitX96 = uint160(BytesLib.toUint256(data, 88));
   @notice         uint256 originalAmountIn = BytesLib.toUint256(data, 120);
   @notice         uint256 originalMinAmountOut = BytesLib.toUint256(data, 152);
   @notice         uint256 maxSlippageDeviationBps = BytesLib.toUint256(data, 184);
   @notice         bool zeroForOne = _decodeBool(data, 216);
   @notice         bool usePrevHookAmount = _decodeBool(data, 217);
   @notice         bytes additionalData = BytesLib.slice(data, 218, data.length - 218);

## Implements Interfaces

- **IUnlockCallback** [lib/v2-core/lib/v4-core/src/interfaces/callback/IUnlockCallback.sol/interface_IUnlockCallback.md]
- **ISuperHookInspector** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookInspector.md]
- **ISuperHookResult** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookResult.md]
- **ISuperHookSetter** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookSetter.md]
- **ISuperHook** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHook.md]

## State Variables

### usedShares (inherited from BaseHook)

```solidity
/// @notice The number of shares used by this hook's operation
///  @dev Used for accounting and tracking consumption of position shares
uint256 public transient usedShares
```

### spToken (inherited from BaseHook)

```solidity
/// @notice The special token address (if any) associated with this hook's operation
///  @dev May be used to track token addresses for various operations
address public transient spToken
```

### asset (inherited from BaseHook)

```solidity
/// @notice The primary asset address this hook operates on
///  @dev Typically the base token or asset being processed
address public transient asset
```

### executionNonce (inherited from BaseHook)

```solidity
/// @notice Execution nonce for creating unique contexts
uint256 public transient executionNonce
```

### lastCaller (inherited from BaseHook)

```solidity
/// @notice Last execution context caller
address public transient lastCaller
```

### OUT_AMOUNT_OFFSET (inherited from BaseHook)

```solidity
uint256 private constant OUT_AMOUNT_OFFSET = 1
```

### PRE_EXECUTE_MUTEX_OFFSET (inherited from BaseHook)

```solidity
uint256 private constant PRE_EXECUTE_MUTEX_OFFSET = 2
```

### POST_EXECUTE_MUTEX_OFFSET (inherited from BaseHook)

```solidity
uint256 private constant POST_EXECUTE_MUTEX_OFFSET = 3
```

### HOOK_EXECUTION_STORAGE (inherited from BaseHook)

```solidity
/// @notice Base storage key for hook execution state
bytes32 private constant HOOK_EXECUTION_STORAGE = keccak256("hook.execution.state")
```

### ACCOUNT_CONTEXT_STORAGE (inherited from BaseHook)

```solidity
/// @notice Storage key for account context mapping
bytes32 private constant ACCOUNT_CONTEXT_STORAGE = keccak256("hook.account.context")
```

### SUB_TYPE (inherited from BaseHook)

```solidity
/// @notice The specific subtype identifier for this hook
///  @dev Used to identify specialized hook types beyond the basic HookType enum
bytes32 public immutable SUB_TYPE
```

### hookType (inherited from BaseHook)

```solidity
/// @notice The type of hook (NONACCOUNTING, INFLOW, OUTFLOW)
///  @dev Determines how the hook impacts accounting in the system
ISuperHook.HookType public hookType
```

### POOL_MANAGER

```solidity
/// @notice The Uniswap V4 Pool Manager contract
IPoolManager public immutable POOL_MANAGER
```

**IPoolManager**: [lib/v2-core/lib/v4-core/src/interfaces/IPoolManager.sol/interface_IPoolManager.md]

### PENDING_UNLOCK_DATA_SLOT

```solidity
/// @notice Storage slot for transient unlock data
bytes32 private constant PENDING_UNLOCK_DATA_SLOT = keccak256("SwapUniswapV4Hook.pendingUnlockData")
```

### initialBalance

```solidity
uint256 private transient initialBalance
```

### MAX_BPS

```solidity
uint256 private constant MAX_BPS = 10_000
```

### MAX_ADDITIONAL_DATA_LEN

```solidity
uint256 private constant MAX_ADDITIONAL_DATA_LEN = 4096
```

## Structs

### RecalculationParams

```solidity
/// @notice Parameters for dynamic minAmount recalculation
///  @param originalAmountIn The original user-provided amountIn
///  @param originalMinAmountOut The original user-provided minAmountOut
///  @param actualAmountIn The actual amountIn (potentially changed by bridges/hooks)
///  @param maxSlippageDeviationBps Maximum allowed ratio change in basis points (e.g., 100 = 1%)
struct RecalculationParams {
    uint256 originalAmountIn;
    uint256 originalMinAmountOut;
    uint256 actualAmountIn;
    uint256 maxSlippageDeviationBps;
}
```

### SwapExecutionParams

```solidity
/// @notice Struct to hold swap execution parameters and results
///  @param inputCurrency The input currency for the swap
///  @param outputCurrency The output currency for the swap
///  @param inputToken The input token address
///  @param effectivePriceLimitX96 The effective price limit for the swap
///  @param swapDelta The delta returned from the swap
///  @param poolKey The pool key for the swap
///  @param amountIn The input amount for the swap
///  @param minAmountOut The minimum output amount required
///  @param dstReceiver The destination receiver address
///  @param zeroForOne Whether swapping token0 for token1
///  @param delta0 The delta for currency0
///  @param delta1 The delta for currency1
///  @param currency1Token The token address for currency1
///  @param outDelta The output delta (delta0 or delta1 depending on swap direction)
///  @param amountOut The final output amount
///  @param excess The excess amount to refund
///  @param balance The balance check for refunds
struct SwapExecutionParams {
    Currency inputCurrency;
    Currency outputCurrency;
    address inputToken;
    uint160 effectivePriceLimitX96;
    BalanceDelta swapDelta;
    PoolKey poolKey;
    uint256 amountIn;
    uint256 minAmountOut;
    address dstReceiver;
    bool zeroForOne;
    int128 delta0;
    int128 delta1;
    address currency1Token;
    int128 outDelta;
    uint256 amountOut;
    uint256 excess;
    uint256 balance;
}
```

## Errors

### NOT_AUTHORIZED (inherited from BaseHook)

```solidity
/// @notice Thrown when a caller attempts to execute hook methods without proper authorization
///  @dev Used by security validation to prevent unauthorized hook execution
error NOT_AUTHORIZED();
```

### AMOUNT_NOT_VALID (inherited from BaseHook)

```solidity
/// @notice Thrown when an amount parameter is invalid (e.g., zero or overflow)
///  @dev Used in validation checks for asset amounts and share values
error AMOUNT_NOT_VALID();
```

### ADDRESS_NOT_VALID (inherited from BaseHook)

```solidity
/// @notice Thrown when an address parameter is invalid (e.g., zero address)
///  @dev Used in validation checks for tokens, accounts, and other addresses
error ADDRESS_NOT_VALID();
```

### UNAUTHORIZED_CALLER (inherited from BaseHook)

```solidity
/// @notice Thrown when a caller is not authorized to execute hook methods
///  @dev Used by security validation to prevent unauthorized hook execution
error UNAUTHORIZED_CALLER();
```

### PRE_EXECUTE_ALREADY_CALLED (inherited from BaseHook)

```solidity
/// @notice Thrown when preExecute is called more than once
///  @dev Used to prevent reentrancy attacks and ensure proper execution flow
error PRE_EXECUTE_ALREADY_CALLED();
```

### POST_EXECUTE_ALREADY_CALLED (inherited from BaseHook)

```solidity
/// @notice Thrown when postExecute is called more than once
///  @dev Used to prevent reentrancy attacks and ensure proper execution flow
error POST_EXECUTE_ALREADY_CALLED();
```

### INCOMPLETE_HOOK_EXECUTION (inherited from BaseHook)

```solidity
/// @notice Thrown when a hook execution is incomplete
///  @dev Used to prevent incomplete hook execution
error INCOMPLETE_HOOK_EXECUTION();
```

### CANNOT_SET_OUT_AMOUNT (inherited from BaseHook)

```solidity
/// @notice Thrown when trying to set outAmount after preExecute or postExecute
///  @dev Used to prevent setting outAmount after preExecute or postExecute
error CANNOT_SET_OUT_AMOUNT();
```

### INSUFFICIENT_OUTPUT_AMOUNT

```solidity
/// @notice Thrown when the swap output is below the minimum required
error INSUFFICIENT_OUTPUT_AMOUNT(uint256 actual, uint256 minimum);
```

### UNAUTHORIZED_CALLBACK

```solidity
/// @notice Thrown when an unauthorized caller attempts to use the unlock callback
error UNAUTHORIZED_CALLBACK();
```

### INVALID_HOOK_DATA

```solidity
/// @notice Thrown when the hook data is malformed or insufficient
error INVALID_HOOK_DATA();
```

### EXCESSIVE_SLIPPAGE_DEVIATION

```solidity
/// @notice Thrown when the ratio deviation exceeds the maximum allowed
///  @param actualDeviation The actual ratio deviation in basis points
///  @param maxAllowed The maximum allowed deviation in basis points
error EXCESSIVE_SLIPPAGE_DEVIATION(uint256 actualDeviation, uint256 maxAllowed);
```

### INVALID_ORIGINAL_AMOUNTS

```solidity
/// @notice Thrown when original amounts are zero or invalid
error INVALID_ORIGINAL_AMOUNTS();
```

### INVALID_ACTUAL_AMOUNT

```solidity
/// @notice Thrown when actual amount is zero
error INVALID_ACTUAL_AMOUNT();
```

### ZERO_LIQUIDITY

```solidity
/// @notice Thrown when the pool has zero liquidity
error ZERO_LIQUIDITY();
```

### INVALID_PRICE_LIMIT

```solidity
/// @notice Thrown when an invalid price limit is provided (e.g., 0)
error INVALID_PRICE_LIMIT();
```

### INVALID_OUTPUT_DELTA

```solidity
error INVALID_OUTPUT_DELTA();
```

### HOOK_BALANCE_NOT_CLEARED

```solidity
/// @notice Thrown when hook retains token balance after execution
error HOOK_BALANCE_NOT_CLEARED(address token, uint256 remaining);
```

### OUTPUT_AMOUNT_DIFFERENT_THAN_TRUE

```solidity
error OUTPUT_AMOUNT_DIFFERENT_THAN_TRUE();
```

### INVALID_PREVIOUS_NATIVE_TRANSFER_HOOK_USAGE

```solidity
error INVALID_PREVIOUS_NATIVE_TRANSFER_HOOK_USAGE();
```

### INVALID_REMAINING_NATIVE_AMOUNT

```solidity
error INVALID_REMAINING_NATIVE_AMOUNT();
```

### EXCESSIVE_ADDITIONAL_DATA

```solidity
error EXCESSIVE_ADDITIONAL_DATA();
```

## Enums

### HookType (inherited from ISuperHook)

```solidity
/// @notice Defines the possible types of hooks in the system
///  @dev Used to determine how the hook affects accounting and what operations it performs
enum HookType {
    NONACCOUNTING,
    INFLOW,
    OUTFLOW
}
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 7686:155:394
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
/// @notice Initialize the Uniswap V4 swap hook
///  @param poolManager_ The address of the Uniswap V4 Pool Manager
constructor(address poolManager_) BaseHook(ISuperHook.HookType.NONACCOUNTING,HookSubTypes.SWAP);
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 7924:30:394
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
/// @notice Allows contract to receive native ETH for native token swaps
receive() external payable;
```

### unlockCallback(bytes)

- **Signature**: `unlockCallback(bytes)`
- **Visibility**: external
- **Source Range**: 11251:8734:394
- **Details**: [function_unlockCallback_bytes.md](./function_unlockCallback_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IUnlockCallback
function unlockCallback(bytes calldata data) override external returns (bytes memory);
```

### inspect(bytes)

- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 20020:421:394
- **Details**: [function_inspect_bytes.md](./function_inspect_bytes.md)

**Signature:**
```solidity
/// @inheritdoc BaseHook
function inspect(bytes calldata data) override external pure returns (bytes memory);
```

### decodeUsePrevHookAmount(bytes)

- **Signature**: `decodeUsePrevHookAmount(bytes)`
- **Visibility**: external
- **Source Range**: 20638:243:394
- **Details**: [function_decodeUsePrevHookAmount_bytes.md](./function_decodeUsePrevHookAmount_bytes.md)

**Signature:**
```solidity
/// @notice Decodes the usePrevHookAmount flag from hook data
///  @param data The encoded hook data
///  @return usePrevHookAmount Whether to use the previous hook's output amount
function decodeUsePrevHookAmount(bytes calldata data) external pure returns (bool usePrevHookAmount);
```

### setExecutionContext(address) (inherited from BaseHook)

- **Signature**: `setExecutionContext(address)`
- **Visibility**: external
- **Source Range**: 5193:135:364
- **Details**: [function_setExecutionContext_address.md](./function_setExecutionContext_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function setExecutionContext(address caller) external;
```

### build(address,address,bytes) (inherited from BaseHook)

- **Signature**: `build(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 5451:1084:364
- **Details**: [function_build_address_address_bytes.md](./function_build_address_address_bytes.md)

**Signature:**
```solidity
/// @dev Standard build pattern - MUST include preExecute first, postExecute last
///  @inheritdoc ISuperHook
function build(address prevHook, address account, bytes calldata hookData) virtual external view returns (Execution[] memory executions);
```

### preExecute(address,address,bytes) (inherited from BaseHook)

- **Signature**: `preExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 6572:390:364
- **Details**: [function_preExecute_address_address_bytes.md](./function_preExecute_address_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function preExecute(address prevHook, address account, bytes calldata data) external;
```

### postExecute(address,address,bytes) (inherited from BaseHook)

- **Signature**: `postExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 6999:395:364
- **Details**: [function_postExecute_address_address_bytes.md](./function_postExecute_address_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function postExecute(address prevHook, address account, bytes calldata data) external;
```

### setOutAmount(uint256,address) (inherited from BaseHook)

- **Signature**: `setOutAmount(uint256,address)`
- **Visibility**: external
- **Source Range**: 7437:394:364
- **Details**: [function_setOutAmount_uint256_address.md](./function_setOutAmount_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHookSetter
function setOutAmount(uint256 _outAmount, address caller) external;
```

### getOutAmount(address) (inherited from BaseHook)

- **Signature**: `getOutAmount(address)`
- **Visibility**: public
- **Source Range**: 7837:142:364
- **Details**: [function_getOutAmount_address.md](./function_getOutAmount_address.md)

**Signature:**
```solidity
function getOutAmount(address caller) public view returns (uint256);
```

### resetExecutionState(address) (inherited from BaseHook)

- **Signature**: `resetExecutionState(address)`
- **Visibility**: external
- **Source Range**: 8016:316:364
- **Details**: [function_resetExecutionState_address.md](./function_resetExecutionState_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function resetExecutionState(address caller) external onlyLastCaller();
```

### subtype() (inherited from BaseHook)

- **Signature**: `subtype()`
- **Visibility**: external
- **Source Range**: 8553:83:364
- **Details**: [function_subtype.md](./function_subtype.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function subtype() external view returns (bytes32);
```
