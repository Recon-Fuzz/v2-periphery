# Contract: MockERC4626YieldSourceOracle

## Metadata

- **Name**: MockERC4626YieldSourceOracle
- **Type**: Contract
- **Path**: test/recon/mocks/MockERC4626YieldSourceOracle.sol
- **Documentation**: @title MockERC4626YieldSourceOracle
   @notice Mock oracle for ERC4626 vaults in testing

## Implements Interfaces

- **IYieldSourceOracle** [lib/v2-core/src/interfaces/accounting/IYieldSourceOracle.sol/interface_IYieldSourceOracle.md]

## State Variables

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

### setValidAsset(address,bool)

- **Signature**: `setValidAsset(address,bool)`
- **Visibility**: external
- **Source Range**: 521:108:638
- **Details**: [function_setValidAsset_address_bool.md](./function_setValidAsset_address_bool.md)

**Signature:**
```solidity
function setValidAsset(address asset, bool isValid) external;
```

### decimals(address)

- **Signature**: `decimals(address)`
- **Visibility**: external
- **Source Range**: 635:139:638
- **Details**: [function_decimals_address.md](./function_decimals_address.md)

**Signature:**
```solidity
function decimals(address yieldSourceAddress) external view returns (uint8);
```

### getShareOutput(address,address,uint256)

- **Signature**: `getShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 780:188:638
- **Details**: [function_getShareOutput_address_address_uint256.md](./function_getShareOutput_address_address_uint256.md)

**Signature:**
```solidity
function getShareOutput(address yieldSourceAddress, address, uint256 assetsIn) external view returns (uint256);
```

### getWithdrawalShareOutput(address,address,uint256)

- **Signature**: `getWithdrawalShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 974:257:638
- **Details**: [function_getWithdrawalShareOutput_address_address_uint256.md](./function_getWithdrawalShareOutput_address_address_uint256.md)

**Signature:**
```solidity
function getWithdrawalShareOutput(address yieldSourceAddress, address, uint256 assetsIn) external view returns (uint256);
```

### getAssetOutput(address,address,uint256)

- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1237:185:638
- **Details**: [function_getAssetOutput_address_address_uint256.md](./function_getAssetOutput_address_address_uint256.md)

**Signature:**
```solidity
function getAssetOutput(address yieldSourceAddress, address, uint256 sharesIn) public view returns (uint256);
```

### getPricePerShare(address)

- **Signature**: `getPricePerShare(address)`
- **Visibility**: external
- **Source Range**: 1428:267:638
- **Details**: [function_getPricePerShare_address.md](./function_getPricePerShare_address.md)

**Signature:**
```solidity
function getPricePerShare(address yieldSourceAddress) external view returns (uint256);
```

### getBalanceOfOwner(address,address)

- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: external
- **Source Range**: 1701:187:638
- **Details**: [function_getBalanceOfOwner_address_address.md](./function_getBalanceOfOwner_address_address.md)

**Signature:**
```solidity
function getBalanceOfOwner(address yieldSourceAddress, address ownerOfShares) external view returns (uint256);
```

### getTVLByOwnerOfShares(address,address)

- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: external
- **Source Range**: 1894:270:638
- **Details**: [function_getTVLByOwnerOfShares_address_address.md](./function_getTVLByOwnerOfShares_address_address.md)

**Signature:**
```solidity
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) external view returns (uint256);
```

### getTVL(address)

- **Signature**: `getTVL(address)`
- **Visibility**: external
- **Source Range**: 2170:142:638
- **Details**: [function_getTVL_address.md](./function_getTVL_address.md)

**Signature:**
```solidity
function getTVL(address yieldSourceAddress) external view returns (uint256);
```

### getPricePerShareMultiple(address[])

- **Signature**: `getPricePerShareMultiple(address[])`
- **Visibility**: external
- **Source Range**: 2318:496:638
- **Details**: [function_getPricePerShareMultiple_address[].md](./function_getPricePerShareMultiple_address[].md)

**Signature:**
```solidity
function getPricePerShareMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory);
```

### getTVLByOwnerOfSharesMultiple(address[],address[][])

- **Signature**: `getTVLByOwnerOfSharesMultiple(address[],address[][])`
- **Visibility**: external
- **Source Range**: 2820:734:638
- **Details**: [function_getTVLByOwnerOfSharesMultiple_address[]_address[][].md](./function_getTVLByOwnerOfSharesMultiple_address[]_address[][].md)

**Signature:**
```solidity
function getTVLByOwnerOfSharesMultiple(address[] memory yieldSourceAddresses, address[][] memory ownersOfShares) external view returns (uint256[][] memory);
```

### getTVLMultiple(address[])

- **Signature**: `getTVLMultiple(address[])`
- **Visibility**: external
- **Source Range**: 3560:357:638
- **Details**: [function_getTVLMultiple_address[].md](./function_getTVLMultiple_address[].md)

**Signature:**
```solidity
function getTVLMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory);
```

### isValidUnderlyingAsset(address,address)

- **Signature**: `isValidUnderlyingAsset(address,address)`
- **Visibility**: external
- **Source Range**: 3923:129:638
- **Details**: [function_isValidUnderlyingAsset_address_address.md](./function_isValidUnderlyingAsset_address_address.md)

**Signature:**
```solidity
function isValidUnderlyingAsset(address, address asset) external view returns (bool);
```

### isValidUnderlyingAssets(address[],address[])

- **Signature**: `isValidUnderlyingAssets(address[],address[])`
- **Visibility**: external
- **Source Range**: 4058:328:638
- **Details**: [function_isValidUnderlyingAssets_address[]_address[].md](./function_isValidUnderlyingAssets_address[]_address[].md)

**Signature:**
```solidity
function isValidUnderlyingAssets(address[] memory, address[] memory assets) external view returns (bool[] memory);
```

### getAssetOutputWithFees(bytes32,address,address,address,uint256)

- **Signature**: `getAssetOutputWithFees(bytes32,address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 4392:287:638
- **Details**: [function_getAssetOutputWithFees_bytes32_address_address_address_uint256.md](./function_getAssetOutputWithFees_bytes32_address_address_address_uint256.md)

**Signature:**
```solidity
function getAssetOutputWithFees(bytes32, address yieldSourceAddress, address, address, uint256 sharesIn) external view returns (uint256);
```
