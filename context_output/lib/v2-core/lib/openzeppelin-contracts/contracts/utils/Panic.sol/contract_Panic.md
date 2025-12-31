# Contract: Panic

## Metadata

- **Name**: Panic
- **Type**: Contract
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Panic.sol
- **Documentation**:  @dev Helper library for emitting standardized panic codes.
   ```solidity
   contract Example {
        using Panic for uint256;
        // Use any of the declared internal constants
        function foo() { Panic.GENERIC.panic(); }
        // Alternatively
        function foo() { Panic.panic(Panic.GENERIC); }
   }
   ```
   Follows the list from https://github.com/ethereum/solidity/blob/v0.8.24/libsolutil/ErrorCodes.h[libsolutil].
   _Available since v5.1._

## State Variables

### GENERIC

```solidity
/// @dev generic / unspecified error
uint256 internal constant GENERIC = 0x00
```

### ASSERT

```solidity
/// @dev used by the assert() builtin
uint256 internal constant ASSERT = 0x01
```

### UNDER_OVERFLOW

```solidity
/// @dev arithmetic underflow or overflow
uint256 internal constant UNDER_OVERFLOW = 0x11
```

### DIVISION_BY_ZERO

```solidity
/// @dev division or modulo by zero
uint256 internal constant DIVISION_BY_ZERO = 0x12
```

### ENUM_CONVERSION_ERROR

```solidity
/// @dev enum conversion error
uint256 internal constant ENUM_CONVERSION_ERROR = 0x21
```

### STORAGE_ENCODING_ERROR

```solidity
/// @dev invalid encoding in storage
uint256 internal constant STORAGE_ENCODING_ERROR = 0x22
```

### EMPTY_ARRAY_POP

```solidity
/// @dev empty array pop
uint256 internal constant EMPTY_ARRAY_POP = 0x31
```

### ARRAY_OUT_OF_BOUNDS

```solidity
/// @dev array out of bounds access
uint256 internal constant ARRAY_OUT_OF_BOUNDS = 0x32
```

### RESOURCE_ERROR

```solidity
/// @dev resource error (too large allocation or too large array)
uint256 internal constant RESOURCE_ERROR = 0x41
```

### INVALID_INTERNAL_FUNCTION

```solidity
/// @dev calling invalid internal function
uint256 internal constant INVALID_INTERNAL_FUNCTION = 0x51
```
