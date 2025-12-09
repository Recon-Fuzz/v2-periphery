# Contract: StakingYieldSourceOracle

## Metadata

- **Name**: StakingYieldSourceOracle
- **Type**: Contract
- **Path**: lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol
- **Documentation**: @title StakingYieldSourceOracle
   @author Superform Labs
   @notice Oracle for Staking Yield Sources

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
- **Source Range**: 485:103:357
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address superLedgerConfiguration_) AbstractYieldSourceOracle(superLedgerConfiguration_);
```

### decimals(address)

- **Signature**: `decimals(address)`
- **Visibility**: external
- **Source Range**: 826:92:357
- **Details**: [function_decimals_address.md](./function_decimals_address.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function decimals(address) override external pure returns (uint8);
```

### getPricePerShare(address)

- **Signature**: `getPricePerShare(address)`
- **Visibility**: public
- **Source Range**: 970:102:357
- **Details**: [function_getPricePerShare_address.md](./function_getPricePerShare_address.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getPricePerShare(address) override public pure returns (uint256);
```

### getShareOutput(address,address,uint256)

- **Signature**: `getShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1124:133:357
- **Details**: [function_getShareOutput_address_address_uint256.md](./function_getShareOutput_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getShareOutput(address, address, uint256 assetsIn) override external pure returns (uint256);
```

### getWithdrawalShareOutput(address,address,uint256)

- **Signature**: `getWithdrawalShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1309:209:357
- **Details**: [function_getWithdrawalShareOutput_address_address_uint256.md](./function_getWithdrawalShareOutput_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getWithdrawalShareOutput(address, address, uint256 assetsIn) override external pure returns (uint256);
```

### getAssetOutput(address,address,uint256)

- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1571:131:357
- **Details**: [function_getAssetOutput_address_address_uint256.md](./function_getAssetOutput_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getAssetOutput(address, address, uint256 sharesIn) override public pure returns (uint256);
```

### getBalanceOfOwner(address,address)

- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: public
- **Source Range**: 1754:250:357
- **Details**: [function_getBalanceOfOwner_address_address.md](./function_getBalanceOfOwner_address_address.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getBalanceOfOwner(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256);
```

### getTVLByOwnerOfShares(address,address)

- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: public
- **Source Range**: 2056:254:357
- **Details**: [function_getTVLByOwnerOfShares_address_address.md](./function_getTVLByOwnerOfShares_address_address.md)

**Signature:**
```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256);
```

### getTVL(address)

- **Signature**: `getTVL(address)`
- **Visibility**: public
- **Source Range**: 2362:147:357
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
