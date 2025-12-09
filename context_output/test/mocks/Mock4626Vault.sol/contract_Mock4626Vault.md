# Contract: Mock4626Vault

## Metadata

- **Name**: Mock4626Vault
- **Type**: Contract
- **Path**: test/mocks/Mock4626Vault.sol

## Implements Interfaces

- **IERC4626** [lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
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

### _asset (inherited from ERC4626)

```solidity
IERC20 private immutable _asset
```

**IERC20**: [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### _underlyingDecimals (inherited from ERC4626)

```solidity
uint8 private immutable _underlyingDecimals
```

### _totalAssets

```solidity
uint256 public _totalAssets
```

### _totalShares

```solidity
uint256 public _totalShares
```

### amountOf

```solidity
mapping(address => uint256) public amountOf
```

### lessAmount

```solidity
bool public lessAmount
```

### _asset

```solidity
address public _asset
```

### assetInstance

```solidity
IERC20 private immutable assetInstance
```

**IERC20**: [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### yield

```solidity
uint256 public yield
```

### yield_precision

```solidity
uint256 public yield_precision = 1e5
```

### depositTimestamps

```solidity
mapping(address => uint256) public depositTimestamps
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

### ERC4626ExceededMaxDeposit (inherited from ERC4626)

```solidity
///  @dev Attempted to deposit more assets than the max amount for `receiver`.
error ERC4626ExceededMaxDeposit(address receiver, uint256 assets, uint256 max);
```

### ERC4626ExceededMaxMint (inherited from ERC4626)

```solidity
///  @dev Attempted to mint more shares than the max amount for `receiver`.
error ERC4626ExceededMaxMint(address receiver, uint256 shares, uint256 max);
```

### ERC4626ExceededMaxWithdraw (inherited from ERC4626)

```solidity
///  @dev Attempted to withdraw more assets than the max amount for `receiver`.
error ERC4626ExceededMaxWithdraw(address owner, uint256 assets, uint256 max);
```

### ERC4626ExceededMaxRedeem (inherited from ERC4626)

```solidity
///  @dev Attempted to redeem more shares than the max amount for `receiver`.
error ERC4626ExceededMaxRedeem(address owner, uint256 shares, uint256 max);
```

### AMOUNT_NOT_VALID

```solidity
error AMOUNT_NOT_VALID();
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

### Deposit (inherited from IERC4626)

```solidity
event Deposit(address indexed sender, address indexed owner, uint256 assets, uint256 shares);
```

### Withdraw (inherited from IERC4626)

```solidity
event Withdraw(address indexed sender, address indexed receiver, address indexed owner, uint256 assets, uint256 shares);
```

## Public/External Functions

### constructor(address,string,string)

- **Signature**: `constructor(address,string,string)`
- **Visibility**: public
- **Source Range**: 761:249:585
- **Details**: [function_constructor_address_string_string.md](./function_constructor_address_string_string.md)

**Signature:**
```solidity
constructor(address asset_, string memory name_, string memory symbol_) ERC4626(IERC20(asset_)) ERC20(name_,symbol_);
```

### setAsset(address)

- **Signature**: `setAsset(address)`
- **Visibility**: external
- **Source Range**: 1016:67:585
- **Details**: [function_setAsset_address.md](./function_setAsset_address.md)

**Signature:**
```solidity
function setAsset(address _a) external;
```

### asset()

- **Signature**: `asset()`
- **Visibility**: public
- **Source Range**: 1089:86:585
- **Details**: [function_asset.md](./function_asset.md)

**Signature:**
```solidity
function asset() override public view returns (address);
```

### setYield(uint256)

- **Signature**: `setYield(uint256)`
- **Visibility**: external
- **Source Range**: 1181:74:585
- **Details**: [function_setYield_uint256.md](./function_setYield_uint256.md)

**Signature:**
```solidity
function setYield(uint256 yield_) external;
```

### setLessAmount(bool)

- **Signature**: `setLessAmount(bool)`
- **Visibility**: external
- **Source Range**: 1261:91:585
- **Details**: [function_setLessAmount_bool.md](./function_setLessAmount_bool.md)

**Signature:**
```solidity
function setLessAmount(bool lessAmount_) external;
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 1358:83:585
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() override public pure returns (uint8);
```

### previewDeposit(uint256)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: public
- **Source Range**: 1478:116:585
- **Details**: [function_previewDeposit_uint256.md](./function_previewDeposit_uint256.md)

**Signature:**
```solidity
function previewDeposit(uint256 assets) override public pure returns (uint256 shares);
```

### previewDeposit(address,uint256)

- **Signature**: `previewDeposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 1600:116:585
- **Details**: [function_previewDeposit_address_uint256.md](./function_previewDeposit_address_uint256.md)

**Signature:**
```solidity
function previewDeposit(address, uint256 assets) public pure returns (uint256 shares);
```

### previewWithdraw(uint256)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 1722:117:585
- **Details**: [function_previewWithdraw_uint256.md](./function_previewWithdraw_uint256.md)

**Signature:**
```solidity
function previewWithdraw(uint256 shares) override public pure returns (uint256 assets);
```

### previewRedeem(uint256)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 1845:115:585
- **Details**: [function_previewRedeem_uint256.md](./function_previewRedeem_uint256.md)

**Signature:**
```solidity
function previewRedeem(uint256 shares) override public pure returns (uint256 assets);
```

### convertToAssets(uint256)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: public
- **Source Range**: 1966:504:585
- **Details**: [function_convertToAssets_uint256.md](./function_convertToAssets_uint256.md)

**Signature:**
```solidity
function convertToAssets(uint256 shares) override public view returns (uint256 assets);
```

### convertToShares(uint256)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 2476:117:585
- **Details**: [function_convertToShares_uint256.md](./function_convertToShares_uint256.md)

**Signature:**
```solidity
function convertToShares(uint256 assets) override public pure returns (uint256 shares);
```

### deposit(uint256,address)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: public
- **Source Range**: 2599:718:585
- **Details**: [function_deposit_uint256_address.md](./function_deposit_uint256_address.md)

**Signature:**
```solidity
function deposit(uint256 assets, address receiver) override public returns (uint256 shares);
```

### deposit(address,address,uint256,uint256)

- **Signature**: `deposit(address,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 3323:727:585
- **Details**: [function_deposit_address_address_uint256_uint256.md](./function_deposit_address_address_uint256_uint256.md)

**Signature:**
```solidity
function deposit(address receiver, address, uint256 assets, uint256) public returns (uint256 shares);
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 4056:1216:585
- **Details**: [function_redeem_uint256_address_address.md](./function_redeem_uint256_address_address.md)

**Signature:**
```solidity
function redeem(uint256 shares, address receiver, address owner) override public returns (uint256 assets);
```

### totalAssets()

- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 5278:171:585
- **Details**: [function_totalAssets.md](./function_totalAssets.md)

**Signature:**
```solidity
function totalAssets() override public view returns (uint256);
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

### maxDeposit(address) (inherited from ERC4626)

- **Signature**: `maxDeposit(address)`
- **Visibility**: public
- **Source Range**: 6417:108:270
- **Details**: [function_maxDeposit_address.md](./function_maxDeposit_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function maxDeposit(address) virtual public view returns (uint256);
```

### maxMint(address) (inherited from ERC4626)

- **Signature**: `maxMint(address)`
- **Visibility**: public
- **Source Range**: 6560:105:270
- **Details**: [function_maxMint_address.md](./function_maxMint_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function maxMint(address) virtual public view returns (uint256);
```

### maxWithdraw(address) (inherited from ERC4626)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 6700:153:270
- **Details**: [function_maxWithdraw_address.md](./function_maxWithdraw_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function maxWithdraw(address owner) virtual public view returns (uint256);
```

### maxRedeem(address) (inherited from ERC4626)

- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 6888:112:270
- **Details**: [function_maxRedeem_address.md](./function_maxRedeem_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function maxRedeem(address owner) virtual public view returns (uint256);
```

### previewMint(uint256) (inherited from ERC4626)

- **Signature**: `previewMint(uint256)`
- **Visibility**: public
- **Source Range**: 7217:143:270
- **Details**: [function_previewMint_uint256.md](./function_previewMint_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function previewMint(uint256 shares) virtual public view returns (uint256);
```

### mint(uint256,address) (inherited from ERC4626)

- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 8185:380:270
- **Details**: [function_mint_uint256_address.md](./function_mint_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function mint(uint256 shares, address receiver) virtual public returns (uint256);
```

### withdraw(uint256,address,address) (inherited from ERC4626)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 8600:413:270
- **Details**: [function_withdraw_uint256_address_address.md](./function_withdraw_uint256_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function withdraw(uint256 assets, address receiver, address owner) virtual public returns (uint256);
```
