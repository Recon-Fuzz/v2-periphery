# Interface: ITranche

## Metadata

- **Name**: ITranche
- **Type**: Interface
- **Path**: test/mocks/centrifuge/ITranch.sol

## Implements Interfaces

- **IERC1404** [test/mocks/centrifuge/ITranch.sol/interface_IERC1404.md]
- **IERC20Metadata** [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Structs

### Balance

```solidity
struct Balance {
    uint128 amount;
    bytes16 hookData;
}
```

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

### File

```solidity
event File(bytes32 indexed what, address data);
```

### SetHookData

```solidity
event SetHookData(address indexed user, bytes16 data);
```

## Public/External Functions

### hook()

- **Signature**: `hook()`
- **Visibility**: external
- **Source Range**: 1790:48:621

**Signature:**
```solidity
/// @notice returns the hook that transfers perform callbacks to
///  @dev    MUST comply to `IHook` interface
function hook() external view returns (address);;
```

### file(bytes32,string)

- **Signature**: `file(bytes32,string)`
- **Visibility**: external
- **Source Range**: 1962:57:621

**Signature:**
```solidity
/// @notice Updates a contract parameter
///  @param what Accepts a bytes32 representation of 'name', 'symbol'
function file(bytes32 what, string memory data) external;;
```

### file(bytes32,address)

- **Signature**: `file(bytes32,address)`
- **Visibility**: external
- **Source Range**: 2133:51:621

**Signature:**
```solidity
/// @notice Updates a contract parameter
///  @param what Accepts a bytes32 representation of 'hook'
function file(bytes32 what, address data) external;;
```

### updateVault(address,address)

- **Signature**: `updateVault(address,address)`
- **Visibility**: external
- **Source Range**: 2244:61:621

**Signature:**
```solidity
/// @notice updates the vault for a given `asset`
function updateVault(address asset, address vault_) external;;
```

### hookDataOf(address)

- **Signature**: `hookDataOf(address)`
- **Visibility**: external
- **Source Range**: 2485:66:621

**Signature:**
```solidity
/// @notice returns the 16 byte hook data of the given `user`.
///  @dev    Stored in the 128 most significant bits of the user balance
function hookDataOf(address user) external view returns (bytes16);;
```

### setHookData(address,bytes16)

- **Signature**: `setHookData(address,bytes16)`
- **Visibility**: external
- **Source Range**: 2622:62:621

**Signature:**
```solidity
/// @notice update the 16 byte hook data of the given `user`
function setHookData(address user, bytes16 hookData) external;;
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 2730:52:621

**Signature:**
```solidity
/// @notice Function to mint tokens
function mint(address user, uint256 value) external;;
```

### burn(address,uint256)

- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 2828:52:621

**Signature:**
```solidity
/// @notice Function to burn tokens
function burn(address user, uint256 value) external;;
```

### checkTransferRestriction(address,address,uint256)

- **Signature**: `checkTransferRestriction(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2965:104:621

**Signature:**
```solidity
/// @notice Checks if the tokens can be transferred given the input values
function checkTransferRestriction(address from, address to, uint256 value) external view returns (bool);;
```

### authTransferFrom(address,address,address,uint256)

- **Signature**: `authTransferFrom(address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3216:108:621

**Signature:**
```solidity
/// @notice Performs an authorized transfer, with `sender` as the given sender.
///  @dev    Requires allowance if `sender` != `from`
function authTransferFrom(address sender, address from, address to, uint256 amount) external returns (bool);;
```

### totalSupply() (inherited from IERC20)

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 776:55:268

**Signature:**
```solidity
///  @dev Returns the value of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address) (inherited from IERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 913:68:268

**Signature:**
```solidity
///  @dev Returns the value of tokens owned by `account`.
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256) (inherited from IERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 1205:69:268

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
- **Source Range**: 1549:83:268

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
- **Source Range**: 2310:73:268

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
- **Source Range**: 2691:87:268

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from `from` to `to` using the
///  allowance mechanism. `value` is then deducted from the caller's
///  allowance.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transferFrom(address from, address to, uint256 value) external returns (bool);;
```

### name() (inherited from IERC20Metadata)

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 378:54:271

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() external view returns (string memory);;
```

### symbol() (inherited from IERC20Metadata)

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 499:56:271

**Signature:**
```solidity
///  @dev Returns the symbol of the token.
function symbol() external view returns (string memory);;
```

### decimals() (inherited from IERC20Metadata)

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 631:50:271

**Signature:**
```solidity
///  @dev Returns the decimals places of the token.
function decimals() external view returns (uint8);;
```

### detectTransferRestriction(address,address,uint256) (inherited from IERC1404)

- **Signature**: `detectTransferRestriction(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 566:106:621

**Signature:**
```solidity
/// @notice Detects if a transfer will be reverted and if so returns an appropriate reference code
///  @param from Sending address
///  @param to Receiving address
///  @param value Amount of tokens being transferred
///  @return Code by which to reference message for rejection reasoning
///  @dev Overwrite with your custom transfer restriction logic
function detectTransferRestriction(address from, address to, uint256 value) external view returns (uint8);;
```

### messageForTransferRestriction(uint8) (inherited from IERC1404)

- **Signature**: `messageForTransferRestriction(uint8)`
- **Visibility**: external
- **Source Range**: 957:100:621

**Signature:**
```solidity
/// @notice Returns a human-readable message for a given restriction code
///  @param restrictionCode Identifier for looking up a message
///  @return Text showing the restriction's reasoning
///  @dev Overwrite with your custom message and restrictionCode handling
function messageForTransferRestriction(uint8 restrictionCode) external view returns (string memory);;
```
