# Contract: SuperVault

## Metadata

- **Name**: SuperVault
- **Type**: Contract
- **Path**: src/SuperVault/SuperVault.sol
- **Documentation**: @title SuperVault
   @author Superform Labs
   @notice SuperVault vault contract implementing ERC4626 with synchronous deposits and asynchronous redeems via
   ERC7540

## Implements Interfaces

- **IERC5267** [lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol/interface_IERC5267.md]
- **ISuperVault** [src/interfaces/SuperVault/ISuperVault.sol/interface_ISuperVault.md]
- **IERC7540CancelRedeem** [src/vendor/standards/ERC7540/IERC7540Vault.sol/interface_IERC7540CancelRedeem.md]
- **IERC7741** [src/vendor/standards/ERC7741/IERC7741.sol/interface_IERC7741.md]
- **IERC7540Redeem** [src/vendor/standards/ERC7540/IERC7540Vault.sol/interface_IERC7540Redeem.md]
- **IERC7540Operator** [src/vendor/standards/ERC7540/IERC7540Vault.sol/interface_IERC7540Operator.md]
- **IERC4626** [lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
- **IERC20Errors** [lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol/interface_IERC20Errors.md]
- **IERC20Metadata** [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variables

### INITIALIZABLE_STORAGE (inherited from Initializable)

```solidity
bytes32 private constant INITIALIZABLE_STORAGE = 0xf0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00
```

### ERC20StorageLocation (inherited from ERC20Upgradeable)

```solidity
bytes32 private constant ERC20StorageLocation = 0x52c63247e1f47db19d5ce0460030c497f067ca4cebf71ba98eeadabe20bace00
```

### NOT_ENTERED (inherited from ReentrancyGuardUpgradeable)

```solidity
uint256 private constant NOT_ENTERED = 1
```

### ENTERED (inherited from ReentrancyGuardUpgradeable)

```solidity
uint256 private constant ENTERED = 2
```

### ReentrancyGuardStorageLocation (inherited from ReentrancyGuardUpgradeable)

```solidity
bytes32 private constant ReentrancyGuardStorageLocation = 0x9b779b17422d0df92223018b32b4d1fa46e071723d6817e2486d003becc55f00
```

### TYPE_HASH (inherited from EIP712Upgradeable)

```solidity
bytes32 private constant TYPE_HASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)")
```

### EIP712StorageLocation (inherited from EIP712Upgradeable)

```solidity
bytes32 private constant EIP712StorageLocation = 0xa16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d100
```

### REQUEST_ID

```solidity
uint256 private constant REQUEST_ID = 0
```

### BPS_PRECISION

```solidity
uint256 private constant BPS_PRECISION = 10_000
```

### AUTHORIZE_OPERATOR_TYPEHASH

```solidity
/// - operator: The address being authorized/deauthorized
///       - approved: True to authorize, false to revoke
///       - nonce: Unique nonce for replay protection (one-time use)
///       - deadline: Timestamp after which signature expires
///  @dev This typehash MUST remain constant. Any changes invalidate all existing signatures.
///  @dev Off-chain signers must use this exact structure when creating signatures for authorizeOperator()
bytes32 public constant AUTHORIZE_OPERATOR_TYPEHASH = keccak256("AuthorizeOperator(address controller,address operator,bool approved,bytes32 nonce,uint256 deadline)")
```

### share

```solidity
address public share
```

### _asset

```solidity
IERC20 private _asset
```

**IERC20**: [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### _underlyingDecimals

```solidity
uint8 private _underlyingDecimals
```

### strategy

```solidity
ISuperVaultStrategy public strategy
```

**ISuperVaultStrategy**: [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]

### escrow

```solidity
address public escrow
```

### PRECISION

```solidity
uint256 public PRECISION
```

### SUPER_GOVERNOR

```solidity
ISuperGovernor public immutable SUPER_GOVERNOR
```

**ISuperGovernor**: [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

### isOperator

```solidity
/// @inheritdoc IERC7540Operator
mapping(address => mapping(address => bool)) public isOperator
```

### _authorizations

```solidity
mapping(address => mapping(bytes32 => bool)) private _authorizations
```

## Structs

### InitializableStorage (inherited from Initializable)

```solidity
///  @dev Storage of the initializable contract.
///  It's implemented on a custom ERC-7201 namespace to reduce the risk of storage collisions
///  when using with upgradeable contracts.
///  @custom:storage-location erc7201:openzeppelin.storage.Initializable
struct InitializableStorage {
    uint64 _initialized;
    bool _initializing;
}
```

### ERC20Storage (inherited from ERC20Upgradeable)

```solidity
/// @custom:storage-location erc7201:openzeppelin.storage.ERC20
struct ERC20Storage {
    mapping(address => uint256) _balances;
    mapping(address => mapping(address => uint256)) _allowances;
    uint256 _totalSupply;
    string _name;
    string _symbol;
}
```

### ReentrancyGuardStorage (inherited from ReentrancyGuardUpgradeable)

```solidity
/// @custom:storage-location erc7201:openzeppelin.storage.ReentrancyGuard
struct ReentrancyGuardStorage {
    uint256 _status;
}
```

### EIP712Storage (inherited from EIP712Upgradeable)

```solidity
/// @custom:storage-location erc7201:openzeppelin.storage.EIP712
struct EIP712Storage {
    bytes32 _hashedName;
    bytes32 _hashedVersion;
    string _name;
    string _version;
}
```

## Errors

### InvalidInitialization (inherited from Initializable)

```solidity
///  @dev The contract is already initialized.
error InvalidInitialization();
```

### NotInitializing (inherited from Initializable)

```solidity
///  @dev The contract is not initializing.
error NotInitializing();
```

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

### INVALID_ASSET (inherited from ISuperVault)

```solidity
error INVALID_ASSET();
```

### ZERO_ADDRESS (inherited from ISuperVault)

```solidity
error ZERO_ADDRESS();
```

### ZERO_AMOUNT (inherited from ISuperVault)

```solidity
error ZERO_AMOUNT();
```

### INVALID_AMOUNT (inherited from ISuperVault)

```solidity
error INVALID_AMOUNT();
```

### UNAUTHORIZED (inherited from ISuperVault)

```solidity
error UNAUTHORIZED();
```

### DEADLINE_PASSED (inherited from ISuperVault)

```solidity
error DEADLINE_PASSED();
```

### INVALID_SIGNATURE (inherited from ISuperVault)

```solidity
error INVALID_SIGNATURE();
```

### NOT_IMPLEMENTED (inherited from ISuperVault)

```solidity
error NOT_IMPLEMENTED();
```

### INVALID_NONCE (inherited from ISuperVault)

```solidity
error INVALID_NONCE();
```

### INVALID_WITHDRAW_PRICE (inherited from ISuperVault)

```solidity
error INVALID_WITHDRAW_PRICE();
```

### INVALID_CONTROLLER (inherited from ISuperVault)

```solidity
error INVALID_CONTROLLER();
```

### CONTROLLER_MUST_EQUAL_OWNER (inherited from ISuperVault)

```solidity
error CONTROLLER_MUST_EQUAL_OWNER();
```

### RECEIVER_MUST_EQUAL_CONTROLLER (inherited from ISuperVault)

```solidity
error RECEIVER_MUST_EQUAL_CONTROLLER();
```

### NOT_ENOUGH_ASSETS (inherited from ISuperVault)

```solidity
error NOT_ENOUGH_ASSETS();
```

### CANCELLATION_REDEEM_REQUEST_PENDING (inherited from ISuperVault)

```solidity
error CANCELLATION_REDEEM_REQUEST_PENDING();
```

### ReentrancyGuardReentrantCall (inherited from ReentrancyGuardUpgradeable)

```solidity
///  @dev Unauthorized reentrant call.
error ReentrancyGuardReentrantCall();
```

## Events

### Initialized (inherited from Initializable)

```solidity
///  @dev Triggered when the contract has been initialized or reinitialized.
event Initialized(uint64 version);
```

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

### OperatorSet (inherited from IERC7540Operator)

```solidity
///  @dev The event emitted when an operator is set.
///  @param controller The address of the controller.
///  @param operator The address of the operator.
///  @param approved The approval status.
event OperatorSet(address indexed controller, address indexed operator, bool approved);
```

### RedeemRequest (inherited from IERC7540Redeem)

```solidity
event RedeemRequest(address indexed controller, address indexed owner, uint256 indexed requestId, address sender, uint256 assets);
```

### CancelRedeemRequest (inherited from IERC7540CancelRedeem)

```solidity
event CancelRedeemRequest(address indexed controller, uint256 indexed requestId, address sender);
```

### CancelRedeemClaim (inherited from IERC7540CancelRedeem)

```solidity
event CancelRedeemClaim(address indexed receiver, address indexed controller, uint256 indexed requestId, address sender, uint256 shares);
```

### NonceInvalidated (inherited from ISuperVault)

```solidity
event NonceInvalidated(address indexed sender, bytes32 indexed nonce);
```

### SuperGovernorSet (inherited from ISuperVault)

```solidity
event SuperGovernorSet(address indexed superGovernor);
```

### Initialized (inherited from ISuperVault)

```solidity
event Initialized(address indexed asset, address indexed strategy, address indexed escrow);
```

### EIP712DomainChanged (inherited from IERC5267)

```solidity
///  @dev MAY be emitted to signal that the domain could have changed.
event EIP712DomainChanged();
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 4428:245:510
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address superGovernor_);
```

### initialize(address,string,string,address,address)

- **Signature**: `initialize(address,string,string,address,address)`
- **Visibility**: external
- **Source Range**: 5795:911:510
- **Details**: [function_initialize_address_string_string_address_address.md](./function_initialize_address_string_string_address_address.md)

**Signature:**
```solidity
/// @notice Initialize the vault with required parameters
///  @dev This function can only be called once due to initializer modifier
///  @dev SECURITY: asset, strategy, and escrow are pre-validated in SuperVaultAggregator.createVault()
///       to prevent initialization with invalid addresses. No additional validation needed here.
///  @dev PRECISION is set to 10^decimals for consistent share/asset conversions
///  @dev EIP-712 domain separator is initialized with vault name and version "1" for signature validation
///  @param asset_ The underlying asset token address (pre-validated by aggregator)
///  @param name_ The name of the vault token (used for ERC20 and EIP-712 domain)
///  @param symbol_ The symbol of the vault token
///  @param strategy_ The strategy contract address (pre-validated by aggregator)
///  @param escrow_ The escrow contract address (pre-validated by aggregator)
function initialize(address asset_, string memory name_, string memory symbol_, address strategy_, address escrow_) external initializer();
```

### deposit(uint256,address)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: public
- **Source Range**: 7110:730:510
- **Details**: [function_deposit_uint256_address.md](./function_deposit_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function deposit(uint256 assets, address receiver) override public nonReentrant() returns (uint256 shares);
```

### mint(uint256,address)

- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 7875:742:510
- **Details**: [function_mint_uint256_address.md](./function_mint_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function mint(uint256 shares, address receiver) override public nonReentrant() returns (uint256 assets);
```

### requestRedeem(uint256,address,address)

- **Signature**: `requestRedeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 8742:1013:510
- **Details**: [function_requestRedeem_uint256_address_address.md](./function_requestRedeem_uint256_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC7540Redeem
///  @notice Once owner has authorized an operator, controller must be the owner
function requestRedeem(uint256 shares, address controller, address owner) external returns (uint256);
```

### cancelRedeemRequest(uint256,address)

- **Signature**: `cancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9802:403:510
- **Details**: [function_cancelRedeemRequest_uint256_address.md](./function_cancelRedeemRequest_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC7540CancelRedeem
function cancelRedeemRequest(uint256, address controller) external;
```

### claimCancelRedeemRequest(uint256,address,address)

- **Signature**: `claimCancelRedeemRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 10252:756:510
- **Details**: [function_claimCancelRedeemRequest_uint256_address_address.md](./function_claimCancelRedeemRequest_uint256_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC7540CancelRedeem
function claimCancelRedeemRequest(uint256, address receiver, address controller) external returns (uint256 shares);
```

### setOperator(address,bool)

- **Signature**: `setOperator(address,bool)`
- **Visibility**: external
- **Source Range**: 11051:284:510
- **Details**: [function_setOperator_address_bool.md](./function_setOperator_address_bool.md)

**Signature:**
```solidity
/// @inheritdoc IERC7540Operator
function setOperator(address operator, bool approved) external returns (bool success);
```

### authorizeOperator(address,address,bool,bytes32,uint256,bytes)

- **Signature**: `authorizeOperator(address,address,bool,bytes32,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 11370:914:510
- **Details**: [function_authorizeOperator_address_address_bool_bytes32_uint256_bytes.md](./function_authorizeOperator_address_address_bool_bytes32_uint256_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IERC7741
function authorizeOperator(address controller, address operator, bool approved, bytes32 nonce, uint256 deadline, bytes memory signature) external returns (bool);
```

### getEscrowedAssets()

- **Signature**: `getEscrowedAssets()`
- **Visibility**: external
- **Source Range**: 12509:109:510
- **Details**: [function_getEscrowedAssets.md](./function_getEscrowedAssets.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVault
function getEscrowedAssets() external view returns (uint256);
```

### pendingRedeemRequest(uint256,address)

- **Signature**: `pendingRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 12677:234:510
- **Details**: [function_pendingRedeemRequest_uint256_address.md](./function_pendingRedeemRequest_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC7540Redeem
function pendingRedeemRequest(uint256, address controller) external view returns (uint256 pendingShares);
```

### claimableRedeemRequest(uint256,address)

- **Signature**: `claimableRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 12952:218:510
- **Details**: [function_claimableRedeemRequest_uint256_address.md](./function_claimableRedeemRequest_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC7540Redeem
function claimableRedeemRequest(uint256, address controller) external view returns (uint256 claimableShares);
```

### pendingCancelRedeemRequest(uint256,address)

- **Signature**: `pendingCancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 13217:252:510
- **Details**: [function_pendingCancelRedeemRequest_uint256_address.md](./function_pendingCancelRedeemRequest_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC7540CancelRedeem
function pendingCancelRedeemRequest(uint256, address controller) external view returns (bool isPending);
```

### claimableCancelRedeemRequest(uint256,address)

- **Signature**: `claimableCancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 13516:252:510
- **Details**: [function_claimableCancelRedeemRequest_uint256_address.md](./function_claimableCancelRedeemRequest_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC7540CancelRedeem
function claimableCancelRedeemRequest(uint256, address controller) external view returns (uint256 claimableShares);
```

### authorizations(address,bytes32)

- **Signature**: `authorizations(address,bytes32)`
- **Visibility**: external
- **Source Range**: 13834:151:510
- **Details**: [function_authorizations_address_bytes32.md](./function_authorizations_address_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc IERC7741
function authorizations(address controller, bytes32 nonce) external view returns (bool used);
```

### DOMAIN_SEPARATOR()

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 14020:110:510
- **Details**: [function_DOMAIN_SEPARATOR.md](./function_DOMAIN_SEPARATOR.md)

**Signature:**
```solidity
/// @inheritdoc IERC7741
function DOMAIN_SEPARATOR() virtual public view returns (bytes32);
```

### invalidateNonce(bytes32)

- **Signature**: `invalidateNonce(bytes32)`
- **Visibility**: external
- **Source Range**: 14165:230:510
- **Details**: [function_invalidateNonce_bytes32.md](./function_invalidateNonce_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc IERC7741
function invalidateNonce(bytes32 nonce) external;
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 14625:142:510
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
/// @inheritdoc IERC20Metadata
function decimals() virtual override(ERC20Upgradeable, IERC20Metadata) public view returns (uint8);
```

### asset()

- **Signature**: `asset()`
- **Visibility**: public
- **Source Range**: 14802:103:510
- **Details**: [function_asset.md](./function_asset.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function asset() virtual override public view returns (address);
```

### totalAssets()

- **Signature**: `totalAssets()`
- **Visibility**: external
- **Source Range**: 14940:272:510
- **Details**: [function_totalAssets.md](./function_totalAssets.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function totalAssets() override external view returns (uint256);
```

### convertToShares(uint256)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 15247:214:510
- **Details**: [function_convertToShares_uint256.md](./function_convertToShares_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function convertToShares(uint256 assets) override public view returns (uint256);
```

### convertToAssets(uint256)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: public
- **Source Range**: 15496:235:510
- **Details**: [function_convertToAssets_uint256.md](./function_convertToAssets_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function convertToAssets(uint256 shares) override public view returns (uint256);
```

### maxDeposit(address)

- **Signature**: `maxDeposit(address)`
- **Visibility**: public
- **Source Range**: 15766:154:510
- **Details**: [function_maxDeposit_address.md](./function_maxDeposit_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function maxDeposit(address) override public view returns (uint256);
```

### maxMint(address)

- **Signature**: `maxMint(address)`
- **Visibility**: external
- **Source Range**: 15955:153:510
- **Details**: [function_maxMint_address.md](./function_maxMint_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function maxMint(address) override external view returns (uint256);
```

### maxWithdraw(address)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 16143:132:510
- **Details**: [function_maxWithdraw_address.md](./function_maxWithdraw_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function maxWithdraw(address owner) override public view returns (uint256);
```

### maxRedeem(address)

- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 16310:284:510
- **Details**: [function_maxRedeem_address.md](./function_maxRedeem_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function maxRedeem(address owner) override public view returns (uint256);
```

### previewDeposit(uint256)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: public
- **Source Range**: 16629:567:510
- **Details**: [function_previewDeposit_uint256.md](./function_previewDeposit_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function previewDeposit(uint256 assets) override public view returns (uint256);
```

### previewMint(uint256)

- **Signature**: `previewMint(uint256)`
- **Visibility**: public
- **Source Range**: 17579:546:510
- **Details**: [function_previewMint_uint256.md](./function_previewMint_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
///  @dev Returns gross assets required to mint exact shares after management fees
///  @dev Formula: gross = net * BPS_PRECISION / (BPS_PRECISION - feeBps)
///  @dev Edge case: If feeBps >= 100% (10000), returns 0 (impossible to mint with 100%+ fees)
///       This prevents division by zero and represents mathematical impossibility.
function previewMint(uint256 shares) override public view returns (uint256);
```

### previewWithdraw(uint256)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 18160:176:510
- **Details**: [function_previewWithdraw_uint256.md](./function_previewWithdraw_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function previewWithdraw(uint256) override public pure returns (uint256);
```

### previewRedeem(uint256)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 18371:174:510
- **Details**: [function_previewRedeem_uint256.md](./function_previewRedeem_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function previewRedeem(uint256) override public pure returns (uint256);
```

### withdraw(uint256,address,address)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 18580:1263:510
- **Details**: [function_withdraw_uint256_address_address.md](./function_withdraw_uint256_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function withdraw(uint256 assets, address receiver, address controller) override public nonReentrant() returns (uint256 shares);
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 19878:1262:510
- **Details**: [function_redeem_uint256_address_address.md](./function_redeem_uint256_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC4626
function redeem(uint256 shares, address receiver, address controller) override public nonReentrant() returns (uint256 assets);
```

### burnShares(uint256)

- **Signature**: `burnShares(uint256)`
- **Visibility**: external
- **Source Range**: 21178:151:510
- **Details**: [function_burnShares_uint256.md](./function_burnShares_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVault
function burnShares(uint256 amount) external;
```

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 21797:401:510
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
/// @notice Checks if contract supports a given interface
///  @dev Implements ERC165 for ERC7540, ERC7741, ERC4626, ERC7575 support detection
///  @param interfaceId The interface identifier to check
///  @return True if the interface is supported, false otherwise
function supportsInterface(bytes4 interfaceId) public pure returns (bool);
```

### name() (inherited from ERC20Upgradeable)

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2697:144:34
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() virtual public view returns (string memory);
```

### symbol() (inherited from ERC20Upgradeable)

- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 2954:148:34
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
///  @dev Returns the symbol of the token, usually a shorter version of the
///  name.
function symbol() virtual public view returns (string memory);
```

### totalSupply() (inherited from ERC20Upgradeable)

- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 3850:152:34
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function totalSupply() virtual public view returns (uint256);
```

### balanceOf(address) (inherited from ERC20Upgradeable)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 4035:171:34
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function balanceOf(address account) virtual public view returns (uint256);
```

### transfer(address,uint256) (inherited from ERC20Upgradeable)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 4401:178:34
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-transfer}.
///  Requirements:
///  - `to` cannot be the zero address.
///  - the caller must have a balance of at least `value`.
function transfer(address to, uint256 value) virtual public returns (bool);
```

### allowance(address,address) (inherited from ERC20Upgradeable)

- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 4612:195:34
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function allowance(address owner, address spender) virtual public view returns (uint256);
```

### approve(address,uint256) (inherited from ERC20Upgradeable)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 5114:186:34
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

### transferFrom(address,address,uint256) (inherited from ERC20Upgradeable)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 5892:244:34
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

### eip712Domain() (inherited from EIP712Upgradeable)

- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 5043:903:37
- **Details**: [function_eip712Domain.md](./function_eip712Domain.md)

**Signature:**
```solidity
/// @inheritdoc IERC5267
function eip712Domain() virtual public view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);
```
