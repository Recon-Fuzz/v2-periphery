# Contract: Strings

## Metadata

- **Name**: Strings
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol
- **Documentation**:  @dev String operations.

## State Variables

### HEX_DIGITS

```solidity
bytes16 private constant HEX_DIGITS = "0123456789abcdef"
```

### ADDRESS_LENGTH

```solidity
uint8 private constant ADDRESS_LENGTH = 20
```

### SPECIAL_CHARS_LOOKUP

```solidity
uint256 private constant SPECIAL_CHARS_LOOKUP = ((((((1 << 0x08) | (1 << 0x09)) | (1 << 0x0a)) | (1 << 0x0c)) | (1 << 0x0d)) | (1 << 0x22)) | (1 << 0x5c)
```

### ABS_MIN_INT256

```solidity
uint256 private constant ABS_MIN_INT256 = 2 ** 255
```

## Errors

### StringsInsufficientHexLength

```solidity
///  @dev The `value` string doesn't fit in the specified `length`.
error StringsInsufficientHexLength(uint256 value, uint256 length);
```

### StringsInvalidChar

```solidity
///  @dev The string being parsed contains characters that are not in scope of the given base.
error StringsInvalidChar();
```

### StringsInvalidAddressFormat

```solidity
///  @dev The string being parsed is not a properly formatted address.
error StringsInvalidAddressFormat();
```
