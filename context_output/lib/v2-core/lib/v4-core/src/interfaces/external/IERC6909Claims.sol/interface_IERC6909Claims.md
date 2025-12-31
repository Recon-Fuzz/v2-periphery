# Interface: IERC6909Claims

## Metadata

- **Name**: IERC6909Claims
- **Type**: Interface
- **Path**: lib/v2-core/lib/v4-core/src/interfaces/external/IERC6909Claims.sol
- **Documentation**: @notice Interface for claims over a contract balance, wrapped as a ERC6909

## Events

### OperatorSet

```solidity
event OperatorSet(address indexed owner, address indexed operator, bool approved);
```

### Approval

```solidity
event Approval(address indexed owner, address indexed spender, uint256 indexed id, uint256 amount);
```

### Transfer

```solidity
event Transfer(address caller, address indexed from, address indexed to, uint256 indexed id, uint256 amount);
```

## Public/External Functions

### balanceOf(address,uint256)

- **Signature**: `balanceOf(address,uint256)`
- **Visibility**: external
- **Source Range**: 1011:85:332

**Signature:**
```solidity
/// @notice Owner balance of an id.
///  @param owner The address of the owner.
///  @param id The id of the token.
///  @return amount The balance of the token.
function balanceOf(address owner, uint256 id) external view returns (uint256 amount);;
```

### allowance(address,address,uint256)

- **Signature**: `allowance(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1334:102:332

**Signature:**
```solidity
/// @notice Spender allowance of an id.
///  @param owner The address of the owner.
///  @param spender The address of the spender.
///  @param id The id of the token.
///  @return amount The allowance of the token.
function allowance(address owner, address spender, uint256 id) external view returns (uint256 amount);;
```

### isOperator(address,address)

- **Signature**: `isOperator(address,address)`
- **Visibility**: external
- **Source Range**: 1661:90:332

**Signature:**
```solidity
/// @notice Checks if a spender is approved by an owner as an operator
///  @param owner The address of the owner.
///  @param spender The address of the spender.
///  @return approved The approval status.
function isOperator(address owner, address spender) external view returns (bool approved);;
```

### transfer(address,uint256,uint256)

- **Signature**: `transfer(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2035:88:332

**Signature:**
```solidity
/// @notice Transfers an amount of an id from the caller to a receiver.
///  @param receiver The address of the receiver.
///  @param id The id of the token.
///  @param amount The amount of the token.
///  @return bool True, always, unless the function reverts
function transfer(address receiver, uint256 id, uint256 amount) external returns (bool);;
```

### transferFrom(address,address,uint256,uint256)

- **Signature**: `transferFrom(address,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2454:108:332

**Signature:**
```solidity
/// @notice Transfers an amount of an id from a sender to a receiver.
///  @param sender The address of the sender.
///  @param receiver The address of the receiver.
///  @param id The id of the token.
///  @param amount The amount of the token.
///  @return bool True, always, unless the function reverts
function transferFrom(address sender, address receiver, uint256 id, uint256 amount) external returns (bool);;
```

### approve(address,uint256,uint256)

- **Signature**: `approve(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2797:86:332

**Signature:**
```solidity
/// @notice Approves an amount of an id to a spender.
///  @param spender The address of the spender.
///  @param id The id of the token.
///  @param amount The amount of the token.
///  @return bool True, always
function approve(address spender, uint256 id, uint256 amount) external returns (bool);;
```

### setOperator(address,bool)

- **Signature**: `setOperator(address,bool)`
- **Visibility**: external
- **Source Range**: 3081:78:332

**Signature:**
```solidity
/// @notice Sets or removes an operator for the caller.
///  @param operator The address of the operator.
///  @param approved The approval status.
///  @return bool True, always
function setOperator(address operator, bool approved) external returns (bool);;
```
