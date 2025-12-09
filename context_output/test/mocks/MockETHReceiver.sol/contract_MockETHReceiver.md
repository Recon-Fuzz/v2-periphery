# Contract: MockETHReceiver

## Metadata

- **Name**: MockETHReceiver
- **Type**: Contract
- **Path**: test/mocks/MockETHReceiver.sol
- **Documentation**: @title MockETHReceiver
   @author Superform Labs
   @notice Simple contract to receive and track ETH for testing, implements ERC4626 interface

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

### totalReceived

```solidity
/// @notice Total ETH received
uint256 public totalReceived
```

### receiveCount

```solidity
/// @notice Number of times ETH was received
uint256 public receiveCount
```

### USDC

```solidity
IERC20 public immutable USDC
```

**IERC20**: [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

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

### ETHReceived

```solidity
/// @notice Event emitted when ETH is received
event ETHReceived(address sender, uint256 amount, uint256 totalReceived);
```

### ExecuteCalled

```solidity
/// @notice Event emitted when execute function is called
event ExecuteCalled(address indexed sender, uint256 value);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 1135:97:590
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address usdc_) ERC20("MockETHReceiver","mETH");
```

### asset()

- **Signature**: `asset()`
- **Visibility**: external
- **Source Range**: 1428:95:590
- **Details**: [function_asset.md](./function_asset.md)

**Signature:**
```solidity
function asset() override external view returns (address);
```

### totalAssets()

- **Signature**: `totalAssets()`
- **Visibility**: external
- **Source Range**: 1529:117:590
- **Details**: [function_totalAssets.md](./function_totalAssets.md)

**Signature:**
```solidity
function totalAssets() override external view returns (uint256);
```

### convertToShares(uint256)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: external
- **Source Range**: 1652:145:590
- **Details**: [function_convertToShares_uint256.md](./function_convertToShares_uint256.md)

**Signature:**
```solidity
function convertToShares(uint256 assets) override external pure returns (uint256);
```

### convertToAssets(uint256)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: external
- **Source Range**: 1803:145:590
- **Details**: [function_convertToAssets_uint256.md](./function_convertToAssets_uint256.md)

**Signature:**
```solidity
function convertToAssets(uint256 shares) override external pure returns (uint256);
```

### maxDeposit(address)

- **Signature**: `maxDeposit(address)`
- **Visibility**: external
- **Source Range**: 1954:111:590
- **Details**: [function_maxDeposit_address.md](./function_maxDeposit_address.md)

**Signature:**
```solidity
function maxDeposit(address) override external pure returns (uint256);
```

### maxMint(address)

- **Signature**: `maxMint(address)`
- **Visibility**: external
- **Source Range**: 2071:108:590
- **Details**: [function_maxMint_address.md](./function_maxMint_address.md)

**Signature:**
```solidity
function maxMint(address) override external pure returns (uint256);
```

### maxWithdraw(address)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: external
- **Source Range**: 2185:117:590
- **Details**: [function_maxWithdraw_address.md](./function_maxWithdraw_address.md)

**Signature:**
```solidity
function maxWithdraw(address owner) override external view returns (uint256);
```

### maxRedeem(address)

- **Signature**: `maxRedeem(address)`
- **Visibility**: external
- **Source Range**: 2308:115:590
- **Details**: [function_maxRedeem_address.md](./function_maxRedeem_address.md)

**Signature:**
```solidity
function maxRedeem(address owner) override external view returns (uint256);
```

### previewDeposit(uint256)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: external
- **Source Range**: 2429:144:590
- **Details**: [function_previewDeposit_uint256.md](./function_previewDeposit_uint256.md)

**Signature:**
```solidity
function previewDeposit(uint256 assets) override external pure returns (uint256);
```

### previewMint(uint256)

- **Signature**: `previewMint(uint256)`
- **Visibility**: external
- **Source Range**: 2579:141:590
- **Details**: [function_previewMint_uint256.md](./function_previewMint_uint256.md)

**Signature:**
```solidity
function previewMint(uint256 shares) override external pure returns (uint256);
```

### previewWithdraw(uint256)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: external
- **Source Range**: 2726:145:590
- **Details**: [function_previewWithdraw_uint256.md](./function_previewWithdraw_uint256.md)

**Signature:**
```solidity
function previewWithdraw(uint256 assets) override external pure returns (uint256);
```

### previewRedeem(uint256)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: external
- **Source Range**: 2877:143:590
- **Details**: [function_previewRedeem_uint256.md](./function_previewRedeem_uint256.md)

**Signature:**
```solidity
function previewRedeem(uint256 shares) override external pure returns (uint256);
```

### deposit(uint256,address)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: external
- **Source Range**: 3026:272:590
- **Details**: [function_deposit_uint256_address.md](./function_deposit_uint256_address.md)

**Signature:**
```solidity
function deposit(uint256 assets, address receiver) override external returns (uint256);
```

### mint(uint256,address)

- **Signature**: `mint(uint256,address)`
- **Visibility**: external
- **Source Range**: 3304:269:590
- **Details**: [function_mint_uint256_address.md](./function_mint_uint256_address.md)

**Signature:**
```solidity
function mint(uint256 shares, address receiver) override external returns (uint256);
```

### withdraw(uint256,address,address)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 3579:373:590
- **Details**: [function_withdraw_uint256_address_address.md](./function_withdraw_uint256_address_address.md)

**Signature:**
```solidity
function withdraw(uint256 assets, address receiver, address owner) override external returns (uint256);
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 3958:371:590
- **Details**: [function_redeem_uint256_address_address.md](./function_redeem_uint256_address_address.md)

**Signature:**
```solidity
function redeem(uint256 shares, address receiver, address owner) override external returns (uint256);
```

### execute()

- **Signature**: `execute()`
- **Visibility**: external
- **Source Range**: 4580:559:590
- **Details**: [function_execute.md](./function_execute.md)

**Signature:**
```solidity
/// @notice Simple execute function that can be called by hooks
function execute() external payable;
```

### executeWithData(bytes)

- **Signature**: `executeWithData(bytes)`
- **Visibility**: external
- **Source Range**: 5198:223:590
- **Details**: [function_executeWithData_bytes.md](./function_executeWithData_bytes.md)

**Signature:**
```solidity
/// @notice Execute function with data parameter
function executeWithData(bytes calldata) external payable;
```

### reset()

- **Signature**: `reset()`
- **Visibility**: external
- **Source Range**: 5470:86:590
- **Details**: [function_reset.md](./function_reset.md)

**Signature:**
```solidity
/// @notice Reset counters for testing
function reset() external;
```

### withdraw()

- **Signature**: `withdraw()`
- **Visibility**: external
- **Source Range**: 5609:97:590
- **Details**: [function_withdraw.md](./function_withdraw.md)

**Signature:**
```solidity
/// @notice Withdraw all ETH (for cleanup)
function withdraw() external;
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 5947:158:590
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
/// @notice Allows the contract to receive ETH
receive() external payable;
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

### decimals() (inherited from ERC20)

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 2688:82:48
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
///  @dev Returns the number of decimals used to get its user representation.
///  For example, if `decimals` equals `2`, a balance of `505` tokens should
///  be displayed to a user as `5.05` (`505 / 10 ** 2`).
///  Tokens usually opt for a value of 18, imitating the relationship between
///  Ether and Wei. This is the default value returned by this function, unless
///  it's overridden.
///  NOTE: This information is only used for _display_ purposes: it in
///  no way affects any of the arithmetic of the contract, including
///  {IERC20-balanceOf} and {IERC20-transfer}.
function decimals() virtual public view returns (uint8);
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
