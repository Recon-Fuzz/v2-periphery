# Interface: IHooks

## Metadata

- **Name**: IHooks
- **Type**: Interface
- **Path**: lib/v2-core/lib/v4-core/src/interfaces/IHooks.sol
- **Documentation**: @notice V4 decides whether to invoke specific hooks by inspecting the least significant bits
   of the address that the hooks contract is deployed to.
   For example, a hooks contract deployed to address: 0x0000000000000000000000000000000000002400
   has the lowest bits '10 0100 0000 0000' which would cause the 'before initialize' and 'after add liquidity' hooks to be used.
   See the Hooks library for the full spec.
   @dev Should only be callable by the v4 PoolManager.

## Public/External Functions

### beforeInitialize(address,struct PoolKey,uint160)

- **Signature**: `beforeInitialize(address,struct PoolKey,uint160)`
- **Visibility**: external
- **Source Range**: 1106:112:327

**Signature:**
```solidity
/// @notice The hook called before the state of a pool is initialized
///  @param sender The initial msg.sender for the initialize call
///  @param key The key for the pool being initialized
///  @param sqrtPriceX96 The sqrt(price) of the pool as a Q64.96
///  @return bytes4 The function selector for the hook
function beforeInitialize(address sender, PoolKey calldata key, uint160 sqrtPriceX96) external returns (bytes4);;
```

### afterInitialize(address,struct PoolKey,uint160,int24)

- **Signature**: `afterInitialize(address,struct PoolKey,uint160,int24)`
- **Visibility**: external
- **Source Range**: 1628:139:327

**Signature:**
```solidity
/// @notice The hook called after the state of a pool is initialized
///  @param sender The initial msg.sender for the initialize call
///  @param key The key for the pool being initialized
///  @param sqrtPriceX96 The sqrt(price) of the pool as a Q64.96
///  @param tick The current tick after the state of a pool is initialized
///  @return bytes4 The function selector for the hook
function afterInitialize(address sender, PoolKey calldata key, uint160 sqrtPriceX96, int24 tick) external returns (bytes4);;
```

### beforeAddLiquidity(address,struct PoolKey,struct IPoolManager.ModifyLiquidityParams,bytes)

- **Signature**: `beforeAddLiquidity(address,struct PoolKey,struct IPoolManager.ModifyLiquidityParams,bytes)`
- **Visibility**: external
- **Source Range**: 2180:207:327

**Signature:**
```solidity
/// @notice The hook called before liquidity is added
///  @param sender The initial msg.sender for the add liquidity call
///  @param key The key for the pool
///  @param params The parameters for adding liquidity
///  @param hookData Arbitrary data handed into the PoolManager by the liquidity provider to be passed on to the hook
///  @return bytes4 The function selector for the hook
function beforeAddLiquidity(address sender, PoolKey calldata key, IPoolManager.ModifyLiquidityParams calldata params, bytes calldata hookData) external returns (bytes4);;
```

### afterAddLiquidity(address,struct PoolKey,struct IPoolManager.ModifyLiquidityParams,BalanceDelta,BalanceDelta,bytes)

- **Signature**: `afterAddLiquidity(address,struct PoolKey,struct IPoolManager.ModifyLiquidityParams,BalanceDelta,BalanceDelta,bytes)`
- **Visibility**: external
- **Source Range**: 3179:282:327

**Signature:**
```solidity
/// @notice The hook called after liquidity is added
///  @param sender The initial msg.sender for the add liquidity call
///  @param key The key for the pool
///  @param params The parameters for adding liquidity
///  @param delta The caller's balance delta after adding liquidity; the sum of principal delta, fees accrued, and hook delta
///  @param feesAccrued The fees accrued since the last time fees were collected from this position
///  @param hookData Arbitrary data handed into the PoolManager by the liquidity provider to be passed on to the hook
///  @return bytes4 The function selector for the hook
///  @return BalanceDelta The hook's delta in token0 and token1. Positive: the hook is owed/took currency, negative: the hook owes/sent currency
function afterAddLiquidity(address sender, PoolKey calldata key, IPoolManager.ModifyLiquidityParams calldata params, BalanceDelta delta, BalanceDelta feesAccrued, bytes calldata hookData) external returns (bytes4, BalanceDelta);;
```

### beforeRemoveLiquidity(address,struct PoolKey,struct IPoolManager.ModifyLiquidityParams,bytes)

- **Signature**: `beforeRemoveLiquidity(address,struct PoolKey,struct IPoolManager.ModifyLiquidityParams,bytes)`
- **Visibility**: external
- **Source Range**: 3884:210:327

**Signature:**
```solidity
/// @notice The hook called before liquidity is removed
///  @param sender The initial msg.sender for the remove liquidity call
///  @param key The key for the pool
///  @param params The parameters for removing liquidity
///  @param hookData Arbitrary data handed into the PoolManager by the liquidity provider to be be passed on to the hook
///  @return bytes4 The function selector for the hook
function beforeRemoveLiquidity(address sender, PoolKey calldata key, IPoolManager.ModifyLiquidityParams calldata params, bytes calldata hookData) external returns (bytes4);;
```

### afterRemoveLiquidity(address,struct PoolKey,struct IPoolManager.ModifyLiquidityParams,BalanceDelta,BalanceDelta,bytes)

- **Signature**: `afterRemoveLiquidity(address,struct PoolKey,struct IPoolManager.ModifyLiquidityParams,BalanceDelta,BalanceDelta,bytes)`
- **Visibility**: external
- **Source Range**: 4898:285:327

**Signature:**
```solidity
/// @notice The hook called after liquidity is removed
///  @param sender The initial msg.sender for the remove liquidity call
///  @param key The key for the pool
///  @param params The parameters for removing liquidity
///  @param delta The caller's balance delta after removing liquidity; the sum of principal delta, fees accrued, and hook delta
///  @param feesAccrued The fees accrued since the last time fees were collected from this position
///  @param hookData Arbitrary data handed into the PoolManager by the liquidity provider to be be passed on to the hook
///  @return bytes4 The function selector for the hook
///  @return BalanceDelta The hook's delta in token0 and token1. Positive: the hook is owed/took currency, negative: the hook owes/sent currency
function afterRemoveLiquidity(address sender, PoolKey calldata key, IPoolManager.ModifyLiquidityParams calldata params, BalanceDelta delta, BalanceDelta feesAccrued, bytes calldata hookData) external returns (bytes4, BalanceDelta);;
```

### beforeSwap(address,struct PoolKey,struct IPoolManager.SwapParams,bytes)

- **Signature**: `beforeSwap(address,struct PoolKey,struct IPoolManager.SwapParams,bytes)`
- **Visibility**: external
- **Source Range**: 5984:213:327

**Signature:**
```solidity
/// @notice The hook called before a swap
///  @param sender The initial msg.sender for the swap call
///  @param key The key for the pool
///  @param params The parameters for the swap
///  @param hookData Arbitrary data handed into the PoolManager by the swapper to be be passed on to the hook
///  @return bytes4 The function selector for the hook
///  @return BeforeSwapDelta The hook's delta in specified and unspecified currencies. Positive: the hook is owed/took currency, negative: the hook owes/sent currency
///  @return uint24 Optionally override the lp fee, only used if three conditions are met: 1. the Pool has a dynamic fee, 2. the value's 2nd highest bit is set (23rd bit, 0x400000), and 3. the value is less than or equal to the maximum fee (1 million)
function beforeSwap(address sender, PoolKey calldata key, IPoolManager.SwapParams calldata params, bytes calldata hookData) external returns (bytes4, BeforeSwapDelta, uint24);;
```

### afterSwap(address,struct PoolKey,struct IPoolManager.SwapParams,BalanceDelta,bytes)

- **Signature**: `afterSwap(address,struct PoolKey,struct IPoolManager.SwapParams,BalanceDelta,bytes)`
- **Visibility**: external
- **Source Range**: 6810:223:327

**Signature:**
```solidity
/// @notice The hook called after a swap
///  @param sender The initial msg.sender for the swap call
///  @param key The key for the pool
///  @param params The parameters for the swap
///  @param delta The amount owed to the caller (positive) or owed to the pool (negative)
///  @param hookData Arbitrary data handed into the PoolManager by the swapper to be be passed on to the hook
///  @return bytes4 The function selector for the hook
///  @return int128 The hook's delta in unspecified currency. Positive: the hook is owed/took currency, negative: the hook owes/sent currency
function afterSwap(address sender, PoolKey calldata key, IPoolManager.SwapParams calldata params, BalanceDelta delta, bytes calldata hookData) external returns (bytes4, int128);;
```

### beforeDonate(address,struct PoolKey,uint256,uint256,bytes)

- **Signature**: `beforeDonate(address,struct PoolKey,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 7475:191:327

**Signature:**
```solidity
/// @notice The hook called before donate
///  @param sender The initial msg.sender for the donate call
///  @param key The key for the pool
///  @param amount0 The amount of token0 being donated
///  @param amount1 The amount of token1 being donated
///  @param hookData Arbitrary data handed into the PoolManager by the donor to be be passed on to the hook
///  @return bytes4 The function selector for the hook
function beforeDonate(address sender, PoolKey calldata key, uint256 amount0, uint256 amount1, bytes calldata hookData) external returns (bytes4);;
```

### afterDonate(address,struct PoolKey,uint256,uint256,bytes)

- **Signature**: `afterDonate(address,struct PoolKey,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 8107:190:327

**Signature:**
```solidity
/// @notice The hook called after donate
///  @param sender The initial msg.sender for the donate call
///  @param key The key for the pool
///  @param amount0 The amount of token0 being donated
///  @param amount1 The amount of token1 being donated
///  @param hookData Arbitrary data handed into the PoolManager by the donor to be be passed on to the hook
///  @return bytes4 The function selector for the hook
function afterDonate(address sender, PoolKey calldata key, uint256 amount0, uint256 amount1, bytes calldata hookData) external returns (bytes4);;
```
