# Interface: ISwapRouter

## Metadata

- **Name**: ISwapRouter
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/integrations/interfaces/uniswap/v3/ISwapRouter.sol
- **Documentation**: @title Router token swapping functionality
   @notice Functions for swapping tokens via Uniswap V3

## Implements Interfaces

- **IUniswapV3SwapCallback** [lib/v2-core/lib/modulekit/src/integrations/interfaces/uniswap/v3/IUniswapV3SwapCallback.sol/interface_IUniswapV3SwapCallback.md]

## Structs

### ExactInputSingleParams

```solidity
struct ExactInputSingleParams {
    address tokenIn;
    address tokenOut;
    uint24 fee;
    address recipient;
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMinimum;
    uint160 sqrtPriceLimitX96;
}
```

### ExactInputParams

```solidity
struct ExactInputParams {
    bytes path;
    address recipient;
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMinimum;
}
```

### ExactOutputSingleParams

```solidity
struct ExactOutputSingleParams {
    address tokenIn;
    address tokenOut;
    uint24 fee;
    address recipient;
    uint256 deadline;
    uint256 amountOut;
    uint256 amountInMaximum;
    uint160 sqrtPriceLimitX96;
}
```

### ExactOutputParams

```solidity
struct ExactOutputParams {
    bytes path;
    address recipient;
    uint256 deadline;
    uint256 amountOut;
    uint256 amountInMaximum;
}
```

## Public/External Functions

### exactInputSingle(struct ISwapRouter.ExactInputSingleParams)

- **Signature**: `exactInputSingle(struct ISwapRouter.ExactInputSingleParams)`
- **Visibility**: external
- **Source Range**: 846:135:192

**Signature:**
```solidity
/// @notice Swaps `amountIn` of one token for as much as possible of another token
///  @param params The parameters necessary for the swap, encoded as `ExactInputSingleParams` in
///  calldata
///  @return amountOut The amount of the received token
function exactInputSingle(ExactInputSingleParams calldata params) external payable returns (uint256 amountOut);;
```

### exactInput(struct ISwapRouter.ExactInputParams)

- **Signature**: `exactInput(struct ISwapRouter.ExactInputParams)`
- **Visibility**: external
- **Source Range**: 1451:123:192

**Signature:**
```solidity
/// @notice Swaps `amountIn` of one token for as much as possible of another along the specified
///  path
///  @param params The parameters necessary for the multi-hop swap, encoded as `ExactInputParams`
///  in calldata
///  @return amountOut The amount of the received token
function exactInput(ExactInputParams calldata params) external payable returns (uint256 amountOut);;
```

### exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams)

- **Signature**: `exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams)`
- **Visibility**: external
- **Source Range**: 2106:136:192

**Signature:**
```solidity
/// @notice Swaps as little as possible of one token for `amountOut` of another token
///  @param params The parameters necessary for the swap, encoded as `ExactOutputSingleParams` in
///  calldata
///  @return amountIn The amount of the input token
function exactOutputSingle(ExactOutputSingleParams calldata params) external payable returns (uint256 amountIn);;
```

### exactOutput(struct ISwapRouter.ExactOutputParams)

- **Signature**: `exactOutput(struct ISwapRouter.ExactOutputParams)`
- **Visibility**: external
- **Source Range**: 2724:124:192

**Signature:**
```solidity
/// @notice Swaps as little as possible of one token for `amountOut` of another along the
///  specified path (reversed)
///  @param params The parameters necessary for the multi-hop swap, encoded as
///  `ExactOutputParams` in calldata
///  @return amountIn The amount of the input token
function exactOutput(ExactOutputParams calldata params) external payable returns (uint256 amountIn);;
```

### uniswapV3SwapCallback(int256,int256,bytes) (inherited from IUniswapV3SwapCallback)

- **Signature**: `uniswapV3SwapCallback(int256,int256,bytes)`
- **Visibility**: external
- **Source Range**: 1181:141:193

**Signature:**
```solidity
/// @notice Called to `msg.sender` after executing a swap via IUniswapV3Pool#swap.
///  @dev In the implementation you must pay the pool tokens owed for the swap.
///  The caller of this method must be checked to be a UniswapV3Pool deployed by the canonical
///  UniswapV3Factory.
///  amount0Delta and amount1Delta can both be 0 if no tokens were swapped.
///  @param amount0Delta The amount of token0 that was sent (negative) or must be received
///  (positive) by the pool by
///  the end of the swap. If positive, the callback must send that amount of token0 to the pool.
///  @param amount1Delta The amount of token1 that was sent (negative) or must be received
///  (positive) by the pool by
///  the end of the swap. If positive, the callback must send that amount of token1 to the pool.
///  @param data Any data passed through by the caller via the IUniswapV3PoolActions#swap call
function uniswapV3SwapCallback(int256 amount0Delta, int256 amount1Delta, bytes calldata data) external;;
```
