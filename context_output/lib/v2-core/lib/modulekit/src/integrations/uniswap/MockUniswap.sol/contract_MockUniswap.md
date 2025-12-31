# Contract: MockUniswap

## Metadata

- **Name**: MockUniswap
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/integrations/uniswap/MockUniswap.sol

## Implements Interfaces

- **ISwapRouter** [lib/v2-core/lib/modulekit/src/integrations/interfaces/uniswap/v3/ISwapRouter.sol/interface_ISwapRouter.md]
- **IUniswapV3SwapCallback** [lib/v2-core/lib/modulekit/src/integrations/interfaces/uniswap/v3/IUniswapV3SwapCallback.sol/interface_IUniswapV3SwapCallback.md]

## Structs

### ExactInputSingleParams (inherited from ISwapRouter)

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

### ExactInputParams (inherited from ISwapRouter)

```solidity
struct ExactInputParams {
    bytes path;
    address recipient;
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMinimum;
}
```

### ExactOutputSingleParams (inherited from ISwapRouter)

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

### ExactOutputParams (inherited from ISwapRouter)

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

### uniswapV3SwapCallback(int256,int256,bytes)

- **Signature**: `uniswapV3SwapCallback(int256,int256,bytes)`
- **Visibility**: external
- **Source Range**: 195:165:194
- **Details**: [function_uniswapV3SwapCallback_int256_int256_bytes.md](./function_uniswapV3SwapCallback_int256_int256_bytes.md)

**Signature:**
```solidity
function uniswapV3SwapCallback(int256 amount0Delta, int256 amount1Delta, bytes calldata data) override external;
```

### exactInputSingle(struct ISwapRouter.ExactInputSingleParams)

- **Signature**: `exactInputSingle(struct ISwapRouter.ExactInputSingleParams)`
- **Visibility**: external
- **Source Range**: 366:195:194
- **Details**: [function_exactInputSingle_struct_ISwapRouter_ExactInputSingleParams.md](./function_exactInputSingle_struct_ISwapRouter_ExactInputSingleParams.md)

**Signature:**
```solidity
function exactInputSingle(ExactInputSingleParams calldata params) override external payable returns (uint256 amountOut);
```

### exactInput(struct ISwapRouter.ExactInputParams)

- **Signature**: `exactInput(struct ISwapRouter.ExactInputParams)`
- **Visibility**: external
- **Source Range**: 567:183:194
- **Details**: [function_exactInput_struct_ISwapRouter_ExactInputParams.md](./function_exactInput_struct_ISwapRouter_ExactInputParams.md)

**Signature:**
```solidity
function exactInput(ExactInputParams calldata params) override external payable returns (uint256 amountOut);
```

### exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams)

- **Signature**: `exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams)`
- **Visibility**: external
- **Source Range**: 756:197:194
- **Details**: [function_exactOutputSingle_struct_ISwapRouter_ExactOutputSingleParams.md](./function_exactOutputSingle_struct_ISwapRouter_ExactOutputSingleParams.md)

**Signature:**
```solidity
function exactOutputSingle(ExactOutputSingleParams calldata params) override external payable returns (uint256 amountIn);
```

### exactOutput(struct ISwapRouter.ExactOutputParams)

- **Signature**: `exactOutput(struct ISwapRouter.ExactOutputParams)`
- **Visibility**: external
- **Source Range**: 959:185:194
- **Details**: [function_exactOutput_struct_ISwapRouter_ExactOutputParams.md](./function_exactOutput_struct_ISwapRouter_ExactOutputParams.md)

**Signature:**
```solidity
function exactOutput(ExactOutputParams calldata params) override external payable returns (uint256 amountIn);
```
