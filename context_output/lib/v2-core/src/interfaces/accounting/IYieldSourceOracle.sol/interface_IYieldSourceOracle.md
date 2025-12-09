# Interface: IYieldSourceOracle

## Metadata

- **Name**: IYieldSourceOracle
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/accounting/IYieldSourceOracle.sol
- **Documentation**: @title IYieldSourceOracle
   @author Superform Labs
   @notice Interface for oracles that provide price and TVL data for yield-bearing assets

## Structs

### TVLMultipleUSDVars

```solidity
/// @notice Struct to hold local variables for getTVLMultipleUSD
///  @dev Used to manage complex computation state without stack-too-deep errors
///       These variables support the calculation of USD-denominated TVL values
///       across multiple yield sources and owners
struct TVLMultipleUSDVars {
    uint256 length;
    uint256 ownersLength;
    uint256 baseAmount;
    uint256 userTvlUSD;
    uint256 totalTvlUSD;
    address yieldSource;
    address[] owners;
    IOracle registry;
}
```

## Errors

### ARRAY_LENGTH_MISMATCH

```solidity
/// @notice Error when array lengths do not match in batch operations
///  @dev Thrown when the lengths of input arrays in multi-asset operations don't match
error ARRAY_LENGTH_MISMATCH();
```

### INVALID_BASE_ASSET

```solidity
/// @notice Error when base asset is not valid for the yield source
///  @dev Thrown when attempting to use an asset that isn't supported by the yield source
error INVALID_BASE_ASSET();
```

## Public/External Functions

### decimals(address)

- **Signature**: `decimals(address)`
- **Visibility**: external
- **Source Range**: 2734:76:430

**Signature:**
```solidity
/// @notice Returns the number of decimals of the yield source shares
///  @dev Critical for accurately interpreting share amounts and calculating prices
///       Different yield sources may have different decimal precision
///  @param yieldSourceAddress The address of the yield-bearing token contract
///  @return decimals The number of decimals used by the yield source's share token
function decimals(address yieldSourceAddress) external view returns (uint8);;
```

### getShareOutput(address,address,uint256)

- **Signature**: `getShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3339:173:430

**Signature:**
```solidity
/// @notice Calculates the number of shares that would be received for a given amount of assets
///  @dev Used for deposit simulations and to calculate current exchange rates
///  @param yieldSourceAddress The yield-bearing token address (e.g., aUSDC, cDAI)
///  @param assetIn The underlying asset being deposited (e.g., USDC, DAI)
///  @param assetsIn The amount of underlying assets to deposit, in the asset's native units
///  @return shares The number of yield-bearing shares that would be received
function getShareOutput(address yieldSourceAddress, address assetIn, uint256 assetsIn) external view returns (uint256);;
```

### getWithdrawalShareOutput(address,address,uint256)

- **Signature**: `getWithdrawalShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 4113:183:430

**Signature:**
```solidity
/// @notice Calculates the amount of shares that would be burnt when withdrawing a given amount of assets
///  @dev Used by oracles to simulate withdrawals and to derive the current exchange rate
///  @param yieldSourceAddress The address of the yield-bearing token (e.g., aUSDC, cDAI)
///  @param assetIn The address of the underlying asset to be withdrawn (e.g., USDC, DAI)
///  @param assetsIn The amount of underlying assets to withdraw, denominated in the asset’s native units
///  @return shares The amount of yield-bearing shares that would be burnt after withdrawal
function getWithdrawalShareOutput(address yieldSourceAddress, address assetIn, uint256 assetsIn) external view returns (uint256);;
```

### getAssetOutput(address,address,uint256)

- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 4795:173:430

**Signature:**
```solidity
/// @notice Calculates the number of underlying assets that would be received for a given amount of shares
///  @dev Used for withdrawal simulations and to calculate current yield
///  @param yieldSourceAddress The yield-bearing token address (e.g., aUSDC, cDAI)
///  @param assetIn The underlying asset to receive (e.g., USDC, DAI)
///  @param sharesIn The amount of yield-bearing shares to redeem
///  @return assets The number of underlying assets that would be received
function getAssetOutput(address yieldSourceAddress, address assetIn, uint256 sharesIn) external view returns (uint256);;
```

### getPricePerShare(address)

- **Signature**: `getPricePerShare(address)`
- **Visibility**: external
- **Source Range**: 5326:86:430

**Signature:**
```solidity
/// @notice Retrieves the current price per share in terms of the underlying asset
///  @dev Core function for calculating yields and determining returns
///  @param yieldSourceAddress The yield-bearing token address to get the price for
///  @return pricePerShare The current price per share in underlying asset terms, scaled by decimals
function getPricePerShare(address yieldSourceAddress) external view returns (uint256);;
```

### getTVLByOwnerOfShares(address,address)

- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: external
- **Source Range**: 5808:114:430

**Signature:**
```solidity
/// @notice Calculates the total value locked in a yield source by a specific owner
///  @dev Used to track individual position sizes within the system
///  @param yieldSourceAddress The yield-bearing token address to check
///  @param ownerOfShares The address owning the yield-bearing tokens
///  @return tvl The total value locked by the owner, in underlying asset terms
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) external view returns (uint256);;
```

### getBalanceOfOwner(address,address)

- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: external
- **Source Range**: 6370:110:430

**Signature:**
```solidity
/// @notice Gets the share balance of a specific owner in a yield source
///  @dev Returns raw share balance without converting to underlying assets
///       Used to track participation in the system and for accounting
///  @param yieldSourceAddress The yield-bearing token address
///  @param ownerOfShares The address to check the balance for
///  @return balance The number of yield-bearing tokens owned by the address
function getBalanceOfOwner(address yieldSourceAddress, address ownerOfShares) external view returns (uint256);;
```

### getTVL(address)

- **Signature**: `getTVL(address)`
- **Visibility**: external
- **Source Range**: 6817:76:430

**Signature:**
```solidity
/// @notice Calculates the total value locked across all users in a yield source
///  @dev Critical for monitoring the size of each yield source in the system
///  @param yieldSourceAddress The yield-bearing token address to check
///  @return tvl The total value locked in the yield source, in underlying asset terms
function getTVL(address yieldSourceAddress) external view returns (uint256);;
```

### getPricePerShareMultiple(address[])

- **Signature**: `getPricePerShareMultiple(address[])`
- **Visibility**: external
- **Source Range**: 7205:153:430

**Signature:**
```solidity
/// @notice Batch version of getPricePerShare for multiple yield sources
///  @dev Efficiently retrieves current prices for multiple yield sources
///  @param yieldSourceAddresses Array of yield-bearing token addresses
///  @return pricesPerShare Array of current prices for each yield source
function getPricePerShareMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory pricesPerShare);;
```

### getTVLByOwnerOfSharesMultiple(address[],address[][])

- **Signature**: `getTVLByOwnerOfSharesMultiple(address[],address[][])`
- **Visibility**: external
- **Source Range**: 7810:211:430

**Signature:**
```solidity
/// @notice Batch version of getTVLByOwnerOfShares for multiple yield sources and owners
///  @dev Efficiently calculates TVL for multiple owners across multiple yield sources
///  @param yieldSourceAddresses Array of yield-bearing token addresses
///  @param ownersOfShares 2D array where each sub-array contains owner addresses for a yield source
///  @return userTvls 2D array of TVL values for each owner in each yield source
function getTVLByOwnerOfSharesMultiple(address[] memory yieldSourceAddresses, address[][] memory ownersOfShares) external view returns (uint256[][] memory userTvls);;
```

### getTVLMultiple(address[])

- **Signature**: `getTVLMultiple(address[])`
- **Visibility**: external
- **Source Range**: 8319:109:430

**Signature:**
```solidity
/// @notice Batch version of getTVL for multiple yield sources
///  @dev Efficiently calculates total TVL across multiple yield sources
///  @param yieldSourceAddresses Array of yield-bearing token addresses
///  @return tvls Array containing the total TVL for each yield source
function getTVLMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory tvls);;
```

### getAssetOutputWithFees(bytes32,address,address,address,uint256)

- **Signature**: `getAssetOutputWithFees(bytes32,address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 9065:243:430

**Signature:**
```solidity
/// @notice Calculates the asset output with fees added for an outflow operation
///  @dev Gets the asset output from the oracle and adds any applicable fees
///       Uses try/catch to handle cases where oracle configuration doesn't exist
///  @param yieldSourceOracleId Identifier for the yield source oracle configuration
///  @param yieldSourceAddress Address of the yield-bearing asset
///  @param assetOut Address of the output asset
///  @param user Address of the user performing the outflow
///  @param usedShares Amount of shares being withdrawn
///  @return Total asset amount including fees
function getAssetOutputWithFees(bytes32 yieldSourceOracleId, address yieldSourceAddress, address assetOut, address user, uint256 usedShares) external view returns (uint256);;
```
