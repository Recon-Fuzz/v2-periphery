# Interface: IERC1363

## Metadata

- **Name**: IERC1363
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC1363.sol
- **Documentation**:  @title IERC1363
   @dev Interface of the ERC-1363 standard as defined in the https://eips.ethereum.org/EIPS/eip-1363[ERC-1363].
   Defines an extension interface for ERC-20 tokens that supports executing code on a recipient contract
   after `transfer` or `transferFrom`, or code on a spender contract after `approve`, in a single transaction.

## Implements Interfaces

- **IERC165** [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]
- **IERC20** [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Events

### Transfer (inherited from IERC20)

```solidity
///  @dev Emitted when `value` tokens are moved from one account (`from`) to
///  another (`to`).
///  Note that `value` may be zero.
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval (inherited from IERC20)

```solidity
///  @dev Emitted when the allowance of a `spender` for an `owner` is set by
///  a call to {approve}. `value` is the new allowance.
event Approval(address indexed owner, address indexed spender, uint256 value);
```

## Public/External Functions

### transferAndCall(address,uint256)

- **Signature**: `transferAndCall(address,uint256)`
- **Visibility**: external
- **Source Range**: 1523:76:40

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from the caller's account to `to`
///  and then calls {IERC1363Receiver-onTransferReceived} on `to`.
///  @param to The address which you want to transfer to.
///  @param value The amount of tokens to be transferred.
///  @return A boolean value indicating whether the operation succeeded unless throwing.
function transferAndCall(address to, uint256 value) external returns (bool);;
```

### transferAndCall(address,uint256,bytes)

- **Signature**: `transferAndCall(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 2063:97:40

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from the caller's account to `to`
///  and then calls {IERC1363Receiver-onTransferReceived} on `to`.
///  @param to The address which you want to transfer to.
///  @param value The amount of tokens to be transferred.
///  @param data Additional data with no specified format, sent in call to `to`.
///  @return A boolean value indicating whether the operation succeeded unless throwing.
function transferAndCall(address to, uint256 value, bytes calldata data) external returns (bool);;
```

### transferFromAndCall(address,address,uint256)

- **Signature**: `transferFromAndCall(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2624:94:40

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from `from` to `to` using the allowance mechanism
///  and then calls {IERC1363Receiver-onTransferReceived} on `to`.
///  @param from The address which you want to send tokens from.
///  @param to The address which you want to transfer to.
///  @param value The amount of tokens to be transferred.
///  @return A boolean value indicating whether the operation succeeded unless throwing.
function transferFromAndCall(address from, address to, uint256 value) external returns (bool);;
```

### transferFromAndCall(address,address,uint256,bytes)

- **Signature**: `transferFromAndCall(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 3265:115:40

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from `from` to `to` using the allowance mechanism
///  and then calls {IERC1363Receiver-onTransferReceived} on `to`.
///  @param from The address which you want to send tokens from.
///  @param to The address which you want to transfer to.
///  @param value The amount of tokens to be transferred.
///  @param data Additional data with no specified format, sent in call to `to`.
///  @return A boolean value indicating whether the operation succeeded unless throwing.
function transferFromAndCall(address from, address to, uint256 value, bytes calldata data) external returns (bool);;
```

### approveAndCall(address,uint256)

- **Signature**: `approveAndCall(address,uint256)`
- **Visibility**: external
- **Source Range**: 3781:80:40

**Signature:**
```solidity
///  @dev Sets a `value` amount of tokens as the allowance of `spender` over the
///  caller's tokens and then calls {IERC1363Spender-onApprovalReceived} on `spender`.
///  @param spender The address which will spend the funds.
///  @param value The amount of tokens to be spent.
///  @return A boolean value indicating whether the operation succeeded unless throwing.
function approveAndCall(address spender, uint256 value) external returns (bool);;
```

### approveAndCall(address,uint256,bytes)

- **Signature**: `approveAndCall(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 4350:101:40

**Signature:**
```solidity
///  @dev Sets a `value` amount of tokens as the allowance of `spender` over the
///  caller's tokens and then calls {IERC1363Spender-onApprovalReceived} on `spender`.
///  @param spender The address which will spend the funds.
///  @param value The amount of tokens to be spent.
///  @param data Additional data with no specified format, sent in call to `spender`.
///  @return A boolean value indicating whether the operation succeeded unless throwing.
function approveAndCall(address spender, uint256 value, bytes calldata data) external returns (bool);;
```

### totalSupply() (inherited from IERC20)

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 776:55:49

**Signature:**
```solidity
///  @dev Returns the value of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address) (inherited from IERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 913:68:49

**Signature:**
```solidity
///  @dev Returns the value of tokens owned by `account`.
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256) (inherited from IERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 1205:69:49

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from the caller's account to `to`.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transfer(address to, uint256 value) external returns (bool);;
```

### allowance(address,address) (inherited from IERC20)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1549:83:49

**Signature:**
```solidity
///  @dev Returns the remaining number of tokens that `spender` will be
///  allowed to spend on behalf of `owner` through {transferFrom}. This is
///  zero by default.
///  This value changes when {approve} or {transferFrom} are called.
function allowance(address owner, address spender) external view returns (uint256);;
```

### approve(address,uint256) (inherited from IERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 2310:73:49

**Signature:**
```solidity
///  @dev Sets a `value` amount of tokens as the allowance of `spender` over the
///  caller's tokens.
///  Returns a boolean value indicating whether the operation succeeded.
///  IMPORTANT: Beware that changing an allowance with this method brings the risk
///  that someone may use both the old and the new allowance by unfortunate
///  transaction ordering. One possible solution to mitigate this race
///  condition is to first reduce the spender's allowance to 0 and set the
///  desired value afterwards:
///  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
///  Emits an {Approval} event.
function approve(address spender, uint256 value) external returns (bool);;
```

### transferFrom(address,address,uint256) (inherited from IERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2691:87:49

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from `from` to `to` using the
///  allowance mechanism. `value` is then deducted from the caller's
///  allowance.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transferFrom(address from, address to, uint256 value) external returns (bool);;
```

### supportsInterface(bytes4) (inherited from IERC165)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 792:76:59

**Signature:**
```solidity
///  @dev Returns true if this contract implements the interface defined by
///  `interfaceId`. See the corresponding
///  https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC section]
///  to learn more about how these ids are created.
///  This function call must use less than 30 000 gas.
function supportsInterface(bytes4 interfaceId) external view returns (bool);;
```
