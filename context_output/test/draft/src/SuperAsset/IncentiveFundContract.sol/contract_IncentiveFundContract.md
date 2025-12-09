# Contract: IncentiveFundContract

## Metadata

- **Name**: IncentiveFundContract
- **Type**: Contract
- **Path**: test/draft/src/SuperAsset/IncentiveFundContract.sol
- **Documentation**: @title Incentive Fund Contract
   @author Superform Labs
   @notice Manages incentive tokens in the SuperAsset system
   @dev This contract is responsible for handling the incentive fund, including paying and taking incentives.
   @dev For now it is OK to keep Access Control but it will be managed by SuperGovernor when ready, see
   https://github.com/superform-xyz/v2-contracts/pull/377#discussion_r2058893391

## Implements Interfaces

- **IIncentiveFundContract** [test/draft/src/interfaces/SuperAsset/IIncentiveFundContract.sol/interface_IIncentiveFundContract.md]

## State Variables

### tokenInIncentive

```solidity
address public tokenInIncentive
```

### tokenOutIncentive

```solidity
address public tokenOutIncentive
```

### superAsset

```solidity
ISuperAsset public superAsset
```

**ISuperAsset**: [test/draft/src/interfaces/SuperAsset/ISuperAsset.sol/interface_ISuperAsset.md]

### superRegistry

```solidity
ISuperRegistry public superRegistry
```

**ISuperRegistry**: [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]

### superGovernor

```solidity
ISuperGovernor public superGovernor
```

**ISuperGovernor**: [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

### incentivesActive

```solidity
bool public incentivesActive
```

## Errors

### ZERO_ADDRESS (inherited from IIncentiveFundContract)

```solidity
/// @notice Thrown when an address parameter is zero
error ZERO_ADDRESS();
```

### ZERO_AMOUNT (inherited from IIncentiveFundContract)

```solidity
/// @notice Thrown when amount is zero
error ZERO_AMOUNT();
```

### TOKEN_OUT_NOT_SET (inherited from IIncentiveFundContract)

```solidity
/// @notice Thrown when tokenOut is not configured
error TOKEN_OUT_NOT_SET();
```

### TOKEN_IN_NOT_SET (inherited from IIncentiveFundContract)

```solidity
/// @notice Thrown when tokenIn is not configured
error TOKEN_IN_NOT_SET();
```

### ALREADY_INITIALIZED (inherited from IIncentiveFundContract)

```solidity
/// @notice Thrown when contract is already initialized
error ALREADY_INITIALIZED();
```

### UNAUTHORIZED (inherited from IIncentiveFundContract)

```solidity
/// @notice Thrown when the caller is not authorized
error UNAUTHORIZED();
```

### TOKEN_NOT_WHITELISTED (inherited from IIncentiveFundContract)

```solidity
/// @notice Thrown when attempting to set a non-whitelisted incentive token
error TOKEN_NOT_WHITELISTED();
```

## Events

### TokenInIncentiveSet (inherited from IIncentiveFundContract)

```solidity
/// @notice Emitted when the token for incoming incentives is set
///  @param token Address of the token
event TokenInIncentiveSet(address indexed token);
```

### TokenOutIncentiveSet (inherited from IIncentiveFundContract)

```solidity
/// @notice Emitted when the token for outgoing incentives is set
///  @param token Address of the token
event TokenOutIncentiveSet(address indexed token);
```

### IncentivesToggled (inherited from IIncentiveFundContract)

```solidity
/// @notice Emitted when incentives are toggled
///  @param enabled Whether incentives are enabled
event IncentivesToggled(bool indexed enabled);
```

### IncentivePaid (inherited from IIncentiveFundContract)

```solidity
/// @notice Emitted when incentives are paid to a receiver
///  @param receiver Address that received the incentives
///  @param tokenOut Token that was paid
///  @param amount Amount that was paid
event IncentivePaid(address indexed receiver, address indexed tokenOut, uint256 amount);
```

### IncentiveTaken (inherited from IIncentiveFundContract)

```solidity
/// @notice Emitted when incentives are taken from a sender
///  @param sender Address that sent the incentives
///  @param tokenIn Token that was taken
///  @param amount Amount that was taken
event IncentiveTaken(address indexed sender, address indexed tokenIn, uint256 amount);
```

### RebalanceWithdrawal (inherited from IIncentiveFundContract)

```solidity
/// @notice Emitted when tokens are withdrawn during rebalancing
///  @param receiver Address that received the tokens
///  @param tokenOut Token that was withdrawn
///  @param amount Amount that was withdrawn
event RebalanceWithdrawal(address indexed receiver, address indexed tokenOut, uint256 amount);
```

### SettlementTokenInSet (inherited from IIncentiveFundContract)

```solidity
/// @notice Emitted when settlement token for incoming incentives is set
///  @param token Address of the token
event SettlementTokenInSet(address indexed token);
```

### SettlementTokenOutSet (inherited from IIncentiveFundContract)

```solidity
/// @notice Emitted when settlement token for outgoing incentives is set
///  @param token Address of the token
event SettlementTokenOutSet(address indexed token);
```

## Public/External Functions

### initialize(address,address,address,address,address)

- **Signature**: `initialize(address,address,address,address,address)`
- **Visibility**: external
- **Source Range**: 1939:894:547
- **Details**: [function_initialize_address_address_address_address_address.md](./function_initialize_address_address_address_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveFundContract
function initialize(address _superGovernor, address _superRegistry, address superAsset_, address tokenInIncentive_, address tokenOutIncentive_) external;
```

### setTokenInIncentive(address)

- **Signature**: `setTokenInIncentive(address)`
- **Visibility**: external
- **Source Range**: 3065:390:547
- **Details**: [function_setTokenInIncentive_address.md](./function_setTokenInIncentive_address.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveFundContract
function setTokenInIncentive(address token) external onlyManager();
```

### setTokenOutIncentive(address)

- **Signature**: `setTokenOutIncentive(address)`
- **Visibility**: external
- **Source Range**: 3504:392:547
- **Details**: [function_setTokenOutIncentive_address.md](./function_setTokenOutIncentive_address.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveFundContract
function setTokenOutIncentive(address token) external onlyManager();
```

### toggleIncentives(bool)

- **Signature**: `toggleIncentives(bool)`
- **Visibility**: external
- **Source Range**: 3945:145:547
- **Details**: [function_toggleIncentives_bool.md](./function_toggleIncentives_bool.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveFundContract
function toggleIncentives(bool enabled) external onlyManager();
```

### payIncentive(address,uint256)

- **Signature**: `payIncentive(address,uint256)`
- **Visibility**: external
- **Source Range**: 4139:931:547
- **Details**: [function_payIncentive_address_uint256.md](./function_payIncentive_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveFundContract
function payIncentive(address receiver, uint256 amountUSD) external onlyManager() returns (uint256 amountToken);
```

### takeIncentive(address,uint256)

- **Signature**: `takeIncentive(address,uint256)`
- **Visibility**: external
- **Source Range**: 5119:937:547
- **Details**: [function_takeIncentive_address_uint256.md](./function_takeIncentive_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveFundContract
function takeIncentive(address sender, uint256 amountUSD) external onlyManager() returns (uint256 amountToken);
```

### withdraw(address,address,uint256)

- **Signature**: `withdraw(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 6105:319:547
- **Details**: [function_withdraw_address_address_uint256.md](./function_withdraw_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveFundContract
function withdraw(address receiver, address tokenOut, uint256 amount) external onlyManager();
```

### incentivesEnabled()

- **Signature**: `incentivesEnabled()`
- **Visibility**: external
- **Source Range**: 6473:98:547
- **Details**: [function_incentivesEnabled.md](./function_incentivesEnabled.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveFundContract
function incentivesEnabled() external view returns (bool);
```
