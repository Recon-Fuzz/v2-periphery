# Contract: ERC5115YieldSourceOracle

## Metadata

- **Name**: ERC5115YieldSourceOracle
- **Type**: Contract
- **Path**: lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol
- **Documentation**: @title ERC5115YieldSourceOracle
   @author Superform Labs
   @notice Oracle for 5115 Vaults

## Implements Interfaces

- **IYieldSourceOracle** [lib/v2-core/src/interfaces/accounting/IYieldSourceOracle.sol/interface_IYieldSourceOracle.md]

## State Variables

### SUPER_LEDGER_CONFIGURATION (inherited from AbstractYieldSourceOracle)

```solidity
/// @notice Immutable address of the SuperLedgerConfiguration contract
address public immutable SUPER_LEDGER_CONFIGURATION
```

## Structs

### TVLMultipleUSDVars (inherited from IYieldSourceOracle)

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

### ARRAY_LENGTH_MISMATCH (inherited from IYieldSourceOracle)

```solidity
/// @notice Error when array lengths do not match in batch operations
///  @dev Thrown when the lengths of input arrays in multi-asset operations don't match
error ARRAY_LENGTH_MISMATCH();
```

### INVALID_BASE_ASSET (inherited from IYieldSourceOracle)

```solidity
/// @notice Error when base asset is not valid for the yield source
///  @dev Thrown when attempting to use an asset that isn't supported by the yield source
error INVALID_BASE_ASSET();
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 484:103:356
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address superLedgerConfiguration_) AbstractYieldSourceOracle(superLedgerConfiguration_);
```

### decimals(address)

- **Signature**: `decimals(address)`
- **Visibility**: public
- **Source Range**: 2110:163:356
- **Details**: [function_decimals_address.md](./function_decimals_address.md)

**Signature:**
```solidity
/// exchangeRate() returns price scaled to 1e18 precision, independent of SY token or asset decimals.
///  This ensures correct normalization in mulDiv operations.
///  See https://eips.ethereum.org/EIPS/eip-5115#methods -> exchangeRate()
///  The name decimals() here is ambiguous because it is a function used in other areas of the code for scaling (but
///  it doesn't refer to the SY decimals) 
///  Calculation Examples in the Oracle:
///  - In getTVL: Math.mulDiv(totalShares, yieldSource.exchangeRate(), 1e18). Here, totalShares is in SY decimals
///  (D), exchangeRate is (totalAssets * 1e18) / totalShares (per EIP, with totalAssets in asset decimals A). This
///  simplifies to totalAssets, correctly outputting the asset amount regardless of D or A.
///  - In getWithdrawalShareOutput: previewRedeem(assetIn, 1e18) gets assets for 1e18 SY share units, then
///  mulDiv(assetsIn, 1e18, assetsPerShare, Ceil) computes the required share units. The 1e18 acts as a precision
///  scaler (matching EIP), not an assumption about D. For example, with a 6-decimal SY (like Pendle's SY-syrupUSDC)
///  and initial 1:1 rate, it correctly computes shares without issues.
///  - This pattern holds for other functions like getAssetOutput (direct previewRedeem without scaling assumptions).
function decimals(address) override public pure returns (uint8) {
    return 18;
};
```

### getShareOutput(address,address,uint256)

- **Signature**: `getShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2325:290:356
- **Details**: [function_getShareOutput_address_address_uint256.md](./function_getShareOutput_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getShareOutput(address yieldSourceAddress, address assetIn, uint256 assetsIn) override external view returns (uint256);
```

### getWithdrawalShareOutput(address,address,uint256)

- **Signature**: `getWithdrawalShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2667:436:356
- **Details**: [function_getWithdrawalShareOutput_address_address_uint256.md](./function_getWithdrawalShareOutput_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getWithdrawalShareOutput(address yieldSourceAddress, address assetIn, uint256 assetsIn) override external view returns (uint256);
```

### getAssetOutput(address,address,uint256)

- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3155:289:356
- **Details**: [function_getAssetOutput_address_address_uint256.md](./function_getAssetOutput_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getAssetOutput(address yieldSourceAddress, address assetOut, uint256 sharesIn) override public view returns (uint256);
```

### getPricePerShare(address)

- **Signature**: `getPricePerShare(address)`
- **Visibility**: public
- **Source Range**: 3496:170:356
- **Details**: [function_getPricePerShare_address.md](./function_getPricePerShare_address.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getPricePerShare(address yieldSourceAddress) override public view returns (uint256);
```

### getBalanceOfOwner(address,address)

- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: public
- **Source Range**: 3718:262:356
- **Details**: [function_getBalanceOfOwner_address_address.md](./function_getBalanceOfOwner_address_address.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getBalanceOfOwner(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256);
```

### getTVLByOwnerOfShares(address,address)

- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: public
- **Source Range**: 4032:435:356
- **Details**: [function_getTVLByOwnerOfShares_address_address.md](./function_getTVLByOwnerOfShares_address_address.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256);
```

### getTVL(address)

- **Signature**: `getTVL(address)`
- **Visibility**: public
- **Source Range**: 4519:343:356
- **Details**: [function_getTVL_address.md](./function_getTVL_address.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVL(address yieldSourceAddress) override public view returns (uint256);
```

### getAssetOutputWithFees(bytes32,address,address,address,uint256) (inherited from AbstractYieldSourceOracle)

- **Signature**: `getAssetOutputWithFees(bytes32,address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3205:1621:354
- **Details**: [function_getAssetOutputWithFees_bytes32_address_address_address_uint256.md](./function_getAssetOutputWithFees_bytes32_address_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IYieldSourceOracle
function getAssetOutputWithFees(bytes32 yieldSourceOracleId, address yieldSourceAddress, address assetOut, address user, uint256 usedShares) virtual external view returns (uint256);
```

### getPricePerShareMultiple(address[]) (inherited from AbstractYieldSourceOracle)

- **Signature**: `getPricePerShareMultiple(address[])`
- **Visibility**: external
- **Source Range**: 4871:466:354
- **Details**: [function_getPricePerShareMultiple_address[].md](./function_getPricePerShareMultiple_address[].md)

**Signature:**
```solidity
/// @inheritdoc IYieldSourceOracle
function getPricePerShareMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory pricesPerShare);
```

### getTVLByOwnerOfSharesMultiple(address[],address[][]) (inherited from AbstractYieldSourceOracle)

- **Signature**: `getTVLByOwnerOfSharesMultiple(address[],address[][])`
- **Visibility**: external
- **Source Range**: 5599:959:354
- **Details**: [function_getTVLByOwnerOfSharesMultiple_address[]_address[][].md](./function_getTVLByOwnerOfSharesMultiple_address[]_address[][].md)

**Signature:**
```solidity
/// @inheritdoc IYieldSourceOracle
function getTVLByOwnerOfSharesMultiple(address[] memory yieldSourceAddresses, address[][] memory ownersOfShares) external view returns (uint256[][] memory userTvls);
```

### getTVLMultiple(address[]) (inherited from AbstractYieldSourceOracle)

- **Signature**: `getTVLMultiple(address[])`
- **Visibility**: external
- **Source Range**: 6603:358:354
- **Details**: [function_getTVLMultiple_address[].md](./function_getTVLMultiple_address[].md)

**Signature:**
```solidity
/// @inheritdoc IYieldSourceOracle
function getTVLMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory tvls);
```
