# Contract: UniswapV4Parser

## Metadata

- **Name**: UniswapV4Parser
- **Type**: Contract
- **Path**: lib/v2-core/test/utils/parsers/UniswapV4Parser.sol
- **Documentation**: @title UniswapV4Parser
   @author Superform Labs
   @notice Parser for generating Uniswap V4 hook calldata without external API dependencies
   @dev Provides on-chain calldata generation for V4 swaps following Superform patterns

## Structs

### SingleHopParams

```solidity
/// @notice Parameters for single-hop V4 swap
///  @param poolKey Pool key for the V4 pool
///  @param dstReceiver Recipient of output tokens
///  @param sqrtPriceLimitX96 Price limit (0 for no limit)
///  @param originalAmountIn Input amount
///  @param originalMinAmountOut Minimum output amount
///  @param maxSlippageDeviationBps Maximum allowed ratio change in basis points
///  @param zeroForOne Whether swapping token0 for token1
///  @param additionalData Additional data for the swap
struct SingleHopParams {
    PoolKey poolKey;
    address dstReceiver;
    uint160 sqrtPriceLimitX96;
    uint256 originalAmountIn;
    uint256 originalMinAmountOut;
    uint256 maxSlippageDeviationBps;
    bool zeroForOne;
    bytes additionalData;
}
```

## Errors

### InvalidTokenPath

```solidity
/// @notice Thrown when token path is invalid for multi-hop
error InvalidTokenPath();
```

### InvalidFeesArray

```solidity
/// @notice Thrown when fees array doesn't match token path
error InvalidFeesArray();
```

### IdenticalTokens

```solidity
/// @notice Thrown when tokens are identical
error IdenticalTokens();
```

## Public/External Functions

### getTickSpacing(uint24)

- **Signature**: `getTickSpacing(uint24)`
- **Visibility**: public
- **Source Range**: 2373:341:506
- **Details**: [function_getTickSpacing_uint24.md](./function_getTickSpacing_uint24.md)

**Signature:**
```solidity
/// @notice Get tick spacing for a given fee tier
///  @param fee The fee tier
///  @return tickSpacing The tick spacing for the fee tier
function getTickSpacing(uint24 fee) public pure returns (int24 tickSpacing);
```

### generateSingleHopSwapCalldata(struct UniswapV4Parser.SingleHopParams,bool)

- **Signature**: `generateSingleHopSwapCalldata(struct UniswapV4Parser.SingleHopParams,bool)`
- **Visibility**: public
- **Source Range**: 3828:1408:506
- **Details**: [function_generateSingleHopSwapCalldata_struct_UniswapV4Parser.SingleHopParams_bool.md](./function_generateSingleHopSwapCalldata_struct_UniswapV4Parser.SingleHopParams_bool.md)

**Signature:**
```solidity
/// @notice Generate hook data for single-hop V4 swap
///  @dev Creates properly encoded data matching SwapUniswapV4Hook expectations
///  @param params The swap parameters
///  @param usePrevHookAmount Whether to use previous hook's output
///  @return hookData Encoded hook data ready for execution
function generateSingleHopSwapCalldata(SingleHopParams memory params, bool usePrevHookAmount) public pure returns (bytes memory hookData);
```

### fromHex(string) (inherited from BaseAPIParser)

- **Signature**: `fromHex(string)`
- **Visibility**: public
- **Source Range**: 373:517:504
- **Details**: [function_fromHex_string.md](./function_fromHex_string.md)

**Signature:**
```solidity
function fromHex(string memory s) public pure returns (bytes memory);
```
