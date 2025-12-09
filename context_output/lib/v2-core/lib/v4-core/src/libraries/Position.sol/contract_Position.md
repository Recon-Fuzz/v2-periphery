# Contract: Position

## Metadata

- **Name**: Position
- **Type**: Contract
- **Path**: lib/v2-core/lib/v4-core/src/libraries/Position.sol
- **Documentation**: @title Position
   @notice Positions represent an owner address' liquidity between a lower and upper tick boundary
   @dev Positions store additional state for tracking fees owed to the position

## Structs

### State

```solidity
struct State {
    uint128 liquidity;
    uint256 feeGrowthInside0LastX128;
    uint256 feeGrowthInside1LastX128;
}
```

## Errors

### CannotUpdateEmptyPosition

```solidity
/// @notice Cannot update a position with no liquidity
error CannotUpdateEmptyPosition();
```
