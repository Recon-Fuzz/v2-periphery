# Interface: IProtocolFees

## Metadata

- **Name**: IProtocolFees
- **Type**: Interface
- **Path**: lib/v2-core/lib/v4-core/src/interfaces/IProtocolFees.sol
- **Documentation**: @notice Interface for all protocol-fee related functions in the pool manager

## Errors

### ProtocolFeeTooLarge

```solidity
/// @notice Thrown when protocol fee is set too high
error ProtocolFeeTooLarge(uint24 fee);
```

### InvalidCaller

```solidity
/// @notice Thrown when collectProtocolFees or setProtocolFee is not called by the controller.
error InvalidCaller();
```

### ProtocolFeeCurrencySynced

```solidity
/// @notice Thrown when collectProtocolFees is attempted on a token that is synced.
error ProtocolFeeCurrencySynced();
```

## Events

### ProtocolFeeControllerUpdated

```solidity
/// @notice Emitted when the protocol fee controller address is updated in setProtocolFeeController.
event ProtocolFeeControllerUpdated(address indexed protocolFeeController);
```

### ProtocolFeeUpdated

```solidity
/// @notice Emitted when the protocol fee is updated for a pool.
event ProtocolFeeUpdated(PoolId indexed id, uint24 protocolFee);
```

## Public/External Functions

### protocolFeesAccrued(Currency)

- **Signature**: `protocolFeesAccrued(Currency)`
- **Visibility**: external
- **Source Range**: 1201:87:329

**Signature:**
```solidity
/// @notice Given a currency address, returns the protocol fees accrued in that currency
///  @param currency The currency to check
///  @return amount The amount of protocol fees accrued in the currency
function protocolFeesAccrued(Currency currency) external view returns (uint256 amount);;
```

### setProtocolFee(struct PoolKey,uint24)

- **Signature**: `setProtocolFee(struct PoolKey,uint24)`
- **Visibility**: external
- **Source Range**: 1461:76:329

**Signature:**
```solidity
/// @notice Sets the protocol fee for the given pool
///  @param key The key of the pool to set a protocol fee for
///  @param newProtocolFee The fee to set
function setProtocolFee(PoolKey memory key, uint24 newProtocolFee) external;;
```

### setProtocolFeeController(address)

- **Signature**: `setProtocolFeeController(address)`
- **Visibility**: external
- **Source Range**: 1650:63:329

**Signature:**
```solidity
/// @notice Sets the protocol fee controller
///  @param controller The new protocol fee controller
function setProtocolFeeController(address controller) external;;
```

### collectProtocolFees(address,Currency,uint256)

- **Signature**: `collectProtocolFees(address,Currency,uint256)`
- **Visibility**: external
- **Source Range**: 2137:142:329

**Signature:**
```solidity
/// @notice Collects the protocol fees for a given recipient and currency, returning the amount collected
///  @dev This will revert if the contract is unlocked
///  @param recipient The address to receive the protocol fees
///  @param currency The currency to withdraw
///  @param amount The amount of currency to withdraw
///  @return amountCollected The amount of currency successfully withdrawn
function collectProtocolFees(address recipient, Currency currency, uint256 amount) external returns (uint256 amountCollected);;
```

### protocolFeeController()

- **Signature**: `protocolFeeController()`
- **Visibility**: external
- **Source Range**: 2421:65:329

**Signature:**
```solidity
/// @notice Returns the current protocol fee controller address
///  @return address The current protocol fee controller address
function protocolFeeController() external view returns (address);;
```
