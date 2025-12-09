# Interface: IIncentiveFundContract

## Metadata

- **Name**: IIncentiveFundContract
- **Type**: Interface
- **Path**: test/draft/src/interfaces/SuperAsset/IIncentiveFundContract.sol
- **Documentation**: @title IIncentiveFundContract
   @notice Interface for IncentiveFundContract which manages incentive tokens in the SuperAsset system

## Errors

### ZERO_ADDRESS

```solidity
/// @notice Thrown when an address parameter is zero
error ZERO_ADDRESS();
```

### ZERO_AMOUNT

```solidity
/// @notice Thrown when amount is zero
error ZERO_AMOUNT();
```

### TOKEN_OUT_NOT_SET

```solidity
/// @notice Thrown when tokenOut is not configured
error TOKEN_OUT_NOT_SET();
```

### TOKEN_IN_NOT_SET

```solidity
/// @notice Thrown when tokenIn is not configured
error TOKEN_IN_NOT_SET();
```

### ALREADY_INITIALIZED

```solidity
/// @notice Thrown when contract is already initialized
error ALREADY_INITIALIZED();
```

### UNAUTHORIZED

```solidity
/// @notice Thrown when the caller is not authorized
error UNAUTHORIZED();
```

### TOKEN_NOT_WHITELISTED

```solidity
/// @notice Thrown when attempting to set a non-whitelisted incentive token
error TOKEN_NOT_WHITELISTED();
```

## Events

### TokenInIncentiveSet

```solidity
/// @notice Emitted when the token for incoming incentives is set
///  @param token Address of the token
event TokenInIncentiveSet(address indexed token);
```

### TokenOutIncentiveSet

```solidity
/// @notice Emitted when the token for outgoing incentives is set
///  @param token Address of the token
event TokenOutIncentiveSet(address indexed token);
```

### IncentivesToggled

```solidity
/// @notice Emitted when incentives are toggled
///  @param enabled Whether incentives are enabled
event IncentivesToggled(bool indexed enabled);
```

### IncentivePaid

```solidity
/// @notice Emitted when incentives are paid to a receiver
///  @param receiver Address that received the incentives
///  @param tokenOut Token that was paid
///  @param amount Amount that was paid
event IncentivePaid(address indexed receiver, address indexed tokenOut, uint256 amount);
```

### IncentiveTaken

```solidity
/// @notice Emitted when incentives are taken from a sender
///  @param sender Address that sent the incentives
///  @param tokenIn Token that was taken
///  @param amount Amount that was taken
event IncentiveTaken(address indexed sender, address indexed tokenIn, uint256 amount);
```

### RebalanceWithdrawal

```solidity
/// @notice Emitted when tokens are withdrawn during rebalancing
///  @param receiver Address that received the tokens
///  @param tokenOut Token that was withdrawn
///  @param amount Amount that was withdrawn
event RebalanceWithdrawal(address indexed receiver, address indexed tokenOut, uint256 amount);
```

### SettlementTokenInSet

```solidity
/// @notice Emitted when settlement token for incoming incentives is set
///  @param token Address of the token
event SettlementTokenInSet(address indexed token);
```

### SettlementTokenOutSet

```solidity
/// @notice Emitted when settlement token for outgoing incentives is set
///  @param token Address of the token
event SettlementTokenOutSet(address indexed token);
```

## Public/External Functions

### tokenInIncentive()

- **Signature**: `tokenInIncentive()`
- **Visibility**: external
- **Source Range**: 3211:60:558

**Signature:**
```solidity
/// @notice The token users send incentives to
function tokenInIncentive() external view returns (address);;
```

### tokenOutIncentive()

- **Signature**: `tokenOutIncentive()`
- **Visibility**: external
- **Source Range**: 3326:61:558

**Signature:**
```solidity
/// @notice The token used to pay incentives
function tokenOutIncentive() external view returns (address);;
```

### initialize(address,address,address,address,address)

- **Signature**: `initialize(address,address,address,address,address)`
- **Visibility**: external
- **Source Range**: 3802:207:558

**Signature:**
```solidity
/// @notice Initializes the IncentiveFundContract
///  @param _superGovernor Address of the SuperGovernor contract
///  @param _superRegistry Address of the SuperRegistry contract
///  @param superAsset_ Address of the SuperAsset contract
///  @param tokenInIncentive_ Address of the token users send incentives to
///  @param tokenOutIncentive_ Address of the token used to pay incentives
function initialize(address _superGovernor, address _superRegistry, address superAsset_, address tokenInIncentive_, address tokenOutIncentive_) external;;
```

### payIncentive(address,uint256)

- **Signature**: `payIncentive(address,uint256)`
- **Visibility**: external
- **Source Range**: 4219:95:558

**Signature:**
```solidity
/// @notice Pays incentives to a receiver
///  @param receiver Address to receive the incentives
///  @param amount Amount of incentives to pay
///  @return amountToken Amount of tokens paid
function payIncentive(address receiver, uint256 amount) external returns (uint256 amountToken);;
```

### takeIncentive(address,uint256)

- **Signature**: `takeIncentive(address,uint256)`
- **Visibility**: external
- **Source Range**: 4526:97:558

**Signature:**
```solidity
/// @notice Takes incentives from a sender
///  @param sender Address to take incentives from
///  @param amountUSD Amount of incentives to take
///  @return amountToken Amount of tokens taken
function takeIncentive(address sender, uint256 amountUSD) external returns (uint256 amountToken);;
```

### withdraw(address,address,uint256)

- **Signature**: `withdraw(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 4818:79:558

**Signature:**
```solidity
/// @notice Withdraws tokens during rebalancing
///  @param receiver Address to receive the tokens
///  @param tokenOut Token to withdraw
///  @param amount Amount to withdraw
function withdraw(address receiver, address tokenOut, uint256 amount) external;;
```

### setTokenInIncentive(address)

- **Signature**: `setTokenInIncentive(address)`
- **Visibility**: external
- **Source Range**: 5000:53:558

**Signature:**
```solidity
/// @notice Sets the token for incoming incentives
///  @param token Address of the token
function setTokenInIncentive(address token) external;;
```

### setTokenOutIncentive(address)

- **Signature**: `setTokenOutIncentive(address)`
- **Visibility**: external
- **Source Range**: 5156:54:558

**Signature:**
```solidity
/// @notice Sets the token for outgoing incentives
///  @param token Address of the token
function setTokenOutIncentive(address token) external;;
```

### toggleIncentives(bool)

- **Signature**: `toggleIncentives(bool)`
- **Visibility**: external
- **Source Range**: 5305:49:558

**Signature:**
```solidity
/// @notice Toggles incentives
///  @param enabled Whether incentives are enabled
function toggleIncentives(bool enabled) external;;
```

### incentivesEnabled()

- **Signature**: `incentivesEnabled()`
- **Visibility**: external
- **Source Range**: 5462:58:558

**Signature:**
```solidity
/// @notice Returns whether incentives are enabled
///  @return Whether incentives are enabled
function incentivesEnabled() external view returns (bool);;
```
