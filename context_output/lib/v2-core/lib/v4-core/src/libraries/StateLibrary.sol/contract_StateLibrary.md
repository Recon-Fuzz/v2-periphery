# Contract: StateLibrary

## Metadata

- **Name**: StateLibrary
- **Type**: Contract
- **Path**: lib/v2-core/lib/v4-core/src/libraries/StateLibrary.sol
- **Documentation**: @notice A helper library to provide state getters that use extsload

## State Variables

### POOLS_SLOT

```solidity
/// @notice index of pools mapping in the PoolManager
bytes32 public constant POOLS_SLOT = bytes32(uint256(6))
```

### FEE_GROWTH_GLOBAL0_OFFSET

```solidity
/// @notice index of feeGrowthGlobal0X128 in Pool.State
uint256 public constant FEE_GROWTH_GLOBAL0_OFFSET = 1
```

### LIQUIDITY_OFFSET

```solidity
/// @notice index of liquidity in Pool.State
uint256 public constant LIQUIDITY_OFFSET = 3
```

### TICKS_OFFSET

```solidity
/// @notice index of TicksInfo mapping in Pool.State: mapping(int24 => TickInfo) ticks;
uint256 public constant TICKS_OFFSET = 4
```

### TICK_BITMAP_OFFSET

```solidity
/// @notice index of tickBitmap mapping in Pool.State
uint256 public constant TICK_BITMAP_OFFSET = 5
```

### POSITIONS_OFFSET

```solidity
/// @notice index of Position.State mapping in Pool.State: mapping(bytes32 => Position.State) positions;
uint256 public constant POSITIONS_OFFSET = 6
```
