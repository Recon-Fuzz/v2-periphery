# Interface: IPendleRouterV4

## Metadata

- **Name**: IPendleRouterV4
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/pendle/IPendleRouterV4.sol

## Public/External Functions

### swapExactTokenForPt(address,address,uint256,struct ApproxParams,struct TokenInput,struct LimitOrderData)

- **Signature**: `swapExactTokenForPt(address,address,uint256,struct ApproxParams,struct TokenInput,struct LimitOrderData)`
- **Visibility**: external
- **Source Range**: 1451:334:465

**Signature:**
```solidity
function swapExactTokenForPt(address receiver, address market, uint256 minPtOut, ApproxParams calldata guessPtOut, TokenInput calldata input, LimitOrderData calldata limit) external payable returns (uint256 netPtOut, uint256 netSyFee, uint256 netSyInterm);;
```

### swapExactPtForToken(address,address,uint256,struct TokenOutput,struct LimitOrderData)

- **Signature**: `swapExactPtForToken(address,address,uint256,struct TokenOutput,struct LimitOrderData)`
- **Visibility**: external
- **Source Range**: 1791:282:465

**Signature:**
```solidity
function swapExactPtForToken(address receiver, address market, uint256 exactPtIn, TokenOutput calldata output, LimitOrderData calldata limit) external returns (uint256 netTokenOut, uint256 netSyFee, uint256 netSyInterm);;
```

### redeemPyToToken(address,address,uint256,struct TokenOutput)

- **Signature**: `redeemPyToToken(address,address,uint256,struct TokenOutput)`
- **Visibility**: external
- **Source Range**: 2079:215:465

**Signature:**
```solidity
function redeemPyToToken(address receiver, address YT, uint256 netPyIn, TokenOutput calldata output) external returns (uint256 netTokenOut, uint256 netSyInterm);;
```

### mintPyFromToken(address,address,uint256,struct TokenInput)

- **Signature**: `mintPyFromToken(address,address,uint256,struct TokenInput)`
- **Visibility**: external
- **Source Range**: 2300:227:465

**Signature:**
```solidity
function mintPyFromToken(address receiver, address YT, uint256 minPyOut, TokenInput calldata input) external payable returns (uint256 netPtOut, uint256 netSyInterm);;
```

### createTokenOutputSimple(address,uint256)

- **Signature**: `createTokenOutputSimple(address,uint256)`
- **Visibility**: external
- **Source Range**: 2770:161:465

**Signature:**
```solidity
/// @dev Creates a TokenOutput struct without using any swap aggregator
///  @param tokenOut must be one of the SY's tokens out (obtain via `IStandardizedYield#getTokensOut`)
///  @param minTokenOut minimum amount of token out
function createTokenOutputSimple(address tokenOut, uint256 minTokenOut) external pure returns (TokenOutput memory);;
```
