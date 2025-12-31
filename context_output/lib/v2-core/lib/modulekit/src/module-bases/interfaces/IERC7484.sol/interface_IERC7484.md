# Interface: IERC7484

## Metadata

- **Name**: IERC7484
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/interfaces/IERC7484.sol

## Events

### NewTrustedAttesters

```solidity
event NewTrustedAttesters();
```

## Public/External Functions

### check(address)

- **Signature**: `check(address)`
- **Visibility**: external
- **Source Range**: 398:45:216

**Signature:**
```solidity
function check(address module) external view;;
```

### checkForAccount(address,address)

- **Signature**: `checkForAccount(address,address)`
- **Visibility**: external
- **Source Range**: 449:77:216

**Signature:**
```solidity
function checkForAccount(address smartAccount, address module) external view;;
```

### check(address,uint256)

- **Signature**: `check(address,uint256)`
- **Visibility**: external
- **Source Range**: 532:65:216

**Signature:**
```solidity
function check(address module, uint256 moduleType) external view;;
```

### checkForAccount(address,address,uint256)

- **Signature**: `checkForAccount(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 603:143:216

**Signature:**
```solidity
function checkForAccount(address smartAccount, address module, uint256 moduleType) external view;;
```

### trustAttesters(uint8,address[])

- **Signature**: `trustAttesters(uint8,address[])`
- **Visibility**: external
- **Source Range**: 1182:80:216

**Signature:**
```solidity
///  Allows Smart Accounts - the end users of the registry - to appoint
///  one or many attesters as trusted.
///  @dev this function reverts, if address(0), or duplicates are provided in attesters[]
///  @param threshold The minimum number of attestations required for a module
///                   to be considered secure.
///  @param attesters The addresses of the attesters to be trusted.
function trustAttesters(uint8 threshold, address[] calldata attesters) external;;
```

### check(address,address[],uint256)

- **Signature**: `check(address,address[],uint256)`
- **Visibility**: external
- **Source Range**: 1551:94:216

**Signature:**
```solidity
function check(address module, address[] calldata attesters, uint256 threshold) external view;;
```

### check(address,uint256,address[],uint256)

- **Signature**: `check(address,uint256,address[],uint256)`
- **Visibility**: external
- **Source Range**: 1651:168:216

**Signature:**
```solidity
function check(address module, uint256 moduleType, address[] calldata attesters, uint256 threshold) external view;;
```
