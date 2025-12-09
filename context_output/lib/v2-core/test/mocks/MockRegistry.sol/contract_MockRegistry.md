# Contract: MockRegistry

## Metadata

- **Name**: MockRegistry
- **Type**: Contract
- **Path**: lib/v2-core/test/mocks/MockRegistry.sol

## Implements Interfaces

- **IERC7484** [lib/v2-core/src/vendor/nexus/IERC7484.sol/interface_IERC7484.md]

## Events

### NewTrustedAttesters (inherited from IERC7484)

```solidity
event NewTrustedAttesters();
```

### Log

```solidity
event Log(address sender);
```

## Public/External Functions

### check(address)

- **Signature**: `check(address)`
- **Visibility**: external
- **Source Range**: 194:48:486
- **Details**: [function_check_address.md](./function_check_address.md)

**Signature:**
```solidity
function check(address module) external view;
```

### checkForAccount(address,address)

- **Signature**: `checkForAccount(address,address)`
- **Visibility**: external
- **Source Range**: 248:80:486
- **Details**: [function_checkForAccount_address_address.md](./function_checkForAccount_address_address.md)

**Signature:**
```solidity
function checkForAccount(address smartAccount, address module) external view;
```

### check(address,uint256)

- **Signature**: `check(address,uint256)`
- **Visibility**: external
- **Source Range**: 334:68:486
- **Details**: [function_check_address_uint256.md](./function_check_address_uint256.md)

**Signature:**
```solidity
function check(address module, uint256 moduleType) external view;
```

### checkForAccount(address,address,uint256)

- **Signature**: `checkForAccount(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 408:109:486
- **Details**: [function_checkForAccount_address_address_uint256.md](./function_checkForAccount_address_address_uint256.md)

**Signature:**
```solidity
function checkForAccount(address smartAccount, address module, uint256 moduleType) override external view;
```

### check(address,address[],uint256)

- **Signature**: `check(address,address[],uint256)`
- **Visibility**: external
- **Source Range**: 523:97:486
- **Details**: [function_check_address_address[]_uint256.md](./function_check_address_address[]_uint256.md)

**Signature:**
```solidity
function check(address module, address[] calldata attesters, uint256 threshold) external view;
```

### check(address,uint256,address[],uint256)

- **Signature**: `check(address,uint256,address[],uint256)`
- **Visibility**: external
- **Source Range**: 626:117:486
- **Details**: [function_check_address_uint256_address[]_uint256.md](./function_check_address_uint256_address[]_uint256.md)

**Signature:**
```solidity
function check(address module, uint256 moduleType, address[] calldata attesters, uint256 threshold) external view;
```

### trustAttesters(uint8,address[])

- **Signature**: `trustAttesters(uint8,address[])`
- **Visibility**: external
- **Source Range**: 749:133:486
- **Details**: [function_trustAttesters_uint8_address[].md](./function_trustAttesters_uint8_address[].md)

**Signature:**
```solidity
function trustAttesters(uint8, address[] calldata) external;
```
