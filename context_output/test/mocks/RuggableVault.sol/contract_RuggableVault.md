# Contract: RuggableVault

## Metadata

- **Name**: RuggableVault
- **Type**: Contract
- **Path**: test/mocks/RuggableVault.sol
- **Documentation**:  @title RuggableVault
   @notice A mock ERC4626 vault that can simulate a rug pull by not transferring assets or shares
   @dev This is for testing purposes only to simulate malicious behavior

## Implements Interfaces

- **IERC4626** [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
- **IERC20Errors** [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol/interface_IERC20Errors.md]
- **IERC20Metadata** [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

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

### _asset

```solidity
IERC20 private immutable _asset
```

**IERC20**: [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### _decimals

```solidity
uint8 private immutable _decimals
```

### rugOnDeposit

```solidity
bool public rugOnDeposit
```

### rugOnWithdraw

```solidity
bool public rugOnWithdraw
```

### rugPercentage

```solidity
uint256 public rugPercentage
```

### PRECISION

```solidity
uint256 public constant PRECISION = 1e18
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

### RugPull

```solidity
event RugPull(string action, address user, uint256 amount, uint256 ruggedAmount);
```

## Public/External Functions

### constructor(contract IERC20,string,string,bool,bool,uint256)

- **Signature**: `constructor(contract IERC20,string,string,bool,bool,uint256)`
- **Visibility**: public
- **Source Range**: 1279:474:609
- **Details**: [function_constructor_contract_IERC20_string_string_bool_bool_uint256.md](./function_constructor_contract_IERC20_string_string_bool_bool_uint256.md)

**Signature:**
```solidity
constructor(IERC20 asset_, string memory name_, string memory symbol_, bool rugOnDeposit_, bool rugOnWithdraw_, uint256 rugPercentage_) ERC20(name_,symbol_);
```

### setRugOnDeposit(bool)

- **Signature**: `setRugOnDeposit(bool)`
- **Visibility**: external
- **Source Range**: 1790:83:609
- **Details**: [function_setRugOnDeposit_bool.md](./function_setRugOnDeposit_bool.md)

**Signature:**
```solidity
function setRugOnDeposit(bool value) external;
```

### setRugOnWithdraw(bool)

- **Signature**: `setRugOnWithdraw(bool)`
- **Visibility**: external
- **Source Range**: 1879:85:609
- **Details**: [function_setRugOnWithdraw_bool.md](./function_setRugOnWithdraw_bool.md)

**Signature:**
```solidity
function setRugOnWithdraw(bool value) external;
```

### setRugPercentage(uint256)

- **Signature**: `setRugPercentage(uint256)`
- **Visibility**: external
- **Source Range**: 1970:129:609
- **Details**: [function_setRugPercentage_uint256.md](./function_setRugPercentage_uint256.md)

**Signature:**
```solidity
function setRugPercentage(uint256 percentage) external;
```

### calculateRuggedAmount(uint256)

- **Signature**: `calculateRuggedAmount(uint256)`
- **Visibility**: public
- **Source Range**: 2136:132:609
- **Details**: [function_calculateRuggedAmount_uint256.md](./function_calculateRuggedAmount_uint256.md)

**Signature:**
```solidity
function calculateRuggedAmount(uint256 amount) public view returns (uint256);
```

### asset()

- **Signature**: `asset()`
- **Visibility**: public
- **Source Range**: 2304:95:609
- **Details**: [function_asset.md](./function_asset.md)

**Signature:**
```solidity
function asset() override public view returns (address);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 2405:113:609
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() override(ERC20, IERC20Metadata) public view returns (uint8);
```

### totalAssets()

- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 2524:117:609
- **Details**: [function_totalAssets.md](./function_totalAssets.md)

**Signature:**
```solidity
function totalAssets() override public view returns (uint256);
```

### convertToShares(uint256)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 2647:290:609
- **Details**: [function_convertToShares_uint256.md](./function_convertToShares_uint256.md)

**Signature:**
```solidity
function convertToShares(uint256 assets) override public view returns (uint256);
```

### convertToAssets(uint256)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: public
- **Source Range**: 2943:224:609
- **Details**: [function_convertToAssets_uint256.md](./function_convertToAssets_uint256.md)

**Signature:**
```solidity
function convertToAssets(uint256 shares) override public view returns (uint256);
```

### maxDeposit(address)

- **Signature**: `maxDeposit(address)`
- **Visibility**: public
- **Source Range**: 3173:109:609
- **Details**: [function_maxDeposit_address.md](./function_maxDeposit_address.md)

**Signature:**
```solidity
function maxDeposit(address) override public pure returns (uint256);
```

### maxMint(address)

- **Signature**: `maxMint(address)`
- **Visibility**: public
- **Source Range**: 3288:106:609
- **Details**: [function_maxMint_address.md](./function_maxMint_address.md)

**Signature:**
```solidity
function maxMint(address) override public pure returns (uint256);
```

### maxWithdraw(address)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 3400:132:609
- **Details**: [function_maxWithdraw_address.md](./function_maxWithdraw_address.md)

**Signature:**
```solidity
function maxWithdraw(address owner) override public view returns (uint256);
```

### maxRedeem(address)

- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 3538:113:609
- **Details**: [function_maxRedeem_address.md](./function_maxRedeem_address.md)

**Signature:**
```solidity
function maxRedeem(address owner) override public view returns (uint256);
```

### previewDeposit(uint256)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: public
- **Source Range**: 3657:126:609
- **Details**: [function_previewDeposit_uint256.md](./function_previewDeposit_uint256.md)

**Signature:**
```solidity
function previewDeposit(uint256 assets) override public view returns (uint256);
```

### previewMint(uint256)

- **Signature**: `previewMint(uint256)`
- **Visibility**: public
- **Source Range**: 3789:285:609
- **Details**: [function_previewMint_uint256.md](./function_previewMint_uint256.md)

**Signature:**
```solidity
function previewMint(uint256 shares) override public view returns (uint256);
```

### previewWithdraw(uint256)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 4080:289:609
- **Details**: [function_previewWithdraw_uint256.md](./function_previewWithdraw_uint256.md)

**Signature:**
```solidity
function previewWithdraw(uint256 assets) override public view returns (uint256);
```

### previewRedeem(uint256)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 4375:125:609
- **Details**: [function_previewRedeem_uint256.md](./function_previewRedeem_uint256.md)

**Signature:**
```solidity
function previewRedeem(uint256 shares) override public view returns (uint256);
```

### deposit(uint256,address)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: public
- **Source Range**: 4506:755:609
- **Details**: [function_deposit_uint256_address.md](./function_deposit_uint256_address.md)

**Signature:**
```solidity
function deposit(uint256 assets, address receiver) override public returns (uint256);
```

### mint(uint256,address)

- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 5267:740:609
- **Details**: [function_mint_uint256_address.md](./function_mint_uint256_address.md)

**Signature:**
```solidity
function mint(uint256 shares, address receiver) override public returns (uint256);
```

### withdraw(uint256,address,address)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 6013:960:609
- **Details**: [function_withdraw_uint256_address_address.md](./function_withdraw_uint256_address_address.md)

**Signature:**
```solidity
function withdraw(uint256 assets, address receiver, address owner) override public returns (uint256);
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 6979:960:609
- **Details**: [function_redeem_uint256_address_address.md](./function_redeem_uint256_address_address.md)

**Signature:**
```solidity
function redeem(uint256 shares, address receiver, address owner) override public returns (uint256);
```

### name() (inherited from ERC20)

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 1760:89:48
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() virtual public view returns (string memory);
```

### symbol() (inherited from ERC20)

- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 1962:93:48
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
- **Source Range**: 2803:97:48
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function totalSupply() virtual public view returns (uint256);
```

### balanceOf(address) (inherited from ERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 2933:116:48
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function balanceOf(address account) virtual public view returns (uint256);
```

### transfer(address,uint256) (inherited from ERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3244:178:48
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
- **Source Range**: 3455:140:48
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function allowance(address owner, address spender) virtual public view returns (uint256);
```

### approve(address,uint256) (inherited from ERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3902:186:48
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
- **Source Range**: 4680:244:48
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
