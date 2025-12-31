# Interface: IERC7540Like

## Metadata

- **Name**: IERC7540Like
- **Type**: Interface
- **Path**: lib/erc7540-reusable-properties/src/ERC7540Properties.sol

## Public/External Functions

### share()

- **Signature**: `share()`
- **Visibility**: external
- **Source Range**: 350:67:10

**Signature:**
```solidity
function share() external view returns (address shareTokenAddress);;
```

### convertToShares(uint256)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: external
- **Source Range**: 422:94:10

**Signature:**
```solidity
function convertToShares(uint256 assets) external view returns (uint256 shares);;
```

### convertToAssets(uint256)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: external
- **Source Range**: 521:94:10

**Signature:**
```solidity
function convertToAssets(uint256 shares) external view returns (uint256 assets);;
```

### totalAssets()

- **Signature**: `totalAssets()`
- **Visibility**: external
- **Source Range**: 620:74:10

**Signature:**
```solidity
function totalAssets() external view returns (uint256 totalManagedAssets);;
```

### maxDeposit(address)

- **Signature**: `maxDeposit(address)`
- **Visibility**: external
- **Source Range**: 699:94:10

**Signature:**
```solidity
function maxDeposit(address receiver) external view returns (uint256 maxAssets);;
```

### previewDeposit(uint256)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: external
- **Source Range**: 798:93:10

**Signature:**
```solidity
function previewDeposit(uint256 assets) external view returns (uint256 shares);;
```

### deposit(uint256,address)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: external
- **Source Range**: 896:107:10

**Signature:**
```solidity
function deposit(uint256 assets, address receiver) external returns (uint256 shares);;
```

### maxMint(address)

- **Signature**: `maxMint(address)`
- **Visibility**: external
- **Source Range**: 1008:91:10

**Signature:**
```solidity
function maxMint(address receiver) external view returns (uint256 maxShares);;
```

### previewMint(uint256)

- **Signature**: `previewMint(uint256)`
- **Visibility**: external
- **Source Range**: 1104:76:10

**Signature:**
```solidity
function previewMint(uint256 shares) external view returns (uint256 assets);;
```

### mint(uint256,address)

- **Signature**: `mint(uint256,address)`
- **Visibility**: external
- **Source Range**: 1185:104:10

**Signature:**
```solidity
function mint(uint256 shares, address receiver) external returns (uint256 assets);;
```

### maxWithdraw(address)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: external
- **Source Range**: 1294:92:10

**Signature:**
```solidity
function maxWithdraw(address owner) external view returns (uint256 maxAssets);;
```

### previewWithdraw(uint256)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: external
- **Source Range**: 1391:94:10

**Signature:**
```solidity
function previewWithdraw(uint256 assets) external view returns (uint256 shares);;
```

### withdraw(uint256,address,address)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 1490:131:10

**Signature:**
```solidity
function withdraw(uint256 assets, address receiver, address owner) external returns (uint256 shares);;
```

### maxRedeem(address)

- **Signature**: `maxRedeem(address)`
- **Visibility**: external
- **Source Range**: 1626:76:10

**Signature:**
```solidity
function maxRedeem(address owner) external view returns (uint256 maxShares);;
```

### previewRedeem(uint256)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: external
- **Source Range**: 1707:92:10

**Signature:**
```solidity
function previewRedeem(uint256 shares) external view returns (uint256 assets);;
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 1804:129:10

**Signature:**
```solidity
function redeem(uint256 shares, address receiver, address owner) external returns (uint256 assets);;
```

### requestRedeem(uint256,address,address,bytes)

- **Signature**: `requestRedeem(uint256,address,address,bytes)`
- **Visibility**: external
- **Source Range**: 1939:168:10

**Signature:**
```solidity
function requestRedeem(uint256 shares, address receiver, address owner, bytes calldata data) external returns (uint256 requestId);;
```
