# Interface: ISafeConfiguration

## Metadata

- **Name**: ISafeConfiguration
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/gnosis/ISafeConfiguration.sol

## Public/External Functions

### getOwners()

- **Signature**: `getOwners()`
- **Visibility**: external
- **Source Range**: 99:62:453

**Signature:**
```solidity
function getOwners() external view returns (address[] memory);;
```

### getThreshold()

- **Signature**: `getThreshold()`
- **Visibility**: external
- **Source Range**: 166:56:453

**Signature:**
```solidity
function getThreshold() external view returns (uint256);;
```

### isOwner(address)

- **Signature**: `isOwner(address)`
- **Visibility**: external
- **Source Range**: 227:61:453

**Signature:**
```solidity
function isOwner(address owner) external view returns (bool);;
```
