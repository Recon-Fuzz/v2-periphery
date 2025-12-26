# Contract: ProtocolLib

## Metadata

- **Name**: ProtocolLib
- **Type**: Contract
- **Path**: lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol

## State Variables

### _PROTOCOL_OFFSET

```solidity
uint256 private constant _PROTOCOL_OFFSET = 253
```

### _WETH_UNWRAP_FLAG

```solidity
uint256 private constant _WETH_UNWRAP_FLAG = 1 << 252
```

### _WETH_NOT_WRAP_FLAG

```solidity
uint256 private constant _WETH_NOT_WRAP_FLAG = 1 << 251
```

### _USE_PERMIT2_FLAG

```solidity
uint256 private constant _USE_PERMIT2_FLAG = 1 << 250
```

## Enums

### Protocol

```solidity
enum Protocol {
    UniswapV2,
    UniswapV3,
    Curve
}
```
