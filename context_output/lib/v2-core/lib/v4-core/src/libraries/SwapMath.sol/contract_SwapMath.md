# Contract: SwapMath

## Metadata

- **Name**: SwapMath
- **Type**: Contract
- **Path**: lib/v2-core/lib/v4-core/src/libraries/SwapMath.sol
- **Documentation**: @title Computes the result of a swap within ticks
   @notice Contains methods for computing the result of a swap within a single tick price range, i.e., a single tick.

## State Variables

### MAX_SWAP_FEE

```solidity
/// @notice the swap fee is represented in hundredths of a bip, so the max is 100%
///  @dev the swap fee is the total fee on a swap, including both LP and Protocol fee
uint256 internal constant MAX_SWAP_FEE = 1e6
```
