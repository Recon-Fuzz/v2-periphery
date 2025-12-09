# Interface: IClipperExchange

## Metadata

- **Name**: IClipperExchange
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol

## Structs

### Signature

```solidity
struct Signature {
    uint8 v;
    bytes32 r;
    bytes32 s;
}
```

## Public/External Functions

### sellEthForToken(address,uint256,uint256,uint256,address,struct IClipperExchange.Signature,bytes)

- **Signature**: `sellEthForToken(address,uint256,uint256,uint256,address,struct IClipperExchange.Signature,bytes)`
- **Visibility**: external
- **Source Range**: 8560:294:440

**Signature:**
```solidity
function sellEthForToken(address outputToken, uint256 inputAmount, uint256 outputAmount, uint256 goodUntil, address destinationAddress, Signature calldata theSignature, bytes calldata auxiliaryData) external payable;;
```

### sellTokenForEth(address,uint256,uint256,uint256,address,struct IClipperExchange.Signature,bytes)

- **Signature**: `sellTokenForEth(address,uint256,uint256,uint256,address,struct IClipperExchange.Signature,bytes)`
- **Visibility**: external
- **Source Range**: 8859:277:440

**Signature:**
```solidity
function sellTokenForEth(address inputToken, uint256 inputAmount, uint256 outputAmount, uint256 goodUntil, address destinationAddress, Signature calldata theSignature, bytes calldata auxiliaryData) external;;
```

### swap(address,address,uint256,uint256,uint256,address,struct IClipperExchange.Signature,bytes)

- **Signature**: `swap(address,address,uint256,uint256,uint256,address,struct IClipperExchange.Signature,bytes)`
- **Visibility**: external
- **Source Range**: 9141:295:440

**Signature:**
```solidity
function swap(address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint256 goodUntil, address destinationAddress, Signature calldata theSignature, bytes calldata auxiliaryData) external;;
```
