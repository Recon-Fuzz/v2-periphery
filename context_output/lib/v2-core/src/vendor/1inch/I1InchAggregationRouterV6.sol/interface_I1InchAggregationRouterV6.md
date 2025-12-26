# Interface: I1InchAggregationRouterV6

## Metadata

- **Name**: I1InchAggregationRouterV6
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol

## Structs

### SwapDescription

```solidity
struct SwapDescription {
    IERC20 srcToken;
    IERC20 dstToken;
    address payable srcReceiver;
    address payable dstReceiver;
    uint256 amount;
    uint256 minReturnAmount;
    uint256 flags;
}
```

## Public/External Functions

### unoswapTo(Address,Address,uint256,uint256,Address)

- **Signature**: `unoswapTo(Address,Address,uint256,uint256,Address)`
- **Visibility**: external
- **Source Range**: 10363:196:440

**Signature:**
```solidity
///  @notice Swaps `amount` of the specified `token` for another token using an Unoswap-compatible exchange's pool,
///          sending the resulting tokens to the `to` address, with a minimum return specified by `minReturn`.
///  @param to The address to receive the swapped tokens.
///  @param token The address of the token to be swapped.
///  @param amount The amount of tokens to be swapped.
///  @param minReturn The minimum amount of tokens to be received after the swap.
///  @param dex The address of the Unoswap-compatible exchange's pool.
///  @return returnAmount The actual amount of tokens received after the swap.
function unoswapTo(Address to, Address token, uint256 amount, uint256 minReturn, Address dex) external returns (uint256 returnAmount);;
```

### clipperSwapTo(contract IClipperExchange,address payable,Address,contract IERC20,uint256,uint256,uint256,bytes32,bytes32)

- **Signature**: `clipperSwapTo(contract IClipperExchange,address payable,Address,contract IERC20,uint256,uint256,uint256,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 10565:360:440

**Signature:**
```solidity
function clipperSwapTo(IClipperExchange clipperExchange, address payable recipient, Address srcToken, IERC20 dstToken, uint256 inputAmount, uint256 outputAmount, uint256 expiryWithFlags, bytes32 r, bytes32 vs) external payable returns (uint256 returnAmount);;
```

### swap(contract IAggregationExecutor,struct I1InchAggregationRouterV6.SwapDescription,bytes)

- **Signature**: `swap(contract IAggregationExecutor,struct I1InchAggregationRouterV6.SwapDescription,bytes)`
- **Visibility**: external
- **Source Range**: 11171:114:440

**Signature:**
```solidity
function swap(IAggregationExecutor executor, SwapDescription calldata desc, bytes calldata data) external payable;;
```
