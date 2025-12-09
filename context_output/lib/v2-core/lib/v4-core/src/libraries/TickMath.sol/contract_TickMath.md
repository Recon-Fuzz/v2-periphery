# Contract: TickMath

## Metadata

- **Name**: TickMath
- **Type**: Contract
- **Path**: lib/v2-core/lib/v4-core/src/libraries/TickMath.sol
- **Documentation**: @title Math library for computing sqrt prices from ticks and vice versa
   @notice Computes sqrt price for ticks of size 1.0001, i.e. sqrt(1.0001^tick) as fixed point Q64.96 numbers. Supports
   prices between 2**-128 and 2**128

## State Variables

### MIN_TICK

```solidity
/// @dev The minimum tick that may be passed to #getSqrtPriceAtTick computed from log base 1.0001 of 2**-128
///  @dev If ever MIN_TICK and MAX_TICK are not centered around 0, the absTick logic in getSqrtPriceAtTick cannot be used
int24 internal constant MIN_TICK = -887272
```

### MAX_TICK

```solidity
/// @dev The maximum tick that may be passed to #getSqrtPriceAtTick computed from log base 1.0001 of 2**128
///  @dev If ever MIN_TICK and MAX_TICK are not centered around 0, the absTick logic in getSqrtPriceAtTick cannot be used
int24 internal constant MAX_TICK = 887272
```

### MIN_TICK_SPACING

```solidity
/// @dev The minimum tick spacing value drawn from the range of type int16 that is greater than 0, i.e. min from the range [1, 32767]
int24 internal constant MIN_TICK_SPACING = 1
```

### MAX_TICK_SPACING

```solidity
/// @dev The maximum tick spacing value drawn from the range of type int16, i.e. max from the range [1, 32767]
int24 internal constant MAX_TICK_SPACING = type(int16).max
```

### MIN_SQRT_PRICE

```solidity
/// @dev The minimum value that can be returned from #getSqrtPriceAtTick. Equivalent to getSqrtPriceAtTick(MIN_TICK)
uint160 internal constant MIN_SQRT_PRICE = 4295128739
```

### MAX_SQRT_PRICE

```solidity
/// @dev The maximum value that can be returned from #getSqrtPriceAtTick. Equivalent to getSqrtPriceAtTick(MAX_TICK)
uint160 internal constant MAX_SQRT_PRICE = 1461446703485210103287273052203988822378723970342
```

### MAX_SQRT_PRICE_MINUS_MIN_SQRT_PRICE_MINUS_ONE

```solidity
/// @dev A threshold used for optimized bounds check, equals `MAX_SQRT_PRICE - MIN_SQRT_PRICE - 1`
uint160 internal constant MAX_SQRT_PRICE_MINUS_MIN_SQRT_PRICE_MINUS_ONE = (1461446703485210103287273052203988822378723970342 - 4295128739) - 1
```

## Errors

### InvalidTick

```solidity
/// @notice Thrown when the tick passed to #getSqrtPriceAtTick is not between MIN_TICK and MAX_TICK
error InvalidTick(int24 tick);
```

### InvalidSqrtPrice

```solidity
/// @notice Thrown when the price passed to #getTickAtSqrtPrice does not correspond to a price between MIN_TICK and MAX_TICK
error InvalidSqrtPrice(uint160 sqrtPriceX96);
```
