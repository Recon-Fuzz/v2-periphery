# Contract: SuperVaultStrategy

## Metadata

- **Name**: SuperVaultStrategy
- **Type**: Contract
- **Path**: src/SuperVault/SuperVaultStrategy.sol
- **Documentation**: @title SuperVaultStrategy
   @author Superform Labs
   @notice Strategy implementation for SuperVault that executes strategies

## Implements Interfaces

- **ISuperVaultStrategy** [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]

## State Variables

### INITIALIZABLE_STORAGE (inherited from Initializable)

```solidity
bytes32 private constant INITIALIZABLE_STORAGE = 0xf0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00
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

### BPS_PRECISION

```solidity
uint256 private constant BPS_PRECISION = 10_000
```

### MAX_PERFORMANCE_FEE

```solidity
uint256 private constant MAX_PERFORMANCE_FEE = 5100
```

### DEFAULT_REDEEM_SLIPPAGE_BPS

```solidity
/// @dev Default redeem slippage tolerance when user hasn't set their own (0.5%)
uint16 public constant DEFAULT_REDEEM_SLIPPAGE_BPS = 50
```

### MIN_PPS_EXPIRATION_THRESHOLD

```solidity
/// @dev Minimum allowed staleness threshold for PPS updates (prevents too-frequent validation)
uint256 private constant MIN_PPS_EXPIRATION_THRESHOLD = 1 minutes
```

### MAX_PPS_EXPIRATION_THRESHOLD

```solidity
/// @dev Maximum allowed staleness threshold for PPS updates (prevents indefinite stale data usage)
uint256 private constant MAX_PPS_EXPIRATION_THRESHOLD = 1 weeks
```

### POST_UNPAUSE_SKIM_TIMELOCK

```solidity
/// @dev Timelock period after unpause during which performance fee skimming is disabled (rug prevention)
uint256 private constant POST_UNPAUSE_SKIM_TIMELOCK = 12 hours
```

### PROPOSAL_TIMELOCK

```solidity
/// @dev Timelock duration for fee config and PPS expiration threshold updates
uint256 private constant PROPOSAL_TIMELOCK = 1 weeks
```

### PRECISION

```solidity
uint256 public PRECISION
```

### _vault

```solidity
address private _vault
```

### _vaultDecimals

```solidity
uint8 private _vaultDecimals
```

### __gap1

```solidity
uint88 private __gap1
```

### _asset

```solidity
IERC20 private _asset
```

**IERC20**: [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### __gap2

```solidity
uint96 private __gap2
```

### feeConfig

```solidity
FeeConfig private feeConfig
```

### proposedFeeConfig

```solidity
FeeConfig private proposedFeeConfig
```

### feeConfigEffectiveTime

```solidity
uint256 private feeConfigEffectiveTime
```

### SUPER_GOVERNOR

```solidity
ISuperGovernor public immutable SUPER_GOVERNOR
```

**ISuperGovernor**: [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

### proposedPPSExpiryThreshold

```solidity
uint256 public proposedPPSExpiryThreshold
```

### ppsExpiryThresholdEffectiveTime

```solidity
uint256 public ppsExpiryThresholdEffectiveTime
```

### ppsExpiration

```solidity
uint256 public ppsExpiration
```

### yieldSources

```solidity
mapping(address => address) private yieldSources
```

### yieldSourcesList

```solidity
EnumerableSet.AddressSet private yieldSourcesList
```

### vaultHwmPps

```solidity
/// @notice High-water mark price-per-share for performance fee calculation
///  @dev Represents the PPS at which performance fees were last collected
///       Scaled by PRECISION (e.g., 1e6 for USDC vaults, 1e18 for 18-decimal vaults)
///       Updated during skimPerformanceFee() when fees are taken, and in executeVaultFeeConfigUpdate()
uint256 public vaultHwmPps
```

### superVaultState

```solidity
mapping(address => SuperVaultState) private superVaultState
```

## Structs

### FeeConfig (inherited from ISuperVaultStrategy)

```solidity
struct FeeConfig {
    uint256 performanceFeeBps;
    uint256 managementFeeBps;
    address recipient;
}
```

### ExecuteArgs (inherited from ISuperVaultStrategy)

```solidity
/// @notice Structure for hook execution arguments
struct ExecuteArgs {
    address[] hooks;
    bytes[] hookCalldata;
    uint256[] expectedAssetsOrSharesOut;
    bytes32[][] globalProofs;
    bytes32[][] strategyProofs;
}
```

### YieldSource (inherited from ISuperVaultStrategy)

```solidity
struct YieldSource {
    address oracle;
}
```

### YieldSourceInfo (inherited from ISuperVaultStrategy)

```solidity
/// @notice Comprehensive information about a yield source including its address and configuration
struct YieldSourceInfo {
    address sourceAddress;
    address oracle;
}
```

### SuperVaultState (inherited from ISuperVaultStrategy)

```solidity
/// @notice State specific to asynchronous redeem requests
struct SuperVaultState {
    bool pendingCancelRedeemRequest;
    uint256 claimableCancelRedeemRequest;
    uint256 pendingRedeemRequest;
    uint256 maxWithdraw;
    uint256 averageRequestPPS;
    uint256 averageWithdrawPrice;
    uint16 redeemSlippageBps;
}
```

### ExecutionVars (inherited from ISuperVaultStrategy)

```solidity
struct ExecutionVars {
    bool success;
    address targetedYieldSource;
    uint256 outAmount;
    ISuperHook hookContract;
    Execution[] executions;
}
```

### FulfillRedeemVars (inherited from ISuperVaultStrategy)

```solidity
struct FulfillRedeemVars {
    uint256 totalRequestedShares;
    uint256 totalNetAssetsOut;
    uint256 currentPPS;
    uint256 strategyBalance;
}
```

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

### ReentrancyGuardStorage (inherited from ReentrancyGuardUpgradeable)

```solidity
/// @custom:storage-location erc7201:openzeppelin.storage.ReentrancyGuard
struct ReentrancyGuardStorage {
    uint256 _status;
}
```

## Errors

### ZERO_LENGTH (inherited from ISuperVaultStrategy)

```solidity
error ZERO_LENGTH();
```

### INVALID_HOOK (inherited from ISuperVaultStrategy)

```solidity
error INVALID_HOOK();
```

### ZERO_ADDRESS (inherited from ISuperVaultStrategy)

```solidity
error ZERO_ADDRESS();
```

### ACCESS_DENIED (inherited from ISuperVaultStrategy)

```solidity
error ACCESS_DENIED();
```

### INVALID_AMOUNT (inherited from ISuperVaultStrategy)

```solidity
error INVALID_AMOUNT();
```

### OPERATION_FAILED (inherited from ISuperVaultStrategy)

```solidity
error OPERATION_FAILED();
```

### INVALID_TIMESTAMP (inherited from ISuperVaultStrategy)

```solidity
error INVALID_TIMESTAMP();
```

### REQUEST_NOT_FOUND (inherited from ISuperVaultStrategy)

```solidity
error REQUEST_NOT_FOUND();
```

### INVALID_ARRAY_LENGTH (inherited from ISuperVaultStrategy)

```solidity
error INVALID_ARRAY_LENGTH();
```

### ACTION_TYPE_DISALLOWED (inherited from ISuperVaultStrategy)

```solidity
error ACTION_TYPE_DISALLOWED();
```

### YIELD_SOURCE_NOT_FOUND (inherited from ISuperVaultStrategy)

```solidity
error YIELD_SOURCE_NOT_FOUND();
```

### YIELD_SOURCE_ALREADY_EXISTS (inherited from ISuperVaultStrategy)

```solidity
error YIELD_SOURCE_ALREADY_EXISTS();
```

### INVALID_PERFORMANCE_FEE_BPS (inherited from ISuperVaultStrategy)

```solidity
error INVALID_PERFORMANCE_FEE_BPS();
```

### MINIMUM_OUTPUT_AMOUNT_ASSETS_NOT_MET (inherited from ISuperVaultStrategy)

```solidity
error MINIMUM_OUTPUT_AMOUNT_ASSETS_NOT_MET();
```

### MANAGER_NOT_AUTHORIZED (inherited from ISuperVaultStrategy)

```solidity
error MANAGER_NOT_AUTHORIZED();
```

### INVALID_PPS (inherited from ISuperVaultStrategy)

```solidity
error INVALID_PPS();
```

### INVALID_VAULT (inherited from ISuperVaultStrategy)

```solidity
error INVALID_VAULT();
```

### INVALID_ASSET (inherited from ISuperVaultStrategy)

```solidity
error INVALID_ASSET();
```

### OPERATIONS_BLOCKED_BY_VETO (inherited from ISuperVaultStrategy)

```solidity
error OPERATIONS_BLOCKED_BY_VETO();
```

### HOOK_VALIDATION_FAILED (inherited from ISuperVaultStrategy)

```solidity
error HOOK_VALIDATION_FAILED();
```

### STRATEGY_PAUSED (inherited from ISuperVaultStrategy)

```solidity
error STRATEGY_PAUSED();
```

### NO_PROPOSAL (inherited from ISuperVaultStrategy)

```solidity
error NO_PROPOSAL();
```

### INVALID_REDEEM_SLIPPAGE_BPS (inherited from ISuperVaultStrategy)

```solidity
error INVALID_REDEEM_SLIPPAGE_BPS();
```

### CANCELLATION_REDEEM_REQUEST_PENDING (inherited from ISuperVaultStrategy)

```solidity
error CANCELLATION_REDEEM_REQUEST_PENDING();
```

### STALE_PPS (inherited from ISuperVaultStrategy)

```solidity
error STALE_PPS();
```

### PPS_EXPIRED (inherited from ISuperVaultStrategy)

```solidity
error PPS_EXPIRED();
```

### INVALID_PPS_EXPIRY_THRESHOLD (inherited from ISuperVaultStrategy)

```solidity
error INVALID_PPS_EXPIRY_THRESHOLD();
```

### BOUNDS_EXCEEDED (inherited from ISuperVaultStrategy)

```solidity
error BOUNDS_EXCEEDED(uint256 minAllowed, uint256 maxAllowed, uint256 actual);
```

### INSUFFICIENT_LIQUIDITY (inherited from ISuperVaultStrategy)

```solidity
error INSUFFICIENT_LIQUIDITY();
```

### CONTROLLERS_NOT_SORTED_UNIQUE (inherited from ISuperVaultStrategy)

```solidity
error CONTROLLERS_NOT_SORTED_UNIQUE();
```

### ZERO_SHARE_FULFILLMENT_DISALLOWED (inherited from ISuperVaultStrategy)

```solidity
error ZERO_SHARE_FULFILLMENT_DISALLOWED();
```

### NOT_ENOUGH_FREE_ASSETS_FEE_SKIM (inherited from ISuperVaultStrategy)

```solidity
error NOT_ENOUGH_FREE_ASSETS_FEE_SKIM();
```

### SKIM_TIMELOCK_ACTIVE (inherited from ISuperVaultStrategy)

```solidity
error SKIM_TIMELOCK_ACTIVE();
```

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

### ReentrancyGuardReentrantCall (inherited from ReentrancyGuardUpgradeable)

```solidity
///  @dev Unauthorized reentrant call.
error ReentrancyGuardReentrantCall();
```

## Events

### SuperGovernorSet (inherited from ISuperVaultStrategy)

```solidity
event SuperGovernorSet(address indexed superGovernor);
```

### Initialized (inherited from ISuperVaultStrategy)

```solidity
event Initialized(address indexed vault);
```

### YieldSourceAdded (inherited from ISuperVaultStrategy)

```solidity
event YieldSourceAdded(address indexed source, address indexed oracle);
```

### YieldSourceOracleUpdated (inherited from ISuperVaultStrategy)

```solidity
event YieldSourceOracleUpdated(address indexed source, address indexed oldOracle, address indexed newOracle);
```

### YieldSourceRemoved (inherited from ISuperVaultStrategy)

```solidity
event YieldSourceRemoved(address indexed source);
```

### VaultFeeConfigUpdated (inherited from ISuperVaultStrategy)

```solidity
event VaultFeeConfigUpdated(uint256 performanceFeeBps, uint256 managementFeeBps, address indexed recipient);
```

### VaultFeeConfigProposed (inherited from ISuperVaultStrategy)

```solidity
event VaultFeeConfigProposed(uint256 performanceFeeBps, uint256 managementFeeBps, address indexed recipient, uint256 effectiveTime);
```

### HooksExecuted (inherited from ISuperVaultStrategy)

```solidity
event HooksExecuted(address[] hooks);
```

### RedeemRequestPlaced (inherited from ISuperVaultStrategy)

```solidity
event RedeemRequestPlaced(address indexed controller, address indexed owner, uint256 shares);
```

### RedeemRequestClaimed (inherited from ISuperVaultStrategy)

```solidity
event RedeemRequestClaimed(address indexed controller, address indexed receiver, uint256 assets, uint256 shares);
```

### RedeemRequestsFulfilled (inherited from ISuperVaultStrategy)

```solidity
event RedeemRequestsFulfilled(address[] controllers, uint256 processedShares, uint256 currentPPS);
```

### RedeemRequestCanceled (inherited from ISuperVaultStrategy)

```solidity
event RedeemRequestCanceled(address indexed controller, uint256 shares);
```

### RedeemCancelRequestPlaced (inherited from ISuperVaultStrategy)

```solidity
event RedeemCancelRequestPlaced(address indexed controller);
```

### RedeemCancelRequestFulfilled (inherited from ISuperVaultStrategy)

```solidity
event RedeemCancelRequestFulfilled(address indexed controller, uint256 shares);
```

### HookExecuted (inherited from ISuperVaultStrategy)

```solidity
event HookExecuted(address indexed hook, address indexed prevHook, address indexed targetedYieldSource, bool usePrevHookAmount, bytes hookCalldata);
```

### PPSUpdated (inherited from ISuperVaultStrategy)

```solidity
event PPSUpdated(uint256 newPPS, uint256 calculationBlock);
```

### FeeRecipientChanged (inherited from ISuperVaultStrategy)

```solidity
event FeeRecipientChanged(address indexed newRecipient);
```

### ManagementFeePaid (inherited from ISuperVaultStrategy)

```solidity
event ManagementFeePaid(address indexed controller, address indexed recipient, uint256 feeAssets, uint256 feeBps);
```

### DepositHandled (inherited from ISuperVaultStrategy)

```solidity
event DepositHandled(address indexed controller, uint256 assets, uint256 shares);
```

### RedeemClaimable (inherited from ISuperVaultStrategy)

```solidity
event RedeemClaimable(address indexed controller, uint256 assetsFulfilled, uint256 sharesFulfilled, uint256 averageWithdrawPrice);
```

### RedeemSlippageSet (inherited from ISuperVaultStrategy)

```solidity
event RedeemSlippageSet(address indexed controller, uint16 slippageBps);
```

### PPSExpirationProposed (inherited from ISuperVaultStrategy)

```solidity
event PPSExpirationProposed(uint256 currentProposedThreshold, uint256 ppsExpiration, uint256 effectiveTime);
```

### PPSExpiryThresholdUpdated (inherited from ISuperVaultStrategy)

```solidity
event PPSExpiryThresholdUpdated(uint256 ppsExpiration);
```

### PPSExpiryThresholdProposalCanceled (inherited from ISuperVaultStrategy)

```solidity
event PPSExpiryThresholdProposalCanceled();
```

### HWMPPSUpdated (inherited from ISuperVaultStrategy)

```solidity
/// @notice Emitted when the high-water mark PPS is updated after fee collection
///  @param newHwmPps The new high-water mark PPS (post-fee)
///  @param previousPps The PPS before fee collection
///  @param profit The total profit above HWM (in assets)
///  @param feeCollected The total fee collected (in assets)
event HWMPPSUpdated(uint256 newHwmPps, uint256 previousPps, uint256 profit, uint256 feeCollected);
```

### HighWaterMarkReset (inherited from ISuperVaultStrategy)

```solidity
/// @notice Emitted when the high-water mark PPS is reset
///  @param newHwmPps The new high-water mark PPS (post-fee)
event HighWaterMarkReset(uint256 newHwmPps);
```

### PerformanceFeeSkimmed (inherited from ISuperVaultStrategy)

```solidity
/// @notice Emitted when performance fees are skimmed
///  @param totalFee The total fee collected (in assets)
///  @param superformFee The fee collected for Superform (in assets)
event PerformanceFeeSkimmed(uint256 totalFee, uint256 superformFee);
```

### Initialized (inherited from Initializable)

```solidity
///  @dev Triggered when the contract has been initialized or reinitialized.
event Initialized(uint64 version);
```

## Enums

### Operation (inherited from ISuperVaultStrategy)

```solidity
enum Operation {
    RedeemRequest,
    CancelRedeemRequest,
    ClaimCancelRedeem,
    ClaimRedeem
}
```

### YieldSourceAction (inherited from ISuperVaultStrategy)

```solidity
/// @notice Action types for yield source management
enum YieldSourceAction {
    Add,
    UpdateOracle,
    Remove
}
```

### PPSExpirationAction (inherited from ISuperVaultStrategy)

```solidity
/// @notice Action types for PPS expiration threshold management
enum PPSExpirationAction {
    Propose,
    Execute,
    Cancel
}
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 4905:245:513
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address superGovernor_);
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 5285:30:513
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
/// @notice Allows the contract to receive native ETH
///  @dev Required for hooks that may send ETH back to the strategy
receive() external payable;
```

### initialize(address,struct ISuperVaultStrategy.FeeConfig)

- **Signature**: `initialize(address,struct ISuperVaultStrategy.FeeConfig)`
- **Visibility**: external
- **Source Range**: 5502:1468:513
- **Details**: [function_initialize_address_struct_ISuperVaultStrategy.FeeConfig.md](./function_initialize_address_struct_ISuperVaultStrategy.FeeConfig.md)

**Signature:**
```solidity
function initialize(address vaultAddress, FeeConfig memory feeConfigData) external initializer();
```

### handleOperations4626Deposit(address,uint256)

- **Signature**: `handleOperations4626Deposit(address,uint256)`
- **Visibility**: external
- **Source Range**: 7204:1557:513
- **Details**: [function_handleOperations4626Deposit_address_uint256.md](./function_handleOperations4626Deposit_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function handleOperations4626Deposit(address controller, uint256 assetsGross) external returns (uint256 sharesNet);
```

### handleOperations4626Mint(address,uint256,uint256,uint256)

- **Signature**: `handleOperations4626Mint(address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 8807:1191:513
- **Details**: [function_handleOperations4626Mint_address_uint256_uint256_uint256.md](./function_handleOperations4626Mint_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function handleOperations4626Mint(address controller, uint256 sharesNet, uint256 assetsGross, uint256 assetsNet) external;
```

### quoteMintAssetsGross(uint256)

- **Signature**: `quoteMintAssetsGross(uint256)`
- **Visibility**: external
- **Source Range**: 10044:683:513
- **Details**: [function_quoteMintAssetsGross_uint256.md](./function_quoteMintAssetsGross_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function quoteMintAssetsGross(uint256 shares) external view returns (uint256 assetsGross, uint256 assetsNet);
```

### handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256)

- **Signature**: `handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 10773:831:513
- **Details**: [function_handleOperations7540_enum_ISuperVaultStrategy.Operation_address_address_uint256.md](./function_handleOperations7540_enum_ISuperVaultStrategy.Operation_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function handleOperations7540(Operation operation, address controller, address receiver, uint256 amount) external;
```

### executeHooks(struct ISuperVaultStrategy.ExecuteArgs)

- **Signature**: `executeHooks(struct ISuperVaultStrategy.ExecuteArgs)`
- **Visibility**: external
- **Source Range**: 11838:1164:513
- **Details**: [function_executeHooks_struct_ISuperVaultStrategy.ExecuteArgs.md](./function_executeHooks_struct_ISuperVaultStrategy.ExecuteArgs.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function executeHooks(ExecuteArgs calldata args) external payable nonReentrant();
```

### fulfillCancelRedeemRequests(address[])

- **Signature**: `fulfillCancelRedeemRequests(address[])`
- **Visibility**: external
- **Source Range**: 13048:729:513
- **Details**: [function_fulfillCancelRedeemRequests_address[].md](./function_fulfillCancelRedeemRequests_address[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function fulfillCancelRedeemRequests(address[] memory controllers) external nonReentrant();
```

### fulfillRedeemRequests(address[],uint256[])

- **Signature**: `fulfillRedeemRequests(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 13823:2016:513
- **Details**: [function_fulfillRedeemRequests_address[]_uint256[].md](./function_fulfillRedeemRequests_address[]_uint256[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function fulfillRedeemRequests(address[] calldata controllers, uint256[] calldata totalAssetsOut) external nonReentrant();
```

### skimPerformanceFee()

- **Signature**: `skimPerformanceFee()`
- **Visibility**: external
- **Source Range**: 16079:3534:513
- **Details**: [function_skimPerformanceFee.md](./function_skimPerformanceFee.md)

**Signature:**
```solidity
/// @notice Skim performance fees based on per-share High Water Mark
///  @dev Can be called by any manager when vault PPS has grown above HWM
///  @dev Uses PPS-based HWM which eliminates redemption-related vulnerabilities
function skimPerformanceFee() external nonReentrant();
```

### manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)

- **Signature**: `manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)`
- **Visibility**: external
- **Source Range**: 19845:200:513
- **Details**: [function_manageYieldSource_address_address_enum_ISuperVaultStrategy.YieldSourceAction.md](./function_manageYieldSource_address_address_enum_ISuperVaultStrategy.YieldSourceAction.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function manageYieldSource(address source, address oracle, YieldSourceAction actionType) external;
```

### manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])

- **Signature**: `manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])`
- **Visibility**: external
- **Source Range**: 20091:580:513
- **Details**: [function_manageYieldSources_address[]_address[]_enum_ISuperVaultStrategy.YieldSourceAction[].md](./function_manageYieldSources_address[]_address[]_enum_ISuperVaultStrategy.YieldSourceAction[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function manageYieldSources(address[] calldata sources, address[] calldata oracles, YieldSourceAction[] calldata actionTypes) external;
```

### changeFeeRecipient(address)

- **Signature**: `changeFeeRecipient(address)`
- **Visibility**: external
- **Source Range**: 20717:246:513
- **Details**: [function_changeFeeRecipient_address.md](./function_changeFeeRecipient_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function changeFeeRecipient(address newRecipient) external;
```

### proposeVaultFeeConfigUpdate(uint256,uint256,address)

- **Signature**: `proposeVaultFeeConfigUpdate(uint256,uint256,address)`
- **Visibility**: external
- **Source Range**: 21009:780:513
- **Details**: [function_proposeVaultFeeConfigUpdate_uint256_uint256_address.md](./function_proposeVaultFeeConfigUpdate_uint256_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function proposeVaultFeeConfigUpdate(uint256 performanceFeeBps, uint256 managementFeeBps, address recipient) external;
```

### executeVaultFeeConfigUpdate()

- **Signature**: `executeVaultFeeConfigUpdate()`
- **Visibility**: external
- **Source Range**: 21835:841:513
- **Details**: [function_executeVaultFeeConfigUpdate.md](./function_executeVaultFeeConfigUpdate.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function executeVaultFeeConfigUpdate() external;
```

### resetHighWaterMark(uint256)

- **Signature**: `resetHighWaterMark(uint256)`
- **Visibility**: external
- **Source Range**: 22722:280:513
- **Details**: [function_resetHighWaterMark_uint256.md](./function_resetHighWaterMark_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function resetHighWaterMark(uint256 newHwmPps) external;
```

### managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)

- **Signature**: `managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)`
- **Visibility**: external
- **Source Range**: 23048:408:513
- **Details**: [function_managePPSExpiration_enum_ISuperVaultStrategy.PPSExpirationAction_uint256.md](./function_managePPSExpiration_enum_ISuperVaultStrategy.PPSExpirationAction_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function managePPSExpiration(PPSExpirationAction action, uint256 staleness_) external;
```

### setRedeemSlippage(uint16)

- **Signature**: `setRedeemSlippage(uint16)`
- **Visibility**: external
- **Source Range**: 23680:270:513
- **Details**: [function_setRedeemSlippage_uint16.md](./function_setRedeemSlippage_uint16.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function setRedeemSlippage(uint16 slippageBps) external;
```

### getVaultInfo()

- **Signature**: `getVaultInfo()`
- **Visibility**: external
- **Source Range**: 24177:202:513
- **Details**: [function_getVaultInfo.md](./function_getVaultInfo.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function getVaultInfo() external view returns (address vault, address asset, uint8 vaultDecimals);
```

### getConfigInfo()

- **Signature**: `getConfigInfo()`
- **Visibility**: external
- **Source Range**: 24425:116:513
- **Details**: [function_getConfigInfo.md](./function_getConfigInfo.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function getConfigInfo() external view returns (FeeConfig memory feeConfig_);
```

### getStoredPPS()

- **Signature**: `getStoredPPS()`
- **Visibility**: public
- **Source Range**: 24587:126:513
- **Details**: [function_getStoredPPS.md](./function_getStoredPPS.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function getStoredPPS() public view returns (uint256);
```

### getSuperVaultState(address)

- **Signature**: `getSuperVaultState(address)`
- **Visibility**: external
- **Source Range**: 24759:152:513
- **Details**: [function_getSuperVaultState_address.md](./function_getSuperVaultState_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function getSuperVaultState(address controller) external view returns (SuperVaultState memory state);
```

### getYieldSource(address)

- **Signature**: `getYieldSource(address)`
- **Visibility**: external
- **Source Range**: 24957:152:513
- **Details**: [function_getYieldSource_address.md](./function_getYieldSource_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function getYieldSource(address source) external view returns (YieldSource memory);
```

### getYieldSourcesList()

- **Signature**: `getYieldSourcesList()`
- **Visibility**: external
- **Source Range**: 25155:515:513
- **Details**: [function_getYieldSourcesList.md](./function_getYieldSourcesList.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function getYieldSourcesList() external view returns (YieldSourceInfo[] memory);
```

### getYieldSources()

- **Signature**: `getYieldSources()`
- **Visibility**: external
- **Source Range**: 25716:117:513
- **Details**: [function_getYieldSources.md](./function_getYieldSources.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function getYieldSources() external view returns (address[] memory);
```

### getYieldSourcesCount()

- **Signature**: `getYieldSourcesCount()`
- **Visibility**: external
- **Source Range**: 25879:113:513
- **Details**: [function_getYieldSourcesCount.md](./function_getYieldSourcesCount.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function getYieldSourcesCount() external view returns (uint256);
```

### vaultUnrealizedProfit()

- **Signature**: `vaultUnrealizedProfit()`
- **Visibility**: external
- **Source Range**: 26255:654:513
- **Details**: [function_vaultUnrealizedProfit.md](./function_vaultUnrealizedProfit.md)

**Signature:**
```solidity
/// @notice Get the current unrealized profit above the High Water Mark
///  @return profit Current profit above High Water Mark (in assets), 0 if no profit
///  @dev Calculates based on PPS growth: (currentPPS - hwmPPS) * totalSupply / PRECISION
function vaultUnrealizedProfit() external view returns (uint256);
```

### containsYieldSource(address)

- **Signature**: `containsYieldSource(address)`
- **Visibility**: external
- **Source Range**: 26955:131:513
- **Details**: [function_containsYieldSource_address.md](./function_containsYieldSource_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function containsYieldSource(address source) external view returns (bool);
```

### pendingRedeemRequest(address)

- **Signature**: `pendingRedeemRequest(address)`
- **Visibility**: external
- **Source Range**: 27132:168:513
- **Details**: [function_pendingRedeemRequest_address.md](./function_pendingRedeemRequest_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function pendingRedeemRequest(address controller) external view returns (uint256 pendingShares);
```

### claimableWithdraw(address)

- **Signature**: `claimableWithdraw(address)`
- **Visibility**: external
- **Source Range**: 27346:158:513
- **Details**: [function_claimableWithdraw_address.md](./function_claimableWithdraw_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function claimableWithdraw(address controller) external view returns (uint256 claimableAssets);
```

### pendingCancelRedeemRequest(address)

- **Signature**: `pendingCancelRedeemRequest(address)`
- **Visibility**: external
- **Source Range**: 27550:163:513
- **Details**: [function_pendingCancelRedeemRequest_address.md](./function_pendingCancelRedeemRequest_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function pendingCancelRedeemRequest(address controller) external view returns (bool);
```

### claimableCancelRedeemRequest(address)

- **Signature**: `claimableCancelRedeemRequest(address)`
- **Visibility**: external
- **Source Range**: 27759:265:513
- **Details**: [function_claimableCancelRedeemRequest_address.md](./function_claimableCancelRedeemRequest_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function claimableCancelRedeemRequest(address controller) external view returns (uint256 claimableShares);
```

### getAverageWithdrawPrice(address)

- **Signature**: `getAverageWithdrawPrice(address)`
- **Visibility**: external
- **Source Range**: 28070:178:513
- **Details**: [function_getAverageWithdrawPrice_address.md](./function_getAverageWithdrawPrice_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function getAverageWithdrawPrice(address controller) external view returns (uint256 averageWithdrawPrice);
```

### previewExactRedeem(address)

- **Signature**: `previewExactRedeem(address)`
- **Visibility**: external
- **Source Range**: 28294:735:513
- **Details**: [function_previewExactRedeem_address.md](./function_previewExactRedeem_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function previewExactRedeem(address controller) external view returns (uint256 shares, uint256 theoreticalAssets, uint256 minAssets);
```

### previewExactRedeemBatch(address[])

- **Signature**: `previewExactRedeemBatch(address[])`
- **Visibility**: external
- **Source Range**: 29075:704:513
- **Details**: [function_previewExactRedeemBatch_address[].md](./function_previewExactRedeemBatch_address[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultStrategy
function previewExactRedeemBatch(address[] calldata controllers) external view returns (uint256 totalTheoAssets, uint256[] memory individualAssets);
```
