# Contract: VaultBankSuperPosition

## Metadata

- **Name**: VaultBankSuperPosition
- **Type**: Contract
- **Path**: test/draft/src/VaultBank/VaultBankSuperPosition.sol

## Implements Interfaces

- **ISuperPositions** [test/draft/src/interfaces/VaultBank/ISuperPositions.sol/interface_ISuperPositions.md]
- **IERC20Errors** [lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol/interface_IERC20Errors.md]
- **IERC20Metadata** [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variables

### _balances (inherited from ERC20)

```solidity
mapping(address => uint256) private _balances
```

### _allowances (inherited from ERC20)

```solidity
mapping(address => mapping(address => uint256)) private _allowances
```

### _totalSupply (inherited from ERC20)

```solidity
uint256 private _totalSupply
```

### _name (inherited from ERC20)

```solidity
string private _name
```

### _symbol (inherited from ERC20)

```solidity
string private _symbol
```

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### _pendingOwner (inherited from Ownable2Step)

```solidity
address private _pendingOwner
```

### yieldSourceOracleId

```solidity
bytes32 public yieldSourceOracleId
```

### _decimals

```solidity
uint8 private _decimals
```

## Errors

### ERC20InsufficientBalance (inherited from IERC20Errors)

```solidity
///  @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
///  @param sender Address whose tokens are being transferred.
///  @param balance Current balance for the interacting account.
///  @param needed Minimum amount required to perform a transfer.
error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);
```

### ERC20InvalidSender (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the token `sender`. Used in transfers.
///  @param sender Address whose tokens are being transferred.
error ERC20InvalidSender(address sender);
```

### ERC20InvalidReceiver (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the token `receiver`. Used in transfers.
///  @param receiver Address to which tokens are being transferred.
error ERC20InvalidReceiver(address receiver);
```

### ERC20InsufficientAllowance (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the `spender`’s `allowance`. Used in transfers.
///  @param spender Address that may be allowed to operate on tokens without being their owner.
///  @param allowance Amount of tokens a `spender` is allowed to operate with.
///  @param needed Minimum amount required to perform a transfer.
error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);
```

### ERC20InvalidApprover (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
///  @param approver Address initiating an approval operation.
error ERC20InvalidApprover(address approver);
```

### ERC20InvalidSpender (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the `spender` to be approved. Used in approvals.
///  @param spender Address that may be allowed to operate on tokens without being their owner.
error ERC20InvalidSpender(address spender);
```

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

### INVALID_DECIMALS (inherited from ISuperPositions)

```solidity
error INVALID_DECIMALS();
```

### INVALID_YIELD_SOURCE_ORACLE_ID (inherited from ISuperPositions)

```solidity
error INVALID_YIELD_SOURCE_ORACLE_ID();
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

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### OwnershipTransferStarted (inherited from Ownable2Step)

```solidity
event OwnershipTransferStarted(address indexed previousOwner, address indexed newOwner);
```

## Public/External Functions

### constructor(string,string,uint8,bytes32)

- **Signature**: `constructor(string,string,uint8,bytes32)`
- **Visibility**: public
- **Source Range**: 729:433:555
- **Details**: [function_constructor_string_string_uint8_bytes32.md](./function_constructor_string_string_uint8_bytes32.md)

**Signature:**
```solidity
/// @dev `msg.sender` is VaultBank
constructor(string memory name, string memory symbol, uint8 decimals_, bytes32 yieldSourceOracleId_) ERC20(name,symbol) Ownable(msg.sender);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 1406:90:555
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
/// @notice Get the number of decimals for the token
function decimals() override public view returns (uint8);
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 1839:99:555
- **Details**: [function_mint_address_uint256.md](./function_mint_address_uint256.md)

**Signature:**
```solidity
/// @notice Mint tokens to the specified address
///  @param to_ The address to mint tokens to
///  @param amount_ The amount of tokens to mint
function mint(address to_, uint256 amount_) external onlyOwner();
```

### burn(address,uint256)

- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 2104:103:555
- **Details**: [function_burn_address_uint256.md](./function_burn_address_uint256.md)

**Signature:**
```solidity
/// @notice Burn tokens from the specified address
///  @param from_ The address to burn tokens from
///  @param amount_ The amount of tokens to burn
function burn(address from_, uint256 amount_) external onlyOwner();
```

### name() (inherited from ERC20)

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 1760:89:267
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() virtual public view returns (string memory);
```

### symbol() (inherited from ERC20)

- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 1962:93:267
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
///  @dev Returns the symbol of the token, usually a shorter version of the
///  name.
function symbol() virtual public view returns (string memory);
```

### totalSupply() (inherited from ERC20)

- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 2803:97:267
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function totalSupply() virtual public view returns (uint256);
```

### balanceOf(address) (inherited from ERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 2933:116:267
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function balanceOf(address account) virtual public view returns (uint256);
```

### transfer(address,uint256) (inherited from ERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3244:178:267
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-transfer}.
///  Requirements:
///  - `to` cannot be the zero address.
///  - the caller must have a balance of at least `value`.
function transfer(address to, uint256 value) virtual public returns (bool);
```

### allowance(address,address) (inherited from ERC20)

- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 3455:140:267
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function allowance(address owner, address spender) virtual public view returns (uint256);
```

### approve(address,uint256) (inherited from ERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3902:186:267
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-approve}.
///  NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
///  `transferFrom`. This is semantically equivalent to an infinite approval.
///  Requirements:
///  - `spender` cannot be the zero address.
function approve(address spender, uint256 value) virtual public returns (bool);
```

### transferFrom(address,address,uint256) (inherited from ERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 4680:244:267
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-transferFrom}.
///  Skips emitting an {Approval} event indicating an allowance update. This is not
///  required by the ERC. See {xref-ERC20-_approve-address-address-uint256-bool-}[_approve].
///  NOTE: Does not update the allowance if the current allowance
///  is the maximum `uint256`.
///  Requirements:
///  - `from` and `to` cannot be the zero address.
///  - `from` must have a balance of at least `value`.
///  - the caller must have allowance for ``from``'s tokens of at least
///  `value`.
function transferFrom(address from, address to, uint256 value) virtual public returns (bool);
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

### pendingOwner() (inherited from Ownable2Step)

- **Signature**: `pendingOwner()`
- **Visibility**: public
- **Source Range**: 1232:99:252
- **Details**: [function_pendingOwner.md](./function_pendingOwner.md)

**Signature:**
```solidity
///  @dev Returns the address of the pending owner.
function pendingOwner() virtual public view returns (address);
```

### acceptOwnership() (inherited from Ownable2Step)

- **Signature**: `acceptOwnership()`
- **Visibility**: public
- **Source Range**: 2244:229:252
- **Details**: [function_acceptOwnership.md](./function_acceptOwnership.md)

**Signature:**
```solidity
///  @dev The new owner accepts the ownership transfer.
function acceptOwnership() virtual public;
```
