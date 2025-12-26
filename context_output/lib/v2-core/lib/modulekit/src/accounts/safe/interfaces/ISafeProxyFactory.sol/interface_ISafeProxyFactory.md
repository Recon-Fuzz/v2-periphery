# Interface: ISafeProxyFactory

## Metadata

- **Name**: ISafeProxyFactory
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafeProxyFactory.sol

## Public/External Functions

### proxyCreationCode()

- **Signature**: `proxyCreationCode()`
- **Visibility**: external
- **Source Range**: 100:66:179

**Signature:**
```solidity
function proxyCreationCode() external pure returns (bytes memory);;
```

### createProxyWithNonce(address,bytes,uint256)

- **Signature**: `createProxyWithNonce(address,bytes,uint256)`
- **Visibility**: external
- **Source Range**: 172:174:179

**Signature:**
```solidity
function createProxyWithNonce(address _singleton, bytes memory initializer, uint256 saltNonce) external returns (address proxy);;
```

### createChainSpecificProxyWithNonce(address,bytes,uint256)

- **Signature**: `createChainSpecificProxyWithNonce(address,bytes,uint256)`
- **Visibility**: external
- **Source Range**: 352:187:179

**Signature:**
```solidity
function createChainSpecificProxyWithNonce(address _singleton, bytes memory initializer, uint256 saltNonce) external returns (address proxy);;
```

### createProxyWithCallback(address,bytes,uint256,address)

- **Signature**: `createProxyWithCallback(address,bytes,uint256,address)`
- **Visibility**: external
- **Source Range**: 545:203:179

**Signature:**
```solidity
function createProxyWithCallback(address _singleton, bytes memory initializer, uint256 saltNonce, address callback) external returns (address proxy);;
```

### getChainId()

- **Signature**: `getChainId()`
- **Visibility**: external
- **Source Range**: 754:54:179

**Signature:**
```solidity
function getChainId() external view returns (uint256);;
```
