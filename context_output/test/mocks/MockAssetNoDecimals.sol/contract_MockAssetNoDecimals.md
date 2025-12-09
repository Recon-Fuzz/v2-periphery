# Contract: MockAssetNoDecimals

## Metadata

- **Name**: MockAssetNoDecimals
- **Type**: Contract
- **Path**: test/mocks/MockAssetNoDecimals.sol

## State Variables

### name

```solidity
string public name
```

### symbol

```solidity
string public symbol
```

## Public/External Functions

### constructor(string,string)

- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 150:111:587
- **Details**: [function_constructor_string_string.md](./function_constructor_string_string.md)

**Signature:**
```solidity
constructor(string memory name_, string memory symbol_);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 267:90:587
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() public pure returns (uint8);
```
