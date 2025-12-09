# Interface: IERC20

## Metadata

- **Name**: IERC20
- **Type**: Interface
- **Path**: lib/forge-std/src/interfaces/IERC20.sol
- **Documentation**: @dev Interface of the ERC20 standard as defined in the EIP.
   @dev This includes the optional name, symbol, and decimals metadata.

## Events

### Transfer

```solidity
/// @dev Emitted when `value` tokens are moved from one account (`from`) to another (`to`).
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval

```solidity
/// @dev Emitted when the allowance of a `spender` for an `owner` is set, where `value`
///  is the new allowance.
event Approval(address indexed owner, address indexed spender, uint256 value);
```

## Public/External Functions

### totalSupply()

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 657:55:29

**Signature:**
```solidity
/// @notice Returns the amount of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 783:68:29

**Signature:**
```solidity
/// @notice Returns the amount of tokens owned by `account`.
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 930:70:29

**Signature:**
```solidity
/// @notice Moves `amount` tokens from the caller's account to `to`.
function transfer(address to, uint256 amount) external returns (bool);;
```

### allowance(address,address)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1125:83:29

**Signature:**
```solidity
/// @notice Returns the remaining number of tokens that `spender` is allowed
///  to spend on behalf of `owner`
function allowance(address owner, address spender) external view returns (uint256);;
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 1412:74:29

**Signature:**
```solidity
/// @notice Sets `amount` as the allowance of `spender` over the caller's tokens.
///  @dev Be aware of front-running risks: https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
function approve(address spender, uint256 amount) external returns (bool);;
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1644:88:29

**Signature:**
```solidity
/// @notice Moves `amount` tokens from `from` to `to` using the allowance mechanism.
///  `amount` is then deducted from the caller's allowance.
function transferFrom(address from, address to, uint256 amount) external returns (bool);;
```

### name()

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 1785:54:29

**Signature:**
```solidity
/// @notice Returns the name of the token.
function name() external view returns (string memory);;
```

### symbol()

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 1894:56:29

**Signature:**
```solidity
/// @notice Returns the symbol of the token.
function symbol() external view returns (string memory);;
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 2014:50:29

**Signature:**
```solidity
/// @notice Returns the decimals places of the token.
function decimals() external view returns (uint8);;
```
