# Contract: MockSuperOracle

## Metadata

- **Name**: MockSuperOracle
- **Type**: Contract
- **Path**: test/mocks/MockSuperOracle.sol

## Implements Interfaces

- **IOracle** [src/vendor/awesome-oracles/IOracle.sol/interface_IOracle.md]

## State Variables

### quoteAmount

```solidity
uint256 public quoteAmount
```

### providerRemoved

```solidity
bool public providerRemoved
```

## Errors

### OracleUnsupportedPair (inherited from IOracle)

```solidity
/// @notice The oracle does not support the given base/quote pair.
///  @param base The asset that the user needs to know the value or price for.
///  @param quote The asset in which the user needs to value or price the base.
error OracleUnsupportedPair(address base, address quote);
```

### OracleUntrustedData (inherited from IOracle)

```solidity
/// @notice The oracle is not capable to provide data within a degree of confidence.
///  @param base The asset that the user needs to know the value or price for.
///  @param quote The asset in which the user needs to value or price the base.
error OracleUntrustedData(address base, address quote);
```

## Public/External Functions

### constructor(uint256)

- **Signature**: `constructor(uint256)`
- **Visibility**: public
- **Source Range**: 293:77:605
- **Details**: [function_constructor_uint256.md](./function_constructor_uint256.md)

**Signature:**
```solidity
constructor(uint256 _quoteAmount);
```

### setQuoteAmount(uint256)

- **Signature**: `setQuoteAmount(uint256)`
- **Visibility**: external
- **Source Range**: 376:98:605
- **Details**: [function_setQuoteAmount_uint256.md](./function_setQuoteAmount_uint256.md)

**Signature:**
```solidity
function setQuoteAmount(uint256 _quoteAmount) external;
```

### getQuote(uint256,address,address)

- **Signature**: `getQuote(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 480:112:605
- **Details**: [function_getQuote_uint256_address_address.md](./function_getQuote_uint256_address_address.md)

**Signature:**
```solidity
function getQuote(uint256, address, address) external view returns (uint256);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 598:75:605
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external pure returns (uint8);
```

### getQuoteFromProvider(uint256,address,address,bytes32)

- **Signature**: `getQuoteFromProvider(uint256,address,address,bytes32)`
- **Visibility**: external
- **Source Range**: 679:318:605
- **Details**: [function_getQuoteFromProvider_uint256_address_address_bytes32.md](./function_getQuoteFromProvider_uint256_address_address_bytes32.md)

**Signature:**
```solidity
function getQuoteFromProvider(uint256, address, address, bytes32) external view returns (uint256, uint256, uint256, uint256);
```

### queueProviderRemoval(bytes32[])

- **Signature**: `queueProviderRemoval(bytes32[])`
- **Visibility**: external
- **Source Range**: 1003:112:605
- **Details**: [function_queueProviderRemoval_bytes32[].md](./function_queueProviderRemoval_bytes32[].md)

**Signature:**
```solidity
function queueProviderRemoval(bytes32[] calldata) external;
```

### executeProviderRemoval()

- **Signature**: `executeProviderRemoval()`
- **Visibility**: external
- **Source Range**: 1121:169:605
- **Details**: [function_executeProviderRemoval.md](./function_executeProviderRemoval.md)

**Signature:**
```solidity
function executeProviderRemoval() external;
```
