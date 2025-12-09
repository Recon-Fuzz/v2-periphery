# Interface: ISuperAsset

## Metadata

- **Name**: ISuperAsset
- **Type**: Interface
- **Path**: test/draft/src/interfaces/SuperAsset/ISuperAsset.sol
- **Documentation**: @title ISuperAsset
   @notice Interface for SuperAsset contract which manages deposits and redemptions across multiple
   underlying vaults. It implements ERC20 standard and provides functionality for asset management,
   fee handling, and incentive calculations.

## Implements Interfaces

- **IERC20** [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Structs

### TokenData

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

### GetAllocationsPrePostOperationsDeposit

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

### GetAllocationsPrePostOperationsRedeem

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

### GetPrePostAllocationReturnValues

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

### PreviewDeposit

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

### PreviewRedeem

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

### DepositReturnVars

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

### RedeemReturnVars

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

### DepositArgs

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

### RedeemArgs

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

### SwapArgs

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

### SwapReturnVars

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

### PreviewSwapArgs

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

### PreviewSwapReturnVars

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

### AllocationOperationReturnVars

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

### PreviewDepositArgs

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

### PreviewDepositReturnVars

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

### PreviewRedeemArgs

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

### PreviewRedeemReturnVars

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

### PriceArgs

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

### ZERO_ADDRESS

```solidity
/// @notice Thrown when an address parameter is zero
error ZERO_ADDRESS();
```

### NOT_ERC20_TOKEN

```solidity
/// @notice Thrown when token is not in the ERC20 whitelist
error NOT_ERC20_TOKEN();
```

### NOT_SUPPORTED_TOKEN

```solidity
/// @notice Thrown when a token is not supported (neither vault nor ERC20)
error NOT_SUPPORTED_TOKEN();
```

### NOT_VAULT

```solidity
/// @notice Thrown when vault is not in the vault whitelist
error NOT_VAULT();
```

### ALREADY_WHITELISTED

```solidity
/// @notice Thrown when vault is already whitelisted
error ALREADY_WHITELISTED();
```

### ALREADY_INITIALIZED

```solidity
/// @notice Thrown when contract is already initialized
error ALREADY_INITIALIZED();
```

### NOT_WHITELISTED

```solidity
/// @notice Thrown when vault or token is not whitelisted
error NOT_WHITELISTED();
```

### INVALID_SWAP_FEE_PERCENTAGE

```solidity
/// @notice Thrown when swap fee percentage is too high
error INVALID_SWAP_FEE_PERCENTAGE();
```

### ZERO_AMOUNT

```solidity
/// @notice Thrown when amount is zero
error ZERO_AMOUNT();
```

### INSUFFICIENT_BALANCE

```solidity
/// @notice Thrown when insufficient balance for operation
error INSUFFICIENT_BALANCE();
```

### INSUFFICIENT_ALLOWANCE

```solidity
/// @notice Thrown when insufficient allowance for transfer
error INSUFFICIENT_ALLOWANCE();
```

### SLIPPAGE_PROTECTION

```solidity
/// @notice Thrown when slippage tolerance is exceeded
error SLIPPAGE_PROTECTION();
```

### INVALID_ORACLE_PRICE

```solidity
/// @notice Thrown when oracle price is invalid
error INVALID_ORACLE_PRICE();
```

### INVALID_ALLOCATION

```solidity
/// @notice Thrown when allocation is invalid
error INVALID_ALLOCATION();
```

### TOKEN_NOT_FOUND

```solidity
/// @notice Thrown when token not found
error TOKEN_NOT_FOUND();
```

### TOKEN_NOT_SUPPORTED

```solidity
/// @notice Thrown when token not supported
error TOKEN_NOT_SUPPORTED();
```

### TOKEN_ALREADY_ACTIVE

```solidity
/// @notice Thrown when attempting to activate an already active token
error TOKEN_ALREADY_ACTIVE();
```

### TOKEN_NOT_ACTIVE

```solidity
/// @notice Thrown when attempting to use an inactive token
error TOKEN_NOT_ACTIVE();
```

### VAULT_NOT_SUPPORTED

```solidity
/// @notice Thrown when vault is not supported
error VAULT_NOT_SUPPORTED();
```

### UNAUTHORIZED

```solidity
/// @notice Thrown when caller is not authorized
error UNAUTHORIZED();
```

### INVALID_OPERATION

```solidity
/// @notice Thrown when operation would result in invalid state
error INVALID_OPERATION();
```

### INVALID_INPUT

```solidity
/// @notice Thrown when input arrays have mismatched lengths in batch operations
error INVALID_INPUT();
```

### INVALID_TOTAL_ALLOCATION

```solidity
/// @notice Thrown when the sum of all allocations exceeds 100% (PRECISION)
error INVALID_TOTAL_ALLOCATION();
```

### PRICE_USD_ZERO

```solidity
/// @notice Thrown when price in USD is zero
error PRICE_USD_ZERO();
```

### SUPPORTED_ASSET_PRICE_ORACLE_OFF

```solidity
/// @notice Thrown when a supported asset price is oracle off
error SUPPORTED_ASSET_PRICE_ORACLE_OFF(address assetWithBreakerTriggered);
```

### SUPPORTED_ASSET_PRICE_DEPEG

```solidity
/// @notice Thrown when a supported asset price is depegged
error SUPPORTED_ASSET_PRICE_DEPEG(address assetWithBreakerTriggered);
```

### SUPPORTED_ASSET_PRICE_DISPERSION

```solidity
/// @notice Thrown when a supported asset price is dispersed
error SUPPORTED_ASSET_PRICE_DISPERSION(address assetWithBreakerTriggered);
```

### SUPPORTED_ASSET_PRICE_ZERO

```solidity
/// @notice Thrown when a supported asset price is 0
error SUPPORTED_ASSET_PRICE_ZERO(address assetWithBreakerTriggered);
```

### INCENTIVE_CALCULATION_FAILED

```solidity
/// @notice Thrown when incentive calculation fails (only if totalSupply != 0)
error INCENTIVE_CALCULATION_FAILED();
```

### REDEEM_FAILED

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

### Deposit

```solidity
event Deposit(address indexed receiver, address indexed tokenIn, uint256 amountTokenToDeposit, uint256 amountSharesOut, uint256 swapFee, int256 amountIncentives);
```

### Redeem

```solidity
event Redeem(address indexed receiver, address indexed tokenOut, uint256 amountSharesToRedeem, uint256 amountTokenOut, uint256 swapFee, int256 amountIncentives);
```

### Swap

```solidity
event Swap(address indexed receiver, address indexed tokenIn, uint256 amountTokenToDeposit, address indexed tokenOut, uint256 amountSharesIntermediateStep, uint256 amountTokenOutAfterFees, uint256 swapFeeIn, uint256 swapFeeOut, int256 amountIncentivesIn, int256 amountIncentivesOut);
```

### VaultWhitelisted

```solidity
event VaultWhitelisted(address indexed vault);
```

### VaultRemoved

```solidity
event VaultRemoved(address indexed vault);
```

### VaultActivated

```solidity
event VaultActivated(address indexed vault);
```

### ERC20Whitelisted

```solidity
event ERC20Whitelisted(address indexed token);
```

### ERC20Removed

```solidity
event ERC20Removed(address indexed token);
```

### ERC20Activated

```solidity
event ERC20Activated(address indexed token);
```

### SettlementTokenInSet

```solidity
event SettlementTokenInSet(address indexed token);
```

### SettlementTokenOutSet

```solidity
event SettlementTokenOutSet(address indexed token);
```

### SuperOracleSet

```solidity
event SuperOracleSet(address indexed oracle);
```

### TargetAllocationSet

```solidity
event TargetAllocationSet(address indexed token, uint256 allocation);
```

### EnergyToUSDExchangeRatioSet

```solidity
event EnergyToUSDExchangeRatioSet(uint256 newRatio);
```

### WeightSet

```solidity
event WeightSet(address indexed vault, uint256 weight);
```

## Public/External Functions

### initialize(string,string,address,address,address,uint256,uint256)

- **Signature**: `initialize(string,string,address,address,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 21224:268:559

**Signature:**
```solidity
/// @notice Initializes the SuperAsset contract
///  @param name_ Name of the token
///  @param symbol_ Symbol of the token
///  @param asset_ Address of the primary asset
///  @param superGovernor_ Address of the SuperGovernor contract
///  @param superRegistry_ Address of the SuperRegistry contract
///  @param swapFeeInPercentage_ Initial swap fee percentage for deposits
///  @param swapFeeOutPercentage_ Initial swap fee percentage for redemptions
function initialize(string memory name_, string memory symbol_, address asset_, address superGovernor_, address superRegistry_, uint256 swapFeeInPercentage_, uint256 swapFeeOutPercentage_) external;;
```

### getTokenData(address)

- **Signature**: `getTokenData(address)`
- **Visibility**: external
- **Source Range**: 21656:78:559

**Signature:**
```solidity
/// @notice Returns the token data for a given token
///  @param token The token address
///  @return TokenData structure containing the token data
function getTokenData(address token) external view returns (TokenData memory);;
```

### getPrimaryAsset()

- **Signature**: `getPrimaryAsset()`
- **Visibility**: external
- **Source Range**: 21849:59:559

**Signature:**
```solidity
/// @notice Returns the primary asset of the SuperAsset
///  @return The address of the primary asset
function getPrimaryAsset() external view returns (address);;
```

### getPriceAndCircuitBreakers(address)

- **Signature**: `getPriceAndCircuitBreakers(address)`
- **Visibility**: external
- **Source Range**: 22255:167:559

**Signature:**
```solidity
/// @dev Gets the price of a token and circuit breaker data
///  @param token The address of the token
///  @return priceUSD The price of the token in USD
///  @return isDepeg Whether the token is depegged
///  @return isDispersion Whether the token has price dispersion
///  @return isOracleOff Whether the oracle is off
function getPriceAndCircuitBreakers(address token) external view returns (uint256 priceUSD, bool isDepeg, bool isDispersion, bool isOracleOff);;
```

### getSuperAssetPPS()

- **Signature**: `getSuperAssetPPS()`
- **Visibility**: external
- **Source Range**: 22827:314:559

**Signature:**
```solidity
/// @notice Returns the PPS of the SuperAsset and the prices of the tokens in USD
///  @return activeTokens Array of active tokens
///  @return pricePerTokenUSD Array of prices in USD
///  @return isDepeg Array of depeg breakers
///  @return isDispersion Array of dispersion breakers
///  @return isOracleOff Array of oracle off breakers
///  @return pps PPS of the SuperAsset
function getSuperAssetPPS() external view returns (address[] memory activeTokens, uint256[] memory pricePerTokenUSD, bool[] memory isDepeg, bool[] memory isDispersion, bool[] memory isOracleOff, uint256 pps);;
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 23347:51:559

**Signature:**
```solidity
/// @notice Mints new tokens. Can only be called by accounts with MINTER_ROLE.
///  @param to The address that will receive the minted tokens
///  @param amount The amount of tokens to mint
function mint(address to, uint256 amount) external;;
```

### burn(address,uint256)

- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 23594:53:559

**Signature:**
```solidity
/// @notice Burns tokens. Can only be called by accounts with BURNER_ROLE.
///  @param from The address whose tokens will be burned
///  @param amount The amount of tokens to burn
function burn(address from, uint256 amount) external;;
```

### getAllocations()

- **Signature**: `getAllocations()`
- **Visibility**: external
- **Source Range**: 24015:281:559

**Signature:**
```solidity
/// @notice Gets the current and target allocations of assets
///  @return absoluteCurrentAllocation Array of current absolute allocations
///  @return totalCurrentAllocation Sum of all current allocations
///  @return absoluteTargetAllocation Array of target absolute allocations
///  @return totalTargetAllocation Sum of all target allocations
function getAllocations() external view returns (uint256[] memory absoluteCurrentAllocation, uint256 totalCurrentAllocation, uint256[] memory absoluteTargetAllocation, uint256 totalTargetAllocation);;
```

### getAllocationsPrePostOperationDeposit(address,uint256,uint256,bool)

- **Signature**: `getAllocationsPrePostOperationDeposit(address,uint256,uint256,bool)`
- **Visibility**: external
- **Source Range**: 25641:243:559

**Signature:**
```solidity
/// @notice Gets the allocations before and after an operation deposit
///  @param token The token address involved in the operation
///  @param deltaToken The delta token (this is amountTokenToDeposit)
///  @param amountToken The amount of the token after fees
///  @param isSoft Whether the operation is soft or strict on checks
///  @return ret The allocation operation return variables containing:
///  - absoluteAllocationPreOperation: Array of pre-operation absolute allocations
///  - totalAllocationPreOperation: Total pre-operation allocation
///  - absoluteAllocationPostOperation: Array of post-operation absolute allocations
///  - totalAllocationPostOperation: Total post-operation allocation
///  - absoluteTargetAllocation: Array of target absolute allocations
///  - totalTargetAllocation: Total target allocation
///  - vaultWeights: Array of vault weights
///  - amountAssets: Amount of shares (for deposit) or tokens (for redeem)
///  - assetWithBreakerTriggered: Address of the asset with the breaker triggered
///  - oraclePriceUSD: Oracle price in USD
///  - isDepeg: Whether the asset is depegged
///  - isDispersion: Whether the asset is dispersed
///  - isOracleOff: Whether the asset is oracle off
///  - tokenFound: Whether the token in/out was found
function getAllocationsPrePostOperationDeposit(address token, uint256 deltaToken, uint256 amountToken, bool isSoft) external view returns (AllocationOperationReturnVars memory ret);;
```

### getAllocationsPrePostOperationRedeem(address,uint256,bool)

- **Signature**: `getAllocationsPrePostOperationRedeem(address,uint256,bool)`
- **Visibility**: external
- **Source Range**: 27133:214:559

**Signature:**
```solidity
/// @notice Gets the allocations before and after an operation redeem
///  @param token The token address involved in the operation
///  @param amountToken The amount of the token to redeem
///  @param isSoft Whether the operation is soft or strict on checks
///  @return ret The allocation operation return variables containing:
///  - absoluteAllocationPreOperation: Array of pre-operation absolute allocations
///  - totalAllocationPreOperation: Total pre-operation allocation
///  - absoluteAllocationPostOperation: Array of post-operation absolute allocations
///  - totalAllocationPostOperation: Total post-operation allocation
///  - absoluteTargetAllocation: Array of target absolute allocations
///  - totalTargetAllocation: Total target allocation
///  - vaultWeights: Array of vault weights
///  - amountAssets: Amount of assets (tokens to redeem)
///  - assetWithBreakerTriggered: Address of the asset with the breaker triggered
///  - oraclePriceUSD: Oracle price in USD
///  - isDepeg: Whether the asset is depegged
///  - isDispersion: Whether the asset is dispersed
///  - isOracleOff: Whether the asset is oracle off
///  - tokenFound: Whether the token out was found
function getAllocationsPrePostOperationRedeem(address token, uint256 amountToken, bool isSoft) external view returns (AllocationOperationReturnVars memory ret);;
```

### setSwapFeeInPercentage(uint256)

- **Signature**: `setSwapFeeInPercentage(uint256)`
- **Visibility**: external
- **Source Range**: 27505:65:559

**Signature:**
```solidity
/// @notice Sets the swap fee percentage for deposits (input operations)
///  @param _feePercentage The fee percentage (scaled by SWAP_FEE_PERC)
function setSwapFeeInPercentage(uint256 _feePercentage) external;;
```

### setSwapFeeOutPercentage(uint256)

- **Signature**: `setSwapFeeOutPercentage(uint256)`
- **Visibility**: external
- **Source Range**: 27732:66:559

**Signature:**
```solidity
/// @notice Sets the swap fee percentage for redemptions (output operations)
///  @param _feePercentage The fee percentage (scaled by SWAP_FEE_PERC)
function setSwapFeeOutPercentage(uint256 _feePercentage) external;;
```

### deposit(struct ISuperAsset.DepositArgs)

- **Signature**: `deposit(struct ISuperAsset.DepositArgs)`
- **Visibility**: external
- **Source Range**: 28035:90:559

**Signature:**
```solidity
/// @notice Deposits underlying assets to the vault and mints SuperUSD shares.
///  @param args The deposit arguments (receiver, tokenIn, amountTokenToDeposit, minSharesOut)
///  @return ret The deposit return variables.
function deposit(DepositArgs memory args) external returns (DepositReturnVars memory ret);;
```

### redeem(struct ISuperAsset.RedeemArgs)

- **Signature**: `redeem(struct ISuperAsset.RedeemArgs)`
- **Visibility**: external
- **Source Range**: 28365:87:559

**Signature:**
```solidity
/// @notice Redeems SuperUSD shares for underlying assets from a whitelisted vault.
///  @param args The redeem arguments (receiver, amountSharesToRedeem, tokenOut, minTokenOut)
///  @return ret The redeem return variables.
function redeem(RedeemArgs memory args) external returns (RedeemReturnVars memory ret);;
```

### swap(struct ISuperAsset.SwapArgs)

- **Signature**: `swap(struct ISuperAsset.SwapArgs)`
- **Visibility**: external
- **Source Range**: 28663:81:559

**Signature:**
```solidity
/// @notice Swaps an underlying asset for another.
///  @param args The swap arguments (receiver, tokenIn, amountTokenToDeposit, tokenOut, minTokenOut)
///  @return ret The swap return variables
function swap(SwapArgs memory args) external returns (SwapReturnVars memory ret);;
```

### whitelistVault(address,address)

- **Signature**: `whitelistVault(address,address)`
- **Visibility**: external
- **Source Range**: 28913:64:559

**Signature:**
```solidity
/// @notice Whitelists a vault
///  @param vault Address of the vault to whitelist
///  @param oracle Address of the oracle to use to fetch vault prices
function whitelistVault(address vault, address oracle) external;;
```

### removeVault(address)

- **Signature**: `removeVault(address)`
- **Visibility**: external
- **Source Range**: 29082:45:559

**Signature:**
```solidity
/// @notice Removes a vault from whitelist
///  @param vault Address of the vault to remove
function removeVault(address vault) external;;
```

### activateVault(address)

- **Signature**: `activateVault(address)`
- **Visibility**: external
- **Source Range**: 29244:47:559

**Signature:**
```solidity
/// @notice Activates a previously deactivated vault
///  @param vault Address of the vault to activate
function activateVault(address vault) external;;
```

### whitelistERC20(address)

- **Signature**: `whitelistERC20(address)`
- **Visibility**: external
- **Source Range**: 29394:48:559

**Signature:**
```solidity
/// @notice Whitelists an ERC20 token
///  @param token Address of the token to whitelist
function whitelistERC20(address token) external;;
```

### removeERC20(address)

- **Signature**: `removeERC20(address)`
- **Visibility**: external
- **Source Range**: 29554:45:559

**Signature:**
```solidity
/// @notice Removes an ERC20 token from whitelist
///  @param token Address of the token to remove
function removeERC20(address token) external;;
```

### activateERC20(address)

- **Signature**: `activateERC20(address)`
- **Visibility**: external
- **Source Range**: 29722:47:559

**Signature:**
```solidity
/// @notice Activates a previously deactivated ERC20 token
///  @param token Address of the token to activate
function activateERC20(address token) external;;
```

### previewDeposit(struct ISuperAsset.PreviewDepositArgs)

- **Signature**: `previewDeposit(struct ISuperAsset.PreviewDepositArgs)`
- **Visibility**: external
- **Source Range**: 30004:116:559

**Signature:**
```solidity
/// @notice Preview a deposit.
///  @notice Preview deposit to SuperAsset.
///  @param args The preview deposit arguments (tokenIn, amountTokenToDeposit, isSoft)
///  @return ret The preview deposit return variables
function previewDeposit(PreviewDepositArgs memory args) external view returns (PreviewDepositReturnVars memory ret);;
```

### previewRedeem(struct ISuperAsset.PreviewRedeemArgs)

- **Signature**: `previewRedeem(struct ISuperAsset.PreviewRedeemArgs)`
- **Visibility**: external
- **Source Range**: 30358:113:559

**Signature:**
```solidity
/// @notice Preview a redemption.
///  @notice Preview redeem from SuperAsset.
///  @param args The preview redeem arguments (tokenOut, amountSharesToRedeem, isSoft)
///  @return ret The preview redeem return variables
function previewRedeem(PreviewRedeemArgs memory args) external view returns (PreviewRedeemReturnVars memory ret);;
```

### previewSwap(struct ISuperAsset.PreviewSwapArgs)

- **Signature**: `previewSwap(struct ISuperAsset.PreviewSwapArgs)`
- **Visibility**: external
- **Source Range**: 30708:107:559

**Signature:**
```solidity
/// @notice Preview a swap.
///  @notice This function should not revert
///  @param args The preview swap arguments (tokenIn, amountTokenToDeposit, tokenOut, isSoft)
///  @return ret The preview swap return variables
function previewSwap(PreviewSwapArgs memory args) external view returns (PreviewSwapReturnVars memory ret);;
```

### getPrecision()

- **Signature**: `getPrecision()`
- **Visibility**: external
- **Source Range**: 30972:56:559

**Signature:**
```solidity
/// @notice Gets the precision constant used for percentage calculations
///  @return The precision constant (e.g., 10000 for 4 decimal places)
function getPrecision() external pure returns (uint256);;
```

### setWeight(address,uint256)

- **Signature**: `setWeight(address,uint256)`
- **Visibility**: external
- **Source Range**: 31183:59:559

**Signature:**
```solidity
/// @notice Sets the weight for a vault
///  @param vault The vault address
///  @param weight The weight percentage (scaled by PRECISION)
function setWeight(address vault, uint256 weight) external;;
```

### setTargetAllocations(address[],uint256[])

- **Signature**: `setTargetAllocations(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 31451:98:559

**Signature:**
```solidity
/// @notice Sets target allocations for multiple tokens at once
///  @param tokens Array of token addresses
///  @param allocations Array of target allocation percentages (scaled by PRECISION)
function setTargetAllocations(address[] calldata tokens, uint256[] calldata allocations) external;;
```

### setTargetAllocation(address,uint256)

- **Signature**: `setTargetAllocation(address,uint256)`
- **Visibility**: external
- **Source Range**: 31730:73:559

**Signature:**
```solidity
/// @notice Sets the target allocation for a token
///  @param token The token address
///  @param allocation The target allocation percentage (scaled by PRECISION)
function setTargetAllocation(address token, uint256 allocation) external;;
```

### setEnergyToUSDExchangeRatio(uint256)

- **Signature**: `setEnergyToUSDExchangeRatio(uint256)`
- **Visibility**: external
- **Source Range**: 32087:64:559

**Signature:**
```solidity
/// @notice Sets the exchange ratio between energy units and USD
///  @param newRatio The new exchange ratio (scaled by PRECISION)
///  @dev This is the ratio between energy units and USD
///  @dev No checks on zero on purpose in case we want to disable incentives
function setEnergyToUSDExchangeRatio(uint256 newRatio) external;;
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
