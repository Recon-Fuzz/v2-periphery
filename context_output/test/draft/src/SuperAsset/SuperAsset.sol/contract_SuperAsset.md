# Contract: SuperAsset

## Metadata

- **Name**: SuperAsset
- **Type**: Contract
- **Path**: test/draft/src/SuperAsset/SuperAsset.sol
- **Documentation**: @title SuperAsset
   @author Superform Labs
   @notice A meta-vault that manages deposits and redemptions across multiple underlying vaults.
   @dev Implements ERC20 standard for better compatibility with integrators.

## Implements Interfaces

- **ISuperAsset** [test/draft/src/interfaces/SuperAsset/ISuperAsset.sol/interface_ISuperAsset.md]
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

### tokenName

```solidity
string private tokenName
```

### tokenSymbol

```solidity
string private tokenSymbol
```

### superGovernor

```solidity
ISuperGovernor private superGovernor
```

**ISuperGovernor**: [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

### superRegistry

```solidity
ISuperRegistry private superRegistry
```

**ISuperRegistry**: [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]

### factory

```solidity
ISuperAssetFactory private factory
```

**ISuperAssetFactory**: [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]

### PRECISION

```solidity
uint256 private constant PRECISION = 1e18
```

### DECIMALS

```solidity
uint256 private constant DECIMALS = 18
```

### DEPEG_LOWER_THRESHOLD

```solidity
uint256 private constant DEPEG_LOWER_THRESHOLD = 98e16
```

### DEPEG_UPPER_THRESHOLD

```solidity
uint256 private constant DEPEG_UPPER_THRESHOLD = 102e16
```

### DISPERSION_THRESHOLD

```solidity
uint256 private constant DISPERSION_THRESHOLD = 1e16
```

### SWAP_FEE_PERC

```solidity
uint256 public constant SWAP_FEE_PERC = 10 ** 6
```

### MAX_SWAP_FEE_PERC

```solidity
uint256 public constant MAX_SWAP_FEE_PERC = 10 ** 4
```

### tokenData

```solidity
mapping(address => TokenData) private tokenData
```

### _supportedAssets

```solidity
EnumerableSet.AddressSet private _supportedAssets
```

### swapFeeInPercentage

```solidity
uint256 public swapFeeInPercentage
```

### swapFeeOutPercentage

```solidity
uint256 public swapFeeOutPercentage
```

### energyToUSDExchangeRatio

```solidity
uint256 public energyToUSDExchangeRatio
```

### USD

```solidity
address private constant USD = address(840)
```

### primaryAsset

```solidity
address public primaryAsset
```

### AVERAGE_PROVIDER

```solidity
bytes32 private constant AVERAGE_PROVIDER = keccak256("AVERAGE_PROVIDER")
```

## Structs

### TokenData (inherited from ISuperAsset)

```solidity
/// @notice Token data structure
///  @param isSupportedUnderlyingVault Whether the token is a supported underlying vault
///  @param isSupportedERC20 Whether the token is a supported ERC20
///  @param oracle Address of the oracle to use to fetch token prices
///  @param targetAllocations Target allocations for the token
///  @param weights Weights for the token
struct TokenData {
    bool isSupportedUnderlyingVault;
    bool isSupportedERC20;
    bool isActive;
    address oracle;
    uint256 targetAllocations;
    uint256 weights;
}
```

### GetAllocationsPrePostOperationsDeposit (inherited from ISuperAsset)

```solidity
/// @notice Structure used for getting allocations pre and post operations
///  @param length Length of the array
///  @param extendedLength Extended length of the array
///  @param extraSlot Extra slot for the array
///  @param token Address of the token
///  @param priceUSD Price of the token in USD
///  @param isDepeg Whether the token is depegged
///  @param isDispersion Whether the token is dispersed
///  @param isOracleOff Whether the oracle is off
///  @param balance Balance of the token
///  @param absDeltaValue Absolute delta value
///  @param deltaValue Delta value
///  @notice Struct for deposit operations when calculating allocations
///  @param extendedLength Length of supported assets array
///  @param token Current token being processed
///  @param priceUSD Price of token in USD
///  @param balance Balance of token
///  @param absDeltaValue Absolute delta value for deposit calculation
///  @param deltaValue Signed delta value for deposit calculation
///  @param totalValueUSD Total value in USD of all assets
///  @param priceUSDToken Price of the specific token in USD
struct GetAllocationsPrePostOperationsDeposit {
    uint256 extendedLength;
    address token;
    uint256 priceUSD;
    uint256 balance;
    uint256 absDeltaValue;
    int256 deltaValue;
    uint256 totalValueUSD;
    uint256 priceUSDToken;
}
```

### GetAllocationsPrePostOperationsRedeem (inherited from ISuperAsset)

```solidity
/// @notice Struct for redeem operations when calculating allocations
///  @param extendedLength Length of supported assets array
///  @param token Current token being processed
///  @param deltaToken Amount of token to redeem (calculated from shares)
///  @param totalValueUSD Total value in USD of all assets
///  @param priceUSDToken Price of the specific token in USD
///  @param oraclePriceUSDs Array of oracle prices in USD
///  @param balances Array of balances
///  @param decimals Array of token decimals
///  @param isDepegs Array of depeg flags
///  @param isDispersions Array of dispersion flags
///  @param isOracleOffs Array of oracle off flags
///  @param superAssetPPS Price per share of the SuperAsset
///  @param decimalsToken Decimals of the output token
///  @param balanceOfDeltaToken Balance of the token being redeemed
///  @param absDeltaValue Absolute delta value
///  @param deltaValue Signed delta value
struct GetAllocationsPrePostOperationsRedeem {
    uint256 extendedLength;
    address token;
    uint256 deltaToken;
    uint256 totalValueUSD;
    uint256 priceUSDToken;
    uint256[] oraclePriceUSDs;
    uint256[] balances;
    uint256[] decimals;
    bool[] isDepegs;
    bool[] isDispersions;
    bool[] isOracleOffs;
    uint256 superAssetPPS;
    uint8 decimalsToken;
    uint256 balanceOfDeltaToken;
    uint256 absDeltaValue;
    int256 deltaValue;
}
```

### GetPrePostAllocationReturnValues (inherited from ISuperAsset)

```solidity
/// @notice Structure used for getting allocations pre and post operations
///  @param absoluteAllocationPreOperation Array of pre-operation absolute allocations
///  @param totalAllocationPreOperation Sum of all pre-operation allocations
///  @param absoluteAllocationPostOperation Array of post-operation absolute allocations
///  @param totalAllocationPostOperation Sum of all post-operation allocations
///  @param absoluteTargetAllocation Array of target absolute allocations
///  @param totalTargetAllocation Sum of all target allocations
///  @param vaultWeights Array of vault weights
struct GetPrePostAllocationReturnValues {
    uint256[] absoluteAllocationPreOperation;
    uint256 totalAllocationPreOperation;
    uint256[] absoluteAllocationPostOperation;
    uint256 totalAllocationPostOperation;
    uint256[] absoluteTargetAllocation;
    uint256 totalTargetAllocation;
    uint256[] vaultWeights;
}
```

### PreviewDeposit (inherited from ISuperAsset)

```solidity
/// @notice Structure used for previewing deposit
///  @param allocations GetPrePostAllocationReturnValues structure
///  @param amountTokenInAfterFees Amount of token in after fees
///  @param priceUSDTokenIn Price of token in in USD
///  @param priceUSDSuperAssetShares Price of SuperAsset shares in USD
struct PreviewDeposit {
    GetPrePostAllocationReturnValues allocations;
    uint256 amountTokenInAfterFees;
    uint256 priceUSDTokenIn;
    uint256 priceUSDSuperAssetShares;
}
```

### PreviewRedeem (inherited from ISuperAsset)

```solidity
/// @notice Structure used for previewing redeem
///  @param allocations GetPrePostAllocationReturnValues structure
///  @param priceUSDSuperAssetShares Price of SuperAsset shares in USD
///  @param priceUSDTokenOut Price of token out in USD
///  @param amountTokenOutBeforeFees Amount of token out before fees
struct PreviewRedeem {
    GetPrePostAllocationReturnValues allocations;
    uint256 priceUSDSuperAssetShares;
    uint256 priceUSDTokenOut;
    uint256 amountTokenOutBeforeFees;
}
```

### DepositReturnVars (inherited from ISuperAsset)

```solidity
/// @notice Structure to store deposit operation results to avoid stack too deep
///  @param amountSharesMinted Amount of SuperUSD shares minted
///  @param swapFee Amount of swap fee paid
///  @param amountIncentiveUSDDeposit Amount of incentives paid in USD
struct DepositReturnVars {
    uint256 amountSharesMinted;
    uint256 swapFee;
    int256 amountIncentiveUSDDeposit;
}
```

### RedeemReturnVars (inherited from ISuperAsset)

```solidity
/// @notice Structure to store redeem operation results to avoid stack too deep
///  @param amountTokenOutAfterFees Amount of the output asset received after fees
///  @param swapFee Amount of swap fee paid
///  @param amountIncentiveUSDRedeem Amount of incentives paid in USD
struct RedeemReturnVars {
    uint256 amountTokenOutAfterFees;
    uint256 swapFee;
    int256 amountIncentiveUSDRedeem;
}
```

### DepositArgs (inherited from ISuperAsset)

```solidity
/// @notice Structure to store deposit function arguments to avoid stack too deep
///  @param receiver Address to receive the minted tokens
///  @param tokenIn Address of the token to deposit
///  @param amountTokenToDeposit Amount of token to deposit
///  @param minSharesOut Minimum amount of shares to receive (slippage protection)
struct DepositArgs {
    address receiver;
    address tokenIn;
    uint256 amountTokenToDeposit;
    uint256 minSharesOut;
}
```

### RedeemArgs (inherited from ISuperAsset)

```solidity
/// @notice Structure to store redeem function arguments to avoid stack too deep
///  @param receiver Address to receive the redeemed tokens
///  @param amountSharesToRedeem Amount of shares to redeem
///  @param tokenOut Address of the token to redeem to
///  @param minTokenOut Minimum amount of tokens to receive (slippage protection)
struct RedeemArgs {
    address receiver;
    uint256 amountSharesToRedeem;
    address tokenOut;
    uint256 minTokenOut;
}
```

### SwapArgs (inherited from ISuperAsset)

```solidity
/// @notice Structure to store swap function arguments to avoid stack too deep
///  @param receiver Address to receive the output tokens
///  @param tokenIn Address of the token to swap from
///  @param amountTokenToDeposit Amount of token to deposit
///  @param tokenOut Address of the token to swap to
///  @param minTokenOut Minimum amount of tokens to receive (slippage protection)
struct SwapArgs {
    address receiver;
    address tokenIn;
    uint256 amountTokenToDeposit;
    address tokenOut;
    uint256 minTokenOut;
}
```

### SwapReturnVars (inherited from ISuperAsset)

```solidity
/// @notice Structure to store swap operation results to avoid stack too deep
///  @param amountSharesIntermediateStep Amount of shares minted in the intermediate step
///  @param amountTokenOutAfterFees Amount of tokens received after fees
///  @param swapFeeIn Amount of swap fee paid for deposit
///  @param swapFeeOut Amount of swap fee paid for redeem
///  @param amountIncentivesIn Amount of incentives paid for deposit
///  @param amountIncentivesOut Amount of incentives paid for redeem
struct SwapReturnVars {
    uint256 amountSharesIntermediateStep;
    uint256 amountTokenOutAfterFees;
    uint256 swapFeeIn;
    uint256 swapFeeOut;
    int256 amountIncentivesIn;
    int256 amountIncentivesOut;
}
```

### PreviewSwapArgs (inherited from ISuperAsset)

```solidity
/// @notice Structure to store preview swap function arguments to avoid stack too deep
///  @param tokenIn Address of the token to swap from
///  @param amountTokenToDeposit Amount of token to deposit
///  @param tokenOut Address of the token to swap to
///  @param isSoft Whether to use soft or strict checks
struct PreviewSwapArgs {
    address tokenIn;
    uint256 amountTokenToDeposit;
    address tokenOut;
    bool isSoft;
}
```

### PreviewSwapReturnVars (inherited from ISuperAsset)

```solidity
/// @notice Structure to store preview swap operation results to avoid stack too deep
///  @param amountTokenOutAfterFees Amount of tokens received after fees
///  @param swapFeeIn Amount of swap fee paid for deposit
///  @param swapFeeOut Amount of swap fee paid for redeem
///  @param amountIncentiveUSDDeposit Amount of incentives paid for deposit
///  @param amountIncentiveUSDRedeem Amount of incentives paid for redeem
///  @param assetWithBreakerTriggered The asset that triggered a circuit breaker (if any)
///  @param oraclePriceUSD The oracle price in USD
///  @param isDepeg Whether the asset is depegged
///  @param isDispersion Whether the asset has price dispersion
///  @param isOracleOff Whether the oracle is off
///  @param tokenInFound Whether the token was found
///  @param incentiveCalculationSuccess Whether incentive calculation succeeded
struct PreviewSwapReturnVars {
    uint256 amountTokenOutAfterFees;
    uint256 swapFeeIn;
    uint256 swapFeeOut;
    int256 amountIncentiveUSDDeposit;
    int256 amountIncentiveUSDRedeem;
    address assetWithBreakerTriggered;
    uint256 oraclePriceUSD;
    bool isDepeg;
    bool isDispersion;
    bool isOracleOff;
    bool tokenInFound;
    bool incentiveCalculationSuccess;
}
```

### AllocationOperationReturnVars (inherited from ISuperAsset)

```solidity
/// @notice Return values for allocation operations used in deposit and redeem functions
struct AllocationOperationReturnVars {
    uint256[] absoluteAllocationPreOperation;
    uint256 totalAllocationPreOperation;
    uint256[] absoluteAllocationPostOperation;
    uint256 totalAllocationPostOperation;
    uint256[] absoluteTargetAllocation;
    uint256 totalTargetAllocation;
    uint256[] vaultWeights;
    uint256 amountAssets;
    address assetWithBreakerTriggered;
    uint256 oraclePriceUSD;
    bool isDepeg;
    bool isDispersion;
    bool isOracleOff;
    bool tokenFound;
}
```

### PreviewDepositArgs (inherited from ISuperAsset)

```solidity
/// @notice Structure to store preview deposit function arguments to avoid stack too deep
///  @param tokenIn Address of the token to deposit
///  @param amountTokenToDeposit Amount of token to deposit
///  @param isSoft Whether to use soft or strict checks
struct PreviewDepositArgs {
    address tokenIn;
    uint256 amountTokenToDeposit;
    bool isSoft;
}
```

### PreviewDepositReturnVars (inherited from ISuperAsset)

```solidity
/// @notice Structure to store preview deposit operation results to avoid stack too deep
///  @param amountSharesMinted Amount of shares minted
///  @param swapFee Amount of swap fee paid
///  @param amountIncentiveUSDDeposit Amount of incentives paid
///  @param assetWithBreakerTriggered The asset that triggered a circuit breaker (if any)
///  @param oraclePriceUSD The oracle price in USD
///  @param isDepeg Whether the asset is depegged
///  @param isDispersion Whether the asset has price dispersion
///  @param isOracleOff Whether the oracle is off
///  @param tokenInFound Whether the token was found
///  @param incentiveCalculationSuccess Whether incentive calculation succeeded
struct PreviewDepositReturnVars {
    uint256 amountSharesMinted;
    uint256 swapFee;
    int256 amountIncentiveUSDDeposit;
    address assetWithBreakerTriggered;
    uint256 oraclePriceUSD;
    bool isDepeg;
    bool isDispersion;
    bool isOracleOff;
    bool tokenInFound;
    bool incentiveCalculationSuccess;
}
```

### PreviewRedeemArgs (inherited from ISuperAsset)

```solidity
/// @notice Structure to store preview redeem function arguments to avoid stack too deep
///  @param tokenOut Address of the token to redeem to
///  @param amountSharesToRedeem Amount of shares to redeem
///  @param isSoft Whether to use soft or strict checks
struct PreviewRedeemArgs {
    address tokenOut;
    uint256 amountSharesToRedeem;
    bool isSoft;
}
```

### PreviewRedeemReturnVars (inherited from ISuperAsset)

```solidity
/// @notice Structure to store preview redeem operation results to avoid stack too deep
///  @param amountTokenOutAfterFees Amount of tokens received after fees
///  @param swapFee Amount of swap fee paid
///  @param amountIncentiveUSDRedeem Amount of incentives paid
///  @param assetWithBreakerTriggered The asset that triggered a circuit breaker (if any)
///  @param oraclePriceUSD The oracle price in USD
///  @param isDepeg Whether the asset is depegged
///  @param isDispersion Whether the asset has price dispersion
///  @param isOracleOff Whether the oracle is off
///  @param tokenOutFound Whether the token was found
///  @param incentiveCalculationSuccess Whether incentive calculation succeeded
struct PreviewRedeemReturnVars {
    uint256 amountTokenOutAfterFees;
    uint256 swapFee;
    int256 amountIncentiveUSDRedeem;
    address assetWithBreakerTriggered;
    uint256 oraclePriceUSD;
    bool isDepeg;
    bool isDispersion;
    bool isOracleOff;
    bool tokenOutFound;
    bool incentiveCalculationSuccess;
}
```

### PriceArgs (inherited from ISuperAsset)

```solidity
struct PriceArgs {
    address superOracle;
    address superAsset;
    address token;
    address usd;
    uint256 depegLowerThreshold;
    uint256 depegUpperThreshold;
    uint256 dispersionThreshold;
}
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

### ZERO_ADDRESS (inherited from ISuperAsset)

```solidity
/// @notice Thrown when an address parameter is zero
error ZERO_ADDRESS();
```

### NOT_ERC20_TOKEN (inherited from ISuperAsset)

```solidity
/// @notice Thrown when token is not in the ERC20 whitelist
error NOT_ERC20_TOKEN();
```

### NOT_SUPPORTED_TOKEN (inherited from ISuperAsset)

```solidity
/// @notice Thrown when a token is not supported (neither vault nor ERC20)
error NOT_SUPPORTED_TOKEN();
```

### NOT_VAULT (inherited from ISuperAsset)

```solidity
/// @notice Thrown when vault is not in the vault whitelist
error NOT_VAULT();
```

### ALREADY_WHITELISTED (inherited from ISuperAsset)

```solidity
/// @notice Thrown when vault is already whitelisted
error ALREADY_WHITELISTED();
```

### ALREADY_INITIALIZED (inherited from ISuperAsset)

```solidity
/// @notice Thrown when contract is already initialized
error ALREADY_INITIALIZED();
```

### NOT_WHITELISTED (inherited from ISuperAsset)

```solidity
/// @notice Thrown when vault or token is not whitelisted
error NOT_WHITELISTED();
```

### INVALID_SWAP_FEE_PERCENTAGE (inherited from ISuperAsset)

```solidity
/// @notice Thrown when swap fee percentage is too high
error INVALID_SWAP_FEE_PERCENTAGE();
```

### ZERO_AMOUNT (inherited from ISuperAsset)

```solidity
/// @notice Thrown when amount is zero
error ZERO_AMOUNT();
```

### INSUFFICIENT_BALANCE (inherited from ISuperAsset)

```solidity
/// @notice Thrown when insufficient balance for operation
error INSUFFICIENT_BALANCE();
```

### INSUFFICIENT_ALLOWANCE (inherited from ISuperAsset)

```solidity
/// @notice Thrown when insufficient allowance for transfer
error INSUFFICIENT_ALLOWANCE();
```

### SLIPPAGE_PROTECTION (inherited from ISuperAsset)

```solidity
/// @notice Thrown when slippage tolerance is exceeded
error SLIPPAGE_PROTECTION();
```

### INVALID_ORACLE_PRICE (inherited from ISuperAsset)

```solidity
/// @notice Thrown when oracle price is invalid
error INVALID_ORACLE_PRICE();
```

### INVALID_ALLOCATION (inherited from ISuperAsset)

```solidity
/// @notice Thrown when allocation is invalid
error INVALID_ALLOCATION();
```

### TOKEN_NOT_FOUND (inherited from ISuperAsset)

```solidity
/// @notice Thrown when token not found
error TOKEN_NOT_FOUND();
```

### TOKEN_NOT_SUPPORTED (inherited from ISuperAsset)

```solidity
/// @notice Thrown when token not supported
error TOKEN_NOT_SUPPORTED();
```

### TOKEN_ALREADY_ACTIVE (inherited from ISuperAsset)

```solidity
/// @notice Thrown when attempting to activate an already active token
error TOKEN_ALREADY_ACTIVE();
```

### TOKEN_NOT_ACTIVE (inherited from ISuperAsset)

```solidity
/// @notice Thrown when attempting to use an inactive token
error TOKEN_NOT_ACTIVE();
```

### VAULT_NOT_SUPPORTED (inherited from ISuperAsset)

```solidity
/// @notice Thrown when vault is not supported
error VAULT_NOT_SUPPORTED();
```

### UNAUTHORIZED (inherited from ISuperAsset)

```solidity
/// @notice Thrown when caller is not authorized
error UNAUTHORIZED();
```

### INVALID_OPERATION (inherited from ISuperAsset)

```solidity
/// @notice Thrown when operation would result in invalid state
error INVALID_OPERATION();
```

### INVALID_INPUT (inherited from ISuperAsset)

```solidity
/// @notice Thrown when input arrays have mismatched lengths in batch operations
error INVALID_INPUT();
```

### INVALID_TOTAL_ALLOCATION (inherited from ISuperAsset)

```solidity
/// @notice Thrown when the sum of all allocations exceeds 100% (PRECISION)
error INVALID_TOTAL_ALLOCATION();
```

### PRICE_USD_ZERO (inherited from ISuperAsset)

```solidity
/// @notice Thrown when price in USD is zero
error PRICE_USD_ZERO();
```

### SUPPORTED_ASSET_PRICE_ORACLE_OFF (inherited from ISuperAsset)

```solidity
/// @notice Thrown when a supported asset price is oracle off
error SUPPORTED_ASSET_PRICE_ORACLE_OFF(address assetWithBreakerTriggered);
```

### SUPPORTED_ASSET_PRICE_DEPEG (inherited from ISuperAsset)

```solidity
/// @notice Thrown when a supported asset price is depegged
error SUPPORTED_ASSET_PRICE_DEPEG(address assetWithBreakerTriggered);
```

### SUPPORTED_ASSET_PRICE_DISPERSION (inherited from ISuperAsset)

```solidity
/// @notice Thrown when a supported asset price is dispersed
error SUPPORTED_ASSET_PRICE_DISPERSION(address assetWithBreakerTriggered);
```

### SUPPORTED_ASSET_PRICE_ZERO (inherited from ISuperAsset)

```solidity
/// @notice Thrown when a supported asset price is 0
error SUPPORTED_ASSET_PRICE_ZERO(address assetWithBreakerTriggered);
```

### INCENTIVE_CALCULATION_FAILED (inherited from ISuperAsset)

```solidity
/// @notice Thrown when incentive calculation fails (only if totalSupply != 0)
error INCENTIVE_CALCULATION_FAILED();
```

### REDEEM_FAILED (inherited from ISuperAsset)

```solidity
/// @notice Thrown when redeem fails
error REDEEM_FAILED();
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

### Deposit (inherited from ISuperAsset)

```solidity
event Deposit(address indexed receiver, address indexed tokenIn, uint256 amountTokenToDeposit, uint256 amountSharesOut, uint256 swapFee, int256 amountIncentives);
```

### Redeem (inherited from ISuperAsset)

```solidity
event Redeem(address indexed receiver, address indexed tokenOut, uint256 amountSharesToRedeem, uint256 amountTokenOut, uint256 swapFee, int256 amountIncentives);
```

### Swap (inherited from ISuperAsset)

```solidity
event Swap(address indexed receiver, address indexed tokenIn, uint256 amountTokenToDeposit, address indexed tokenOut, uint256 amountSharesIntermediateStep, uint256 amountTokenOutAfterFees, uint256 swapFeeIn, uint256 swapFeeOut, int256 amountIncentivesIn, int256 amountIncentivesOut);
```

### VaultWhitelisted (inherited from ISuperAsset)

```solidity
event VaultWhitelisted(address indexed vault);
```

### VaultRemoved (inherited from ISuperAsset)

```solidity
event VaultRemoved(address indexed vault);
```

### VaultActivated (inherited from ISuperAsset)

```solidity
event VaultActivated(address indexed vault);
```

### ERC20Whitelisted (inherited from ISuperAsset)

```solidity
event ERC20Whitelisted(address indexed token);
```

### ERC20Removed (inherited from ISuperAsset)

```solidity
event ERC20Removed(address indexed token);
```

### ERC20Activated (inherited from ISuperAsset)

```solidity
event ERC20Activated(address indexed token);
```

### SettlementTokenInSet (inherited from ISuperAsset)

```solidity
event SettlementTokenInSet(address indexed token);
```

### SettlementTokenOutSet (inherited from ISuperAsset)

```solidity
event SettlementTokenOutSet(address indexed token);
```

### SuperOracleSet (inherited from ISuperAsset)

```solidity
event SuperOracleSet(address indexed oracle);
```

### TargetAllocationSet (inherited from ISuperAsset)

```solidity
event TargetAllocationSet(address indexed token, uint256 allocation);
```

### EnergyToUSDExchangeRatioSet (inherited from ISuperAsset)

```solidity
event EnergyToUSDExchangeRatioSet(uint256 newRatio);
```

### WeightSet (inherited from ISuperAsset)

```solidity
event WeightSet(address indexed vault, uint256 weight);
```

## Public/External Functions

### constructor()

- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 3147:31:548
- **Details**: [function_constructor.md](./function_constructor.md)

**Signature:**
```solidity
constructor() ERC20("","");
```

### initialize(string,string,address,address,address,uint256,uint256)

- **Signature**: `initialize(string,string,address,address,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3216:1046:548
- **Details**: [function_initialize_string_string_address_address_address_uint256_uint256.md](./function_initialize_string_string_address_address_address_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function initialize(string memory name_, string memory symbol_, address asset, address superGovernor_, address superRegistry_, uint256 swapFeeInPercentage_, uint256 swapFeeOutPercentage_) external;
```

### whitelistERC20(address)

- **Signature**: `whitelistERC20(address)`
- **Visibility**: external
- **Source Range**: 4484:517:548
- **Details**: [function_whitelistERC20_address.md](./function_whitelistERC20_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function whitelistERC20(address token) external;
```

### removeERC20(address)

- **Signature**: `removeERC20(address)`
- **Visibility**: external
- **Source Range**: 5039:562:548
- **Details**: [function_removeERC20_address.md](./function_removeERC20_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function removeERC20(address token) external;
```

### activateERC20(address)

- **Signature**: `activateERC20(address)`
- **Visibility**: external
- **Source Range**: 5639:394:548
- **Details**: [function_activateERC20_address.md](./function_activateERC20_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function activateERC20(address token) external;
```

### whitelistVault(address,address)

- **Signature**: `whitelistVault(address,address)`
- **Visibility**: external
- **Source Range**: 6071:562:548
- **Details**: [function_whitelistVault_address_address.md](./function_whitelistVault_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function whitelistVault(address vault, address yieldSourceOracle) external;
```

### removeVault(address)

- **Signature**: `removeVault(address)`
- **Visibility**: external
- **Source Range**: 6671:572:548
- **Details**: [function_removeVault_address.md](./function_removeVault_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function removeVault(address vault) external;
```

### activateVault(address)

- **Signature**: `activateVault(address)`
- **Visibility**: external
- **Source Range**: 7281:404:548
- **Details**: [function_activateVault_address.md](./function_activateVault_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function activateVault(address vault) external;
```

### setSwapFeeInPercentage(uint256)

- **Signature**: `setSwapFeeInPercentage(uint256)`
- **Visibility**: external
- **Source Range**: 7723:228:548
- **Details**: [function_setSwapFeeInPercentage_uint256.md](./function_setSwapFeeInPercentage_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function setSwapFeeInPercentage(uint256 _feePercentage) external;
```

### setSwapFeeOutPercentage(uint256)

- **Signature**: `setSwapFeeOutPercentage(uint256)`
- **Visibility**: external
- **Source Range**: 7989:230:548
- **Details**: [function_setSwapFeeOutPercentage_uint256.md](./function_setSwapFeeOutPercentage_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function setSwapFeeOutPercentage(uint256 _feePercentage) external;
```

### setWeight(address,uint256)

- **Signature**: `setWeight(address,uint256)`
- **Visibility**: external
- **Source Range**: 8257:378:548
- **Details**: [function_setWeight_address_uint256.md](./function_setWeight_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function setWeight(address vault, uint256 weight) external;
```

### setEnergyToUSDExchangeRatio(uint256)

- **Signature**: `setEnergyToUSDExchangeRatio(uint256)`
- **Visibility**: external
- **Source Range**: 8673:192:548
- **Details**: [function_setEnergyToUSDExchangeRatio_uint256.md](./function_setEnergyToUSDExchangeRatio_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function setEnergyToUSDExchangeRatio(uint256 newRatio) external;
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 8903:109:548
- **Details**: [function_mint_address_uint256.md](./function_mint_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function mint(address to, uint256 amount) external;
```

### burn(address,uint256)

- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 9050:113:548
- **Details**: [function_burn_address_uint256.md](./function_burn_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function burn(address from, uint256 amount) external;
```

### setTargetAllocations(address[],uint256[])

- **Signature**: `setTargetAllocations(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 9386:726:548
- **Details**: [function_setTargetAllocations_address[]_uint256[].md](./function_setTargetAllocations_address[]_uint256[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function setTargetAllocations(address[] calldata tokens, uint256[] calldata allocations) external;
```

### setTargetAllocation(address,uint256)

- **Signature**: `setTargetAllocation(address,uint256)`
- **Visibility**: external
- **Source Range**: 10150:524:548
- **Details**: [function_setTargetAllocation_address_uint256.md](./function_setTargetAllocation_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function setTargetAllocation(address token, uint256 allocation) external;
```

### deposit(struct ISuperAsset.DepositArgs)

- **Signature**: `deposit(struct ISuperAsset.DepositArgs)`
- **Visibility**: public
- **Source Range**: 10897:3172:548
- **Details**: [function_deposit_struct_ISuperAsset.DepositArgs.md](./function_deposit_struct_ISuperAsset.DepositArgs.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function deposit(DepositArgs memory args) public returns (DepositReturnVars memory ret);
```

### redeem(struct ISuperAsset.RedeemArgs)

- **Signature**: `redeem(struct ISuperAsset.RedeemArgs)`
- **Visibility**: public
- **Source Range**: 14107:4040:548
- **Details**: [function_redeem_struct_ISuperAsset.RedeemArgs.md](./function_redeem_struct_ISuperAsset.RedeemArgs.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function redeem(RedeemArgs memory args) public returns (RedeemReturnVars memory ret);
```

### swap(struct ISuperAsset.SwapArgs)

- **Signature**: `swap(struct ISuperAsset.SwapArgs)`
- **Visibility**: external
- **Source Range**: 18185:1726:548
- **Details**: [function_swap_struct_ISuperAsset.SwapArgs.md](./function_swap_struct_ISuperAsset.SwapArgs.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function swap(SwapArgs memory args) external returns (SwapReturnVars memory ret);
```

### previewDeposit(struct ISuperAsset.PreviewDepositArgs)

- **Signature**: `previewDeposit(struct ISuperAsset.PreviewDepositArgs)`
- **Visibility**: public
- **Source Range**: 20133:2454:548
- **Details**: [function_previewDeposit_struct_ISuperAsset.PreviewDepositArgs.md](./function_previewDeposit_struct_ISuperAsset.PreviewDepositArgs.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function previewDeposit(PreviewDepositArgs memory args) public view returns (PreviewDepositReturnVars memory ret);
```

### previewRedeem(struct ISuperAsset.PreviewRedeemArgs)

- **Signature**: `previewRedeem(struct ISuperAsset.PreviewRedeemArgs)`
- **Visibility**: public
- **Source Range**: 22625:2351:548
- **Details**: [function_previewRedeem_struct_ISuperAsset.PreviewRedeemArgs.md](./function_previewRedeem_struct_ISuperAsset.PreviewRedeemArgs.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function previewRedeem(PreviewRedeemArgs memory args) public view returns (PreviewRedeemReturnVars memory ret);
```

### previewSwap(struct ISuperAsset.PreviewSwapArgs)

- **Signature**: `previewSwap(struct ISuperAsset.PreviewSwapArgs)`
- **Visibility**: external
- **Source Range**: 25014:2675:548
- **Details**: [function_previewSwap_struct_ISuperAsset.PreviewSwapArgs.md](./function_previewSwap_struct_ISuperAsset.PreviewSwapArgs.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function previewSwap(PreviewSwapArgs memory args) external view returns (PreviewSwapReturnVars memory ret);
```

### getTokenData(address)

- **Signature**: `getTokenData(address)`
- **Visibility**: external
- **Source Range**: 27915:118:548
- **Details**: [function_getTokenData_address.md](./function_getTokenData_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function getTokenData(address token) external view returns (TokenData memory);
```

### getPrecision()

- **Signature**: `getPrecision()`
- **Visibility**: external
- **Source Range**: 28071:89:548
- **Details**: [function_getPrecision.md](./function_getPrecision.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function getPrecision() external pure returns (uint256);
```

### getPriceAndCircuitBreakers(address)

- **Signature**: `getPriceAndCircuitBreakers(address)`
- **Visibility**: public
- **Source Range**: 28384:707:548
- **Details**: [function_getPriceAndCircuitBreakers_address.md](./function_getPriceAndCircuitBreakers_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function getPriceAndCircuitBreakers(address token) public view returns (uint256 priceUSD, bool isDepeg, bool isDispersion, bool isOracleOff);
```

### getSuperAssetPPS()

- **Signature**: `getSuperAssetPPS()`
- **Visibility**: external
- **Source Range**: 29129:1585:548
- **Details**: [function_getSuperAssetPPS.md](./function_getSuperAssetPPS.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function getSuperAssetPPS() external view returns (address[] memory activeTokens, uint256[] memory pricePerTokenUSD, bool[] memory isDepeg, bool[] memory isDispersion, bool[] memory isOracleOff, uint256 pps);
```

### getAllocations()

- **Signature**: `getAllocations()`
- **Visibility**: external
- **Source Range**: 30752:861:548
- **Details**: [function_getAllocations.md](./function_getAllocations.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function getAllocations() external view returns (uint256[] memory absoluteCurrentAllocation, uint256 totalCurrentAllocation, uint256[] memory absoluteTargetAllocation, uint256 totalTargetAllocation);
```

### getAllocationsPrePostOperationDeposit(address,uint256,uint256,bool)

- **Signature**: `getAllocationsPrePostOperationDeposit(address,uint256,uint256,bool)`
- **Visibility**: public
- **Source Range**: 31651:3481:548
- **Details**: [function_getAllocationsPrePostOperationDeposit_address_uint256_uint256_bool.md](./function_getAllocationsPrePostOperationDeposit_address_uint256_uint256_bool.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function getAllocationsPrePostOperationDeposit(address token, uint256 deltaToken, uint256 amountToken, bool isSoft) public view returns (ISuperAsset.AllocationOperationReturnVars memory ret);
```

### getAllocationsPrePostOperationRedeem(address,uint256,bool)

- **Signature**: `getAllocationsPrePostOperationRedeem(address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 35170:5487:548
- **Details**: [function_getAllocationsPrePostOperationRedeem_address_uint256_bool.md](./function_getAllocationsPrePostOperationRedeem_address_uint256_bool.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function getAllocationsPrePostOperationRedeem(address token, uint256 amountToken, bool isSoft) public view returns (ISuperAsset.AllocationOperationReturnVars memory ret);
```

### getPrimaryAsset()

- **Signature**: `getPrimaryAsset()`
- **Visibility**: external
- **Source Range**: 40695:95:548
- **Details**: [function_getPrimaryAsset.md](./function_getPrimaryAsset.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAsset
function getPrimaryAsset() external view returns (address);
```

### name()

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 41005:94:548
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
/// @inheritdoc ERC20
function name() override public view returns (string memory);
```

### symbol()

- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 41131:98:548
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
/// @inheritdoc ERC20
function symbol() override public view returns (string memory);
```

### decimals() (inherited from ERC20)

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 2688:82:267
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
