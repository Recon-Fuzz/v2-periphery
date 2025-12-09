# Contract: MockYieldSourceOracle

## Metadata

- **Name**: MockYieldSourceOracle
- **Type**: Contract
- **Path**: test/mocks/MockYieldSourceOracle.sol

## Implements Interfaces

- **IYieldSourceOracle** [lib/v2-core/src/interfaces/accounting/IYieldSourceOracle.sol/interface_IYieldSourceOracle.md]

## State Variables

### pricePerShare

```solidity
uint256 public pricePerShare
```

### tvl

```solidity
uint256 public tvl
```

### tvlByOwner

```solidity
uint256 public tvlByOwner
```

### validity

```solidity
bool public validity
```

### validAssetMap

```solidity
mapping(address => bool) public validAssetMap
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

### constructor(uint256,uint256,uint256,bool)

- **Signature**: `constructor(uint256,uint256,uint256,bool)`
- **Visibility**: public
- **Source Range**: 451:218:607
- **Details**: [function_constructor_uint256_uint256_uint256_bool.md](./function_constructor_uint256_uint256_uint256_bool.md)

**Signature:**
```solidity
constructor(uint256 _pricePerShare, uint256 _tvl, uint256 _tvlByOwner, bool _validity);
```

### setPricePerShare(uint256)

- **Signature**: `setPricePerShare(uint256)`
- **Visibility**: external
- **Source Range**: 675:106:607
- **Details**: [function_setPricePerShare_uint256.md](./function_setPricePerShare_uint256.md)

**Signature:**
```solidity
function setPricePerShare(uint256 _pricePerShare) external;
```

### setTVL(uint256)

- **Signature**: `setTVL(uint256)`
- **Visibility**: external
- **Source Range**: 787:66:607
- **Details**: [function_setTVL_uint256.md](./function_setTVL_uint256.md)

**Signature:**
```solidity
function setTVL(uint256 _tvl) external;
```

### setTVLByOwner(uint256)

- **Signature**: `setTVLByOwner(uint256)`
- **Visibility**: external
- **Source Range**: 859:94:607
- **Details**: [function_setTVLByOwner_uint256.md](./function_setTVLByOwner_uint256.md)

**Signature:**
```solidity
function setTVLByOwner(uint256 _tvlByOwner) external;
```

### setValidity(bool)

- **Signature**: `setValidity(bool)`
- **Visibility**: external
- **Source Range**: 959:83:607
- **Details**: [function_setValidity_bool.md](./function_setValidity_bool.md)

**Signature:**
```solidity
function setValidity(bool _validity) external;
```

### setValidAsset(address,bool)

- **Signature**: `setValidAsset(address,bool)`
- **Visibility**: external
- **Source Range**: 1048:108:607
- **Details**: [function_setValidAsset_address_bool.md](./function_setValidAsset_address_bool.md)

**Signature:**
```solidity
function setValidAsset(address asset, bool isValid) external;
```

### decimals(address)

- **Signature**: `decimals(address)`
- **Visibility**: external
- **Source Range**: 1162:83:607
- **Details**: [function_decimals_address.md](./function_decimals_address.md)

**Signature:**
```solidity
function decimals(address) external pure returns (uint8);
```

### getShareOutput(address,address,uint256)

- **Signature**: `getShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1251:124:607
- **Details**: [function_getShareOutput_address_address_uint256.md](./function_getShareOutput_address_address_uint256.md)

**Signature:**
```solidity
function getShareOutput(address, address, uint256 assetsIn) external pure returns (uint256);
```

### getWithdrawalShareOutput(address,address,uint256)

- **Signature**: `getWithdrawalShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1381:134:607
- **Details**: [function_getWithdrawalShareOutput_address_address_uint256.md](./function_getWithdrawalShareOutput_address_address_uint256.md)

**Signature:**
```solidity
function getWithdrawalShareOutput(address, address, uint256 assetsIn) external pure returns (uint256);
```

### getAssetOutput(address,address,uint256)

- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1521:122:607
- **Details**: [function_getAssetOutput_address_address_uint256.md](./function_getAssetOutput_address_address_uint256.md)

**Signature:**
```solidity
function getAssetOutput(address, address, uint256 sharesIn) public pure returns (uint256);
```

### getAssetOutputWithFees(bytes32,address,address,address,uint256)

- **Signature**: `getAssetOutputWithFees(bytes32,address,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1649:176:607
- **Details**: [function_getAssetOutputWithFees_bytes32_address_address_address_uint256.md](./function_getAssetOutputWithFees_bytes32_address_address_address_uint256.md)

**Signature:**
```solidity
function getAssetOutputWithFees(bytes32, address, address, address, uint256 sharesIn) public pure returns (uint256);
```

### getBalanceOfOwner(address,address)

- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: external
- **Source Range**: 1831:111:607
- **Details**: [function_getBalanceOfOwner_address_address.md](./function_getBalanceOfOwner_address_address.md)

**Signature:**
```solidity
function getBalanceOfOwner(address, address) external view returns (uint256);
```

### getPricePerShare(address)

- **Signature**: `getPricePerShare(address)`
- **Visibility**: external
- **Source Range**: 1948:104:607
- **Details**: [function_getPricePerShare_address.md](./function_getPricePerShare_address.md)

**Signature:**
```solidity
function getPricePerShare(address) external view returns (uint256);
```

### getTVLByOwnerOfShares(address,address)

- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: external
- **Source Range**: 2058:115:607
- **Details**: [function_getTVLByOwnerOfShares_address_address.md](./function_getTVLByOwnerOfShares_address_address.md)

**Signature:**
```solidity
function getTVLByOwnerOfShares(address, address) external view returns (uint256);
```

### getTVL(address)

- **Signature**: `getTVL(address)`
- **Visibility**: external
- **Source Range**: 2179:84:607
- **Details**: [function_getTVL_address.md](./function_getTVL_address.md)

**Signature:**
```solidity
function getTVL(address) external view returns (uint256);
```

### getPricePerShareMultiple(address[])

- **Signature**: `getPricePerShareMultiple(address[])`
- **Visibility**: external
- **Source Range**: 2269:210:607
- **Details**: [function_getPricePerShareMultiple_address[].md](./function_getPricePerShareMultiple_address[].md)

**Signature:**
```solidity
function getPricePerShareMultiple(address[] memory) external view returns (uint256[] memory);
```

### getTVLByOwnerOfSharesMultiple(address[],address[][])

- **Signature**: `getTVLByOwnerOfSharesMultiple(address[],address[][])`
- **Visibility**: external
- **Source Range**: 2485:438:607
- **Details**: [function_getTVLByOwnerOfSharesMultiple_address[]_address[][].md](./function_getTVLByOwnerOfSharesMultiple_address[]_address[][].md)

**Signature:**
```solidity
function getTVLByOwnerOfSharesMultiple(address[] memory yieldSources, address[][] memory) external view returns (uint256[][] memory);
```

### getTVLMultiple(address[])

- **Signature**: `getTVLMultiple(address[])`
- **Visibility**: external
- **Source Range**: 2929:184:607
- **Details**: [function_getTVLMultiple_address[].md](./function_getTVLMultiple_address[].md)

**Signature:**
```solidity
function getTVLMultiple(address[] memory) external view returns (uint256[] memory);
```

### isValidUnderlyingAsset(address,address)

- **Signature**: `isValidUnderlyingAsset(address,address)`
- **Visibility**: external
- **Source Range**: 3119:129:607
- **Details**: [function_isValidUnderlyingAsset_address_address.md](./function_isValidUnderlyingAsset_address_address.md)

**Signature:**
```solidity
function isValidUnderlyingAsset(address, address asset) external view returns (bool);
```

### isValidUnderlyingAssets(address[],address[])

- **Signature**: `isValidUnderlyingAssets(address[],address[])`
- **Visibility**: external
- **Source Range**: 3254:225:607
- **Details**: [function_isValidUnderlyingAssets_address[]_address[].md](./function_isValidUnderlyingAssets_address[]_address[].md)

**Signature:**
```solidity
function isValidUnderlyingAssets(address[] memory, address[] memory) external view returns (bool[] memory);
```
