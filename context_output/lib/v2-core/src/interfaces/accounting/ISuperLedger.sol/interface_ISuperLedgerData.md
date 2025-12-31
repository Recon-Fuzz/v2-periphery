# Interface: ISuperLedgerData

## Metadata

- **Name**: ISuperLedgerData
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/accounting/ISuperLedger.sol
- **Documentation**: @title ISuperLedgerData
   @author Superform Labs
   @notice Interface defining core data structures and events for ledger accounting
   @dev This interface is extended by ISuperLedger to provide a complete accounting system
        It separates data structures and events from functional methods

## Structs

### LedgerEntry

```solidity
/// @notice Represents a single accounting entry in a user's ledger
///  @dev Used to track shares and their acquisition price for accurate profit calculation
struct LedgerEntry {
    uint256 amountSharesAvailableToConsume;
    uint256 price;
}
```

### Ledger

```solidity
/// @notice Collection of ledger entries for a user's position
///  @dev Manages entries in a FIFO queue for accurate cost basis calculation
struct Ledger {
    LedgerEntry[] entries;
    uint256 unconsumedEntries;
}
```

## Errors

### HOOK_NOT_FOUND

```solidity
/// @notice Thrown when a referenced hook cannot be found
error HOOK_NOT_FOUND();
```

### INVALID_PRICE

```solidity
/// @notice Thrown when a price returned from an oracle is invalid (typically zero)
error INVALID_PRICE();
```

### FEE_NOT_SET

```solidity
/// @notice Thrown when attempting to charge a fee without a valid fee percentage
error FEE_NOT_SET();
```

### INVALID_FEE_PERCENT

```solidity
/// @notice Thrown when setting a fee percentage outside the allowed range
error INVALID_FEE_PERCENT();
```

### ZERO_ADDRESS_NOT_ALLOWED

```solidity
/// @notice Thrown when a critical address parameter is set to the zero address
error ZERO_ADDRESS_NOT_ALLOWED();
```

### NOT_AUTHORIZED

```solidity
/// @notice Thrown when an unauthorized address attempts a restricted operation
error NOT_AUTHORIZED();
```

### NOT_MANAGER

```solidity
/// @notice Thrown when a non-manager address attempts a manager-only operation
error NOT_MANAGER();
```

### MANAGER_NOT_SET

```solidity
/// @notice Thrown when a manager is required but not set
error MANAGER_NOT_SET();
```

### ZERO_LENGTH

```solidity
/// @notice Thrown when providing an empty array where at least one element is required
error ZERO_LENGTH();
```

### ZERO_ID_NOT_ALLOWED

```solidity
/// @notice Thrown when an ID parameter is set to zero
error ZERO_ID_NOT_ALLOWED();
```

### INVALID_LEDGER

```solidity
/// @notice Thrown when an operation references an invalid ledger
error INVALID_LEDGER();
```

## Events

### AccountingInflow

```solidity
/// @notice Emitted when shares are added to a user's ledger
///  @param user The user whose ledger is being updated
///  @param yieldSourceOracle The oracle providing price information
///  @param yieldSource The yield-bearing asset being accounted for
///  @param amount The amount of shares being added
///  @param pps The price per share at the time of inflow (in asset terms)
event AccountingInflow(address indexed user, address indexed yieldSourceOracle, address indexed yieldSource, uint256 amount, uint256 pps);
```

### AccountingOutflow

```solidity
/// @notice Emitted when shares are consumed from a user's ledger
///  @param user The user whose ledger is being updated
///  @param yieldSourceOracle The oracle providing price information
///  @param yieldSource The yield-bearing asset being accounted for
///  @param amount The amount of shares or assets being processed
///  @param feeAmount The performance fee charged on yield profit
event AccountingOutflow(address indexed user, address indexed yieldSourceOracle, address indexed yieldSource, uint256 amount, uint256 feeAmount);
```

### UsedSharesCapped

```solidity
/// @notice Emitted when the amount of shares used is capped due to insufficient shares
///  @param originalVal The original amount of shares used
///  @param cappedVal The capped amount of shares used
event UsedSharesCapped(uint256 originalVal, uint256 cappedVal);
```
