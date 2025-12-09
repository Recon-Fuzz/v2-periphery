# Contract: TypedMemView

## Metadata

- **Name**: TypedMemView
- **Type**: Contract
- **Path**: lib/v2-core/lib/evm-gateway-contracts/lib/memview-sol/contracts/TypedMemView.sol

## State Variables

### NULL

```solidity
bytes29 public constant NULL = hex"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
```

### LOW_12_MASK

```solidity
uint256 internal constant LOW_12_MASK = 0xffffffffffffffffffffffff
```

### SHIFT_TO_LEN

```solidity
uint8 internal constant SHIFT_TO_LEN = 24
```

### SHIFT_TO_LOC

```solidity
uint8 internal constant SHIFT_TO_LOC = 96 + 24
```

### SHIFT_TO_TYPE

```solidity
uint8 internal constant SHIFT_TO_TYPE = (96 + 96) + 24
```

### NIBBLE_LOOKUP

```solidity
bytes private constant NIBBLE_LOOKUP = "0123456789abcdef"
```
