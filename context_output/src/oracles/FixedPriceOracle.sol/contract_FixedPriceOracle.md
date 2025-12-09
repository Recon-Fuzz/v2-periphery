# Contract: FixedPriceOracle

## Metadata

- **Name**: FixedPriceOracle
- **Type**: Contract
- **Path**: src/oracles/FixedPriceOracle.sol
- **Documentation**: @title FixedPriceOracle
   @notice A Chainlink-compatible oracle that returns a fixed price set by the admin
   @dev Used as a temporary UP/USD oracle. Always returns block.timestamp for updatedAt
        to avoid staleness issues with oracle consumers.

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### _answer

```solidity
/// @notice The fixed price to return
int256 private _answer
```

### _decimals

```solidity
/// @notice The number of decimals for the price
uint8 private _decimals
```

### DESCRIPTION

```solidity
/// @notice Description of the oracle
string private constant DESCRIPTION = "Fixed Price Oracle"
```

### VERSION

```solidity
/// @notice Version of the oracle
uint256 private constant VERSION = 1
```

## Errors

### OwnableUnauthorizedAccount (inherited from Ownable)

```solidity
///  @dev The caller account is not authorized to perform an operation.
error OwnableUnauthorizedAccount(address account);
```

### OwnableInvalidOwner (inherited from Ownable)

```solidity
///  @dev The owner is not a valid owner account. (eg. `address(0)`)
error OwnableInvalidOwner(address owner);
```

### INVALID_PRICE

```solidity
/// @notice Thrown when trying to set a zero price
error INVALID_PRICE();
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### PriceUpdated

```solidity
/// @notice Emitted when the fixed price is updated
///  @param oldPrice The previous price
///  @param newPrice The new price
event PriceUpdated(int256 oldPrice, int256 newPrice);
```

### DecimalsUpdated

```solidity
/// @notice Emitted when decimals are updated
///  @param oldDecimals The previous decimals
///  @param newDecimals The new decimals
event DecimalsUpdated(uint8 oldDecimals, uint8 newDecimals);
```

## Public/External Functions

### constructor(int256,uint8,address)

- **Signature**: `constructor(int256,uint8,address)`
- **Visibility**: public
- **Source Range**: 2250:207:533
- **Details**: [function_constructor_int256_uint8_address.md](./function_constructor_int256_uint8_address.md)

**Signature:**
```solidity
/// @notice Initializes the oracle with a fixed price and decimals
///  @param initialPrice The initial fixed price (must be > 0)
///  @param decimals_ The number of decimals (typically 8 for USD pairs)
///  @param owner_ The owner who can update the price
constructor(int256 initialPrice, uint8 decimals_, address owner_) Ownable(owner_);
```

### setPrice(int256)

- **Signature**: `setPrice(int256)`
- **Visibility**: external
- **Source Range**: 2742:222:533
- **Details**: [function_setPrice_int256.md](./function_setPrice_int256.md)

**Signature:**
```solidity
/// @notice Sets the fixed price
///  @param newPrice The new price to set (must be > 0)
function setPrice(int256 newPrice) external onlyOwner();
```

### setDecimals(uint8)

- **Signature**: `setDecimals(uint8)`
- **Visibility**: external
- **Source Range**: 3054:194:533
- **Details**: [function_setDecimals_uint8.md](./function_setDecimals_uint8.md)

**Signature:**
```solidity
/// @notice Sets the decimals
///  @param newDecimals The new decimals value
function setDecimals(uint8 newDecimals) external onlyOwner();
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 3519:83:533
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
/// @notice Returns the number of decimals
///  @return The decimals value
function decimals() external view returns (uint8);
```

### description()

- **Signature**: `description()`
- **Visibility**: external
- **Source Range**: 3702:96:533
- **Details**: [function_description.md](./function_description.md)

**Signature:**
```solidity
/// @notice Returns the description of this oracle
///  @return The description string
function description() external pure returns (string memory);
```

### version()

- **Signature**: `version()`
- **Visibility**: external
- **Source Range**: 3890:82:533
- **Details**: [function_version.md](./function_version.md)

**Signature:**
```solidity
/// @notice Returns the version of this oracle
///  @return The version number
function version() external pure returns (uint256);
```

### getRoundData(uint80)

- **Signature**: `getRoundData(uint80)`
- **Visibility**: external
- **Source Range**: 4458:270:533
- **Details**: [function_getRoundData_uint80.md](./function_getRoundData_uint80.md)

**Signature:**
```solidity
/// @notice Returns data for a specific round
///  @dev Always returns the current fixed price with current timestamp
///  @param _roundId The round ID (ignored, always returns current data)
///  @return roundId The round ID (always 1)
///  @return answer The fixed price
///  @return startedAt The current block timestamp
///  @return updatedAt The current block timestamp (prevents staleness issues)
///  @return answeredInRound The round ID (always 1)
function getRoundData(uint80 _roundId) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
```

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 5143:244:533
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
/// @notice Returns the latest round data
///  @dev Always returns block.timestamp for updatedAt to avoid staleness issues
///  @return roundId The round ID (always 1)
///  @return answer The fixed price
///  @return startedAt The current block timestamp
///  @return updatedAt The current block timestamp (prevents staleness issues)
///  @return answeredInRound The round ID (always 1)
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
```

### latestAnswer()

- **Signature**: `latestAnswer()`
- **Visibility**: external
- **Source Range**: 5478:237:533
- **Details**: [function_latestAnswer.md](./function_latestAnswer.md)

**Signature:**
```solidity
/// @notice Returns the latest answer
///  @return The fixed price as uint256
function latestAnswer() external view returns (uint256);
```

### getTimestamp(uint256)

- **Signature**: `getTimestamp(uint256)`
- **Visibility**: external
- **Source Range**: 5914:173:533
- **Details**: [function_getTimestamp_uint256.md](./function_getTimestamp_uint256.md)

**Signature:**
```solidity
/// @notice Returns the timestamp for a round
///  @dev Always returns current block timestamp
///  @param _roundId The round ID (ignored)
///  @return The current block timestamp
function getTimestamp(uint256 _roundId) external view returns (uint256);
```

### phaseId()

- **Signature**: `phaseId()`
- **Visibility**: external
- **Source Range**: 6171:75:533
- **Details**: [function_phaseId.md](./function_phaseId.md)

**Signature:**
```solidity
/// @notice Returns the current phase ID
///  @return Always returns 1
function phaseId() external pure returns (uint16);
```

### phaseAggregators(uint16)

- **Signature**: `phaseAggregators(uint16)`
- **Visibility**: external
- **Source Range**: 6452:158:533
- **Details**: [function_phaseAggregators_uint16.md](./function_phaseAggregators_uint16.md)

**Signature:**
```solidity
/// @notice Returns the aggregator for a phase
///  @dev Returns this contract's address for phase 1, zero otherwise
///  @param _phaseId The phase ID
///  @return The aggregator address
function phaseAggregators(uint16 _phaseId) external view returns (address);
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1638:85:251
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address);
```

### renounceOwnership() (inherited from Ownable)

- **Signature**: `renounceOwnership()`
- **Visibility**: public
- **Source Range**: 2293:101:251
- **Details**: [function_renounceOwnership.md](./function_renounceOwnership.md)

**Signature:**
```solidity
///  @dev Leaves the contract without owner. It will not be possible to call
///  `onlyOwner` functions. Can only be called by the current owner.
///  NOTE: Renouncing ownership will leave the contract without an owner,
///  thereby disabling any functionality that is only available to the owner.
function renounceOwnership() virtual public onlyOwner();
```

### transferOwnership(address) (inherited from Ownable)

- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 2543:215:251
- **Details**: [function_transferOwnership_address.md](./function_transferOwnership_address.md)

**Signature:**
```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Can only be called by the current owner.
function transferOwnership(address newOwner) virtual public onlyOwner();
```
