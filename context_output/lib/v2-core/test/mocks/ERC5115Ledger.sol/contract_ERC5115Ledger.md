# Contract: ERC5115Ledger

## Metadata

- **Name**: ERC5115Ledger
- **Type**: Contract
- **Path**: lib/v2-core/test/mocks/ERC5115Ledger.sol
- **Documentation**: @title ERC5115Ledger
   @author Superform Labs
   @notice Specialized ledger implementation for ERC-5115 vaults
   @dev Extends BaseLedger to properly handle accounting for ERC-5115 (Standardized Yield) tokens
        These tokens follow the Pendle StandardizedYield interface where the exchange rate
        is normalized to 18 decimals

## Implements Interfaces

- **ISuperLedger** [lib/v2-core/src/interfaces/accounting/ISuperLedger.sol/interface_ISuperLedger.md]
- **ISuperLedgerData** [lib/v2-core/src/interfaces/accounting/ISuperLedger.sol/interface_ISuperLedgerData.md]

## State Variables

### SUPER_LEDGER_CONFIGURATION (inherited from BaseLedger)

```solidity
/// @notice The configuration contract that stores yield source oracle settings
///  @dev Provides oracle addresses, fee percentages, and manager information
ISuperLedgerConfiguration public immutable SUPER_LEDGER_CONFIGURATION
```

**ISuperLedgerConfiguration**: [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]

### usersAccumulatorShares (inherited from BaseLedger)

```solidity
/// @notice Tracks the total shares each user has for each yield source
///  @dev Used for calculating proportional cost basis when consuming partial positions
mapping(address => mapping(address => uint256)) public usersAccumulatorShares
```

### usersAccumulatorCostBasis (inherited from BaseLedger)

```solidity
/// @notice Tracks the total cost basis (in asset terms) for each user's yield source position
///  @dev Cost basis represents the acquisition value used to determine yield for fee calculations
mapping(address => mapping(address => uint256)) public usersAccumulatorCostBasis
```

### allowedExecutors (inherited from BaseLedger)

```solidity
/// @notice Tracks which addresses are allowed to execute accounting operations
///  @dev Only allowed executors can update user accounting records
mapping(address => bool) public allowedExecutors
```

## Structs

### LedgerEntry (inherited from ISuperLedgerData)

```solidity
/// @notice Represents a single accounting entry in a user's ledger
///  @dev Used to track shares and their acquisition price for accurate profit calculation
struct LedgerEntry {
    uint256 amountSharesAvailableToConsume;
    uint256 price;
}
```

### Ledger (inherited from ISuperLedgerData)

```solidity
/// @notice Collection of ledger entries for a user's position
///  @dev Manages entries in a FIFO queue for accurate cost basis calculation
struct Ledger {
    LedgerEntry[] entries;
    uint256 unconsumedEntries;
}
```

## Errors

### HOOK_NOT_FOUND (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when a referenced hook cannot be found
error HOOK_NOT_FOUND();
```

### INVALID_PRICE (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when a price returned from an oracle is invalid (typically zero)
error INVALID_PRICE();
```

### FEE_NOT_SET (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when attempting to charge a fee without a valid fee percentage
error FEE_NOT_SET();
```

### INVALID_FEE_PERCENT (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when setting a fee percentage outside the allowed range
error INVALID_FEE_PERCENT();
```

### ZERO_ADDRESS_NOT_ALLOWED (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when a critical address parameter is set to the zero address
error ZERO_ADDRESS_NOT_ALLOWED();
```

### NOT_AUTHORIZED (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when an unauthorized address attempts a restricted operation
error NOT_AUTHORIZED();
```

### NOT_MANAGER (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when a non-manager address attempts a manager-only operation
error NOT_MANAGER();
```

### MANAGER_NOT_SET (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when a manager is required but not set
error MANAGER_NOT_SET();
```

### ZERO_LENGTH (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when providing an empty array where at least one element is required
error ZERO_LENGTH();
```

### ZERO_ID_NOT_ALLOWED (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when an ID parameter is set to zero
error ZERO_ID_NOT_ALLOWED();
```

### INVALID_LEDGER (inherited from ISuperLedgerData)

```solidity
/// @notice Thrown when an operation references an invalid ledger
error INVALID_LEDGER();
```

## Events

### AccountingInflow (inherited from ISuperLedgerData)

```solidity
/// @notice Emitted when shares are added to a user's ledger
///  @param user The user whose ledger is being updated
///  @param yieldSourceOracle The oracle providing price information
///  @param yieldSource The yield-bearing asset being accounted for
///  @param amount The amount of shares being added
///  @param pps The price per share at the time of inflow (in asset terms)
event AccountingInflow(address indexed user, address indexed yieldSourceOracle, address indexed yieldSource, uint256 amount, uint256 pps);
```

### AccountingOutflow (inherited from ISuperLedgerData)

```solidity
/// @notice Emitted when shares are consumed from a user's ledger
///  @param user The user whose ledger is being updated
///  @param yieldSourceOracle The oracle providing price information
///  @param yieldSource The yield-bearing asset being accounted for
///  @param amount The amount of shares or assets being processed
///  @param feeAmount The performance fee charged on yield profit
event AccountingOutflow(address indexed user, address indexed yieldSourceOracle, address indexed yieldSource, uint256 amount, uint256 feeAmount);
```

### UsedSharesCapped (inherited from ISuperLedgerData)

```solidity
/// @notice Emitted when the amount of shares used is capped due to insufficient shares
///  @param originalVal The original amount of shares used
///  @param cappedVal The capped amount of shares used
event UsedSharesCapped(uint256 originalVal, uint256 cappedVal);
```

## Public/External Functions

### constructor(address,address[])

- **Signature**: `constructor(address,address[])`
- **Visibility**: public
- **Source Range**: 885:167:481
- **Details**: [function_constructor_address_address[].md](./function_constructor_address_address[].md)

**Signature:**
```solidity
/// @notice Initializes the ERC5115Ledger with configuration and executor permissions
///  @param ledgerConfiguration_ Address of the SuperLedgerConfiguration contract
///  @param allowedExecutors_ Array of addresses authorized to execute accounting operations
constructor(address ledgerConfiguration_, address[] memory allowedExecutors_) BaseLedger(ledgerConfiguration_,allowedExecutors_);
```

### updateAccounting(address,address,bytes32,bool,uint256,uint256) (inherited from BaseLedger)

- **Signature**: `updateAccounting(address,address,bytes32,bool,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3198:391:351
- **Details**: [function_updateAccounting_address_address_bytes32_bool_uint256_uint256.md](./function_updateAccounting_address_address_bytes32_bool_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedger
function updateAccounting(address user, address yieldSource, bytes32 yieldSourceOracleId, bool isInflow, uint256 amountSharesOrAssets, uint256 usedShares) external returns (uint256 feeAmount);
```

### calculateCostBasisView(address,address,uint256) (inherited from BaseLedger)

- **Signature**: `calculateCostBasisView(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3628:656:351
- **Details**: [function_calculateCostBasisView_address_address_uint256.md](./function_calculateCostBasisView_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedger
function calculateCostBasisView(address user, address yieldSource, uint256 usedShares) public view returns (uint256 costBasis, uint256 shares);
```

### previewFees(address,address,uint256,uint256,uint256,uint256,uint256) (inherited from BaseLedger)

- **Signature**: `previewFees(address,address,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4323:882:351
- **Details**: [function_previewFees_address_address_uint256_uint256_uint256_uint256_uint256.md](./function_previewFees_address_address_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedger
function previewFees(address user, address yieldSourceAddress, uint256 amountAssets, uint256 usedShares, uint256 feePercent, uint256 pps, uint256 decimals) public view returns (uint256 feeAmount);
```
