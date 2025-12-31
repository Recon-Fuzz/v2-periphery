# Function: unlockCallback(bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol/contract_SwapUniswapV4Hook.md]

## Metadata

- **Contract**: SwapUniswapV4Hook
- **Signature**: `unlockCallback(bytes)`
- **Visibility**: external
- **Source Range**: 11251:8734:394

## Implementation

```solidity
/// @inheritdoc IUnlockCallback
function unlockCallback(bytes calldata data) override external returns (bytes memory) {
    if (msg.sender != address(POOL_MANAGER)) {
        revert UNAUTHORIZED_CALLBACK();
    }
    (PoolKey memory poolKey, uint256 amountIn, uint256 minAmountOut, address dstReceiver, uint160 sqrtPriceLimitX96, bool zeroForOne, bytes memory additionalData) = abi.decode(data, (PoolKey, uint256, uint256, address, uint160, bool, bytes));
    uint160 effectivePriceLimitX96 = (sqrtPriceLimitX96 == 0) ? (zeroForOne ? (TickMath.MIN_SQRT_PRICE + 1) : (TickMath.MAX_SQRT_PRICE - 1)) : sqrtPriceLimitX96;
    SwapExecutionParams memory params;
    params.poolKey = poolKey;
    params.amountIn = amountIn;
    params.minAmountOut = minAmountOut;
    params.dstReceiver = dstReceiver;
    params.zeroForOne = zeroForOne;
    params.inputCurrency = zeroForOne ? poolKey.currency0 : poolKey.currency1;
    params.outputCurrency = zeroForOne ? poolKey.currency1 : poolKey.currency0;
    params.inputToken = Currency.unwrap(params.inputCurrency);
    params.effectivePriceLimitX96 = effectivePriceLimitX96;
    params.currency1Token = Currency.unwrap(poolKey.currency1);
    IPoolManager.SwapParams memory swapParams = IPoolManager.SwapParams({zeroForOne: params.zeroForOne, amountSpecified: -int256(params.amountIn), sqrtPriceLimitX96: params.effectivePriceLimitX96});
    params.swapDelta = POOL_MANAGER.swap(params.poolKey, swapParams, additionalData);
    params.delta0 = params.swapDelta.amount0();
    params.delta1 = params.swapDelta.amount1();
    if (params.delta0 < 0) {
        uint256 amountToSettle = uint256(uint128(-params.delta0));
        if (params.poolKey.currency0.isAddressZero()) {
            if (address(this).balance < amountToSettle) {
                revert INVALID_PREVIOUS_NATIVE_TRANSFER_HOOK_USAGE();
            }
            POOL_MANAGER.settle{value: amountToSettle}();
        } else {
            POOL_MANAGER.sync(params.poolKey.currency0);
            IERC20(params.inputToken).transfer(address(POOL_MANAGER), amountToSettle);
            POOL_MANAGER.settle();
        }
    } else if (params.delta0 > 0) {
        uint256 amountToTake = uint256(int256(params.delta0));
        if ((!params.zeroForOne) && (amountToTake < params.minAmountOut)) {
            revert INSUFFICIENT_OUTPUT_AMOUNT(amountToTake, params.minAmountOut);
        }
        POOL_MANAGER.take(params.poolKey.currency0, params.dstReceiver, amountToTake);
    }
    if (params.delta1 < 0) {
        uint256 amountToSettle = uint256(uint128(-params.delta1));
        if (params.poolKey.currency1.isAddressZero()) {
            POOL_MANAGER.settle{value: amountToSettle}();
        } else {
            POOL_MANAGER.sync(params.poolKey.currency1);
            IERC20(params.currency1Token).transfer(address(POOL_MANAGER), amountToSettle);
            POOL_MANAGER.settle();
        }
    } else if (params.delta1 > 0) {
        uint256 amountToTake = uint256(int256(params.delta1));
        if (amountToTake < params.minAmountOut) {
            revert INSUFFICIENT_OUTPUT_AMOUNT(amountToTake, params.minAmountOut);
        }
        POOL_MANAGER.take(params.poolKey.currency1, params.dstReceiver, amountToTake);
    }
    params.outDelta = params.zeroForOne ? params.delta1 : params.delta0;
    params.amountOut = (params.outDelta > 0) ? uint256(uint128(params.outDelta)) : 0;
    if (params.amountOut < params.minAmountOut) {
        revert INSUFFICIENT_OUTPUT_AMOUNT(params.amountOut, params.minAmountOut);
    }
    if (params.delta0 < 0) {
        if (params.poolKey.currency0.isAddressZero()) {
            params.balance = address(this).balance;
            if (params.balance > 0) {
                (bool success, ) = params.dstReceiver.call{value: params.balance}("");
                if (!success) revert INVALID_REMAINING_NATIVE_AMOUNT();
            }
        } else {
            params.balance = IERC20(params.inputToken).balanceOf(address(this));
            if (params.balance > 0) {
                IERC20(params.inputToken).transfer(params.dstReceiver, params.balance);
            }
        }
    } else if (params.delta1 < 0) {
        if (params.poolKey.currency1.isAddressZero()) {
            params.balance = address(this).balance;
            if (params.balance > 0) {
                (bool success, ) = params.dstReceiver.call{value: params.balance}("");
                if (!success) revert INVALID_REMAINING_NATIVE_AMOUNT();
            }
        } else {
            params.balance = IERC20(params.currency1Token).balanceOf(address(this));
            if (params.balance > 0) {
                IERC20(params.currency1Token).transfer(params.dstReceiver, params.balance);
            }
        }
    }
    return abi.encode(params.amountOut);
}
```

## Related Implementations

### amount0(BalanceDelta)

- **Kind**: internal
- **Source**: 1958:183:346
- **Link**: `lib/v2-core/lib/v4-core/src/types/BalanceDelta.sol:BalanceDeltaLibrary:amount0(BalanceDelta)`

```solidity
function amount0(BalanceDelta balanceDelta) internal pure returns (int128 _amount0) {
    assembly ("memory-safe") {
        _amount0 := sar(128, balanceDelta)
    }
}
```

### amount1(BalanceDelta)

- **Kind**: internal
- **Source**: 2147:189:346
- **Link**: `lib/v2-core/lib/v4-core/src/types/BalanceDelta.sol:BalanceDeltaLibrary:amount1(BalanceDelta)`

```solidity
function amount1(BalanceDelta balanceDelta) internal pure returns (int128 _amount1) {
    assembly ("memory-safe") {
        _amount1 := signextend(15, balanceDelta)
    }
}
```

### isAddressZero(Currency)

- **Kind**: internal
- **Source**: 4910:153:348
- **Link**: `lib/v2-core/lib/v4-core/src/types/Currency.sol:CurrencyLibrary:isAddressZero(Currency)`

```solidity
function isAddressZero(Currency currency) internal pure returns (bool) {
    return Currency.unwrap(currency) == Currency.unwrap(ADDRESS_ZERO);
}
```

## External Calls

- **IPoolManager::swap(struct PoolKey,struct IPoolManager.SwapParams,bytes)**
- **unknown::unknown**
- **IPoolManager::sync(Currency)**
- **IERC20::transfer(address,uint256)**
- **IPoolManager::settle()**
- **IPoolManager::take(Currency,address,uint256)**
- **IERC20::balanceOf(address)**

## Native Transfers

- **unknown** (computed)

## State Variable Reads

- **POOL_MANAGER** (`contract IPoolManager`) [lib/v2-core/lib/v4-core/src/interfaces/IPoolManager.sol/interface_IPoolManager.md]
- **ADDRESS_ZERO** (`Currency`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SwapUniswapV4Hook.unlockCallback(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BalanceDeltaLibrary.amount0(BalanceDelta) (NodeID: 1)
  │   💬 Args: [params.swapDelta]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BalanceDeltaLibrary.amount1(BalanceDelta) (NodeID: 2)
  │   💬 Args: [params.swapDelta]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CurrencyLibrary.isAddressZero(Currency) (NodeID: 3)
  │   💬 Args: [params.poolKey.currency0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CurrencyLibrary.isAddressZero(Currency) (NodeID: 4)
  │   💬 Args: [params.poolKey.currency1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CurrencyLibrary.isAddressZero(Currency) (NodeID: 5)
  │   💬 Args: [params.poolKey.currency0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CurrencyLibrary.isAddressZero(Currency) (NodeID: 6)
      💬 Args: [params.poolKey.currency1]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IUnlockCallback

### Interface Documentation

@notice Called by the pool manager on `msg.sender` when the manager is unlocked
 @param data The data that was passed to the call to unlock
 @return Any data that you want to be returned from the unlock call
