# Contract: MockEmergencyVault

## Metadata

- **Name**: MockEmergencyVault
- **Type**: Contract
- **Path**: test/mocks/MockEmergencyVault.sol
- **Documentation**: @title MockEmergencyVault
   @notice Emergency vault implementation for holding and managing tokens during emergency situations

## State Variables

### owner

```solidity
address public owner
```

### tokenBalances

```solidity
mapping(address => uint256) public tokenBalances
```

## Errors

### UNAUTHORIZED

```solidity
error UNAUTHORIZED();
```

### ZERO_ADDRESS

```solidity
error ZERO_ADDRESS();
```

### ZERO_AMOUNT

```solidity
error ZERO_AMOUNT();
```

### INSUFFICIENT_BALANCE

```solidity
error INSUFFICIENT_BALANCE();
```

### TRANSFER_FAILED

```solidity
error TRANSFER_FAILED();
```

## Events

### TokensReceived

```solidity
/// @notice Emitted when tokens are received by the emergency vault
event TokensReceived(address indexed token, address indexed from, uint256 amount);
```

### TokensWithdrawn

```solidity
/// @notice Emitted when tokens are withdrawn from the emergency vault
event TokensWithdrawn(address indexed token, address indexed to, uint256 amount);
```

### TokensReinvested

```solidity
/// @notice Emitted when tokens are reinvested into a vault
event TokensReinvested(address indexed token, address indexed vault, uint256 amount, uint256 shares);
```

### OwnerUpdated

```solidity
/// @notice Emitted when owner is updated
event OwnerUpdated(address indexed oldOwner, address indexed newOwner);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2425:116:591
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
/// @notice Initialize the emergency vault
///  @param owner_ The owner address of the vault
constructor(address owner_);
```

### withdrawTokens(address,address)

- **Signature**: `withdrawTokens(address,address)`
- **Visibility**: external
- **Source Range**: 2893:439:591
- **Details**: [function_withdrawTokens_address_address.md](./function_withdrawTokens_address_address.md)

**Signature:**
```solidity
/// @notice Withdraw tokens from the emergency vault to a recipient
///  @param token_ The token address to withdraw
///  @param to_ The recipient address
function withdrawTokens(address token_, address to_) external onlyOwner();
```

### reinvestIntoVault(address,address,uint256,address)

- **Signature**: `reinvestIntoVault(address,address,uint256,address)`
- **Visibility**: external
- **Source Range**: 3600:1020:591
- **Details**: [function_reinvestIntoVault_address_address_uint256_address.md](./function_reinvestIntoVault_address_address_uint256_address.md)

**Signature:**
```solidity
/// @notice Reinvest tokens into a SuperVault or any ERC4626 vault
///  @param token_ The token to reinvest
///  @param vault_ The vault to deposit into
///  @param amount_ The amount to reinvest
///  @return shares The amount of shares received
function reinvestIntoVault(address token_, address vault_, uint256 amount_, address receiver_) external onlyOwner() returns (uint256 shares);
```

### updateOwner(address)

- **Signature**: `updateOwner(address)`
- **Visibility**: external
- **Source Range**: 4729:237:591
- **Details**: [function_updateOwner_address.md](./function_updateOwner_address.md)

**Signature:**
```solidity
/// @notice Update the owner of the emergency vault
///  @param newOwner_ The new owner address
function updateOwner(address newOwner_) external onlyOwner();
```

### getTokenBalance(address)

- **Signature**: `getTokenBalance(address)`
- **Visibility**: public
- **Source Range**: 5303:158:591
- **Details**: [function_getTokenBalance_address.md](./function_getTokenBalance_address.md)

**Signature:**
```solidity
/// @notice Get the balance of a specific token in the emergency vault
///  @param token_ The token address
///  @return The token balance
function getTokenBalance(address token_) public view returns (uint256);
```
