# Contract: MockStandardizedYield

## Metadata

- **Name**: MockStandardizedYield
- **Type**: Contract
- **Path**: test/mocks/MockStandardizedYield.sol

## State Variables

### syToken

```solidity
address public syToken
```

### ptToken

```solidity
address public ptToken
```

### ytToken

```solidity
address public ytToken
```

### assetToken

```solidity
address public assetToken
```

### assetTokenType

```solidity
AssetType public assetTokenType
```

### balanceOf

```solidity
mapping(address => uint256) public balanceOf
```

### totalSupply

```solidity
uint256 public totalSupply
```

### tokensIn

```solidity
address[] public tokensIn
```

### tokensOut

```solidity
address[] public tokensOut
```

## Errors

### NOT_AVAILABLE

```solidity
error NOT_AVAILABLE();
```

## Enums

### AssetType

```solidity
/// @dev check `assetInfo()` for more information
enum AssetType {
    TOKEN,
    LIQUIDITY
}
```

## Public/External Functions

### constructor(address,address,address)

- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 510:427:603
- **Details**: [function_constructor_address_address_address.md](./function_constructor_address_address_address.md)

**Signature:**
```solidity
constructor(address syToken_, address ptToken_, address ytToken_);
```

### assetInfo()

- **Signature**: `assetInfo()`
- **Visibility**: external
- **Source Range**: 971:214:603
- **Details**: [function_assetInfo.md](./function_assetInfo.md)

**Signature:**
```solidity
function assetInfo() external view returns (AssetType assetType, address assetAddress, uint8 assetDecimals);
```

### setAssetType(uint256)

- **Signature**: `setAssetType(uint256)`
- **Visibility**: external
- **Source Range**: 1191:106:603
- **Details**: [function_setAssetType_uint256.md](./function_setAssetType_uint256.md)

**Signature:**
```solidity
function setAssetType(uint256 _assetType) external;
```

### exchangeRate()

- **Signature**: `exchangeRate()`
- **Visibility**: external
- **Source Range**: 1303:84:603
- **Details**: [function_exchangeRate.md](./function_exchangeRate.md)

**Signature:**
```solidity
function exchangeRate() external pure returns (uint256);
```

### pyIndexStored()

- **Signature**: `pyIndexStored()`
- **Visibility**: external
- **Source Range**: 1393:85:603
- **Details**: [function_pyIndexStored.md](./function_pyIndexStored.md)

**Signature:**
```solidity
function pyIndexStored() external pure returns (uint256);
```

### doCacheIndexSameBlock()

- **Signature**: `doCacheIndexSameBlock()`
- **Visibility**: external
- **Source Range**: 1484:90:603
- **Details**: [function_doCacheIndexSameBlock.md](./function_doCacheIndexSameBlock.md)

**Signature:**
```solidity
function doCacheIndexSameBlock() external pure returns (bool);
```

### pyIndexLastUpdatedBlock()

- **Signature**: `pyIndexLastUpdatedBlock()`
- **Visibility**: external
- **Source Range**: 1580:95:603
- **Details**: [function_pyIndexLastUpdatedBlock.md](./function_pyIndexLastUpdatedBlock.md)

**Signature:**
```solidity
function pyIndexLastUpdatedBlock() external pure returns (uint256);
```

### getTokensIn()

- **Signature**: `getTokensIn()`
- **Visibility**: external
- **Source Range**: 1681:96:603
- **Details**: [function_getTokensIn.md](./function_getTokensIn.md)

**Signature:**
```solidity
function getTokensIn() external view returns (address[] memory);
```

### setTokensIn(address[])

- **Signature**: `setTokensIn(address[])`
- **Visibility**: external
- **Source Range**: 1783:95:603
- **Details**: [function_setTokensIn_address[].md](./function_setTokensIn_address[].md)

**Signature:**
```solidity
function setTokensIn(address[] memory _tokensIn) external;
```

### getTokensOut()

- **Signature**: `getTokensOut()`
- **Visibility**: external
- **Source Range**: 1884:98:603
- **Details**: [function_getTokensOut.md](./function_getTokensOut.md)

**Signature:**
```solidity
function getTokensOut() external view returns (address[] memory);
```

### setTokensOut(address[])

- **Signature**: `setTokensOut(address[])`
- **Visibility**: external
- **Source Range**: 1988:99:603
- **Details**: [function_setTokensOut_address[].md](./function_setTokensOut_address[].md)

**Signature:**
```solidity
function setTokensOut(address[] memory _tokensOut) external;
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 2093:76:603
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external pure returns (uint8);
```

### setBalanceForAccount(address,uint256)

- **Signature**: `setBalanceForAccount(address,uint256)`
- **Visibility**: external
- **Source Range**: 2175:138:603
- **Details**: [function_setBalanceForAccount_address_uint256.md](./function_setBalanceForAccount_address_uint256.md)

**Signature:**
```solidity
function setBalanceForAccount(address acc, uint256 amount) external;
```

### setTotalAsset(uint256)

- **Signature**: `setTotalAsset(uint256)`
- **Visibility**: external
- **Source Range**: 2319:85:603
- **Details**: [function_setTotalAsset_uint256.md](./function_setTotalAsset_uint256.md)

**Signature:**
```solidity
function setTotalAsset(uint256 amount) external;
```
