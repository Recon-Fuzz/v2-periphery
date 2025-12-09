# Contract: MockRegistry

## Metadata

- **Name**: MockRegistry
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/mocks/MockRegistry.sol
- **Documentation**: @title MockRegistry
   @author zeroknots

## Implements Interfaces

- **IERC7484** [lib/v2-core/lib/modulekit/src/module-bases/interfaces/IERC7484.sol/interface_IERC7484.md]

## Events

### NewTrustedAttesters (inherited from IERC7484)

```solidity
event NewTrustedAttesters();
```

## Public/External Functions

### check(address)

- **Signature**: `check(address)`
- **Visibility**: external
- **Source Range**: 489:48:225
- **Details**: [function_check_address.md](./function_check_address.md)

**Signature:**
```solidity
function check(address module) external view;
```

### checkForAccount(address,address)

- **Signature**: `checkForAccount(address,address)`
- **Visibility**: external
- **Source Range**: 543:80:225
- **Details**: [function_checkForAccount_address_address.md](./function_checkForAccount_address_address.md)

**Signature:**
```solidity
function checkForAccount(address smartAccount, address module) external view;
```

### check(address,uint256)

- **Signature**: `check(address,uint256)`
- **Visibility**: external
- **Source Range**: 629:68:225
- **Details**: [function_check_address_uint256.md](./function_check_address_uint256.md)

**Signature:**
```solidity
function check(address module, uint256 moduleType) external view;
```

### checkForAccount(address,address,uint256)

- **Signature**: `checkForAccount(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 703:150:225
- **Details**: [function_checkForAccount_address_address_uint256.md](./function_checkForAccount_address_address_uint256.md)

**Signature:**
```solidity
function checkForAccount(address smartAccount, address module, uint256 moduleType) external view;
```

### check(address,address[],uint256)

- **Signature**: `check(address,address[],uint256)`
- **Visibility**: external
- **Source Range**: 1142:97:225
- **Details**: [function_check_address_address[]_uint256.md](./function_check_address_address[]_uint256.md)

**Signature:**
```solidity
function check(address module, address[] calldata attesters, uint256 threshold) external view;
```

### check(address,uint256,address[],uint256)

- **Signature**: `check(address,uint256,address[],uint256)`
- **Visibility**: external
- **Source Range**: 1245:175:225
- **Details**: [function_check_address_uint256_address[]_uint256.md](./function_check_address_uint256_address[]_uint256.md)

**Signature:**
```solidity
function check(address module, uint256 moduleType, address[] calldata attesters, uint256 threshold) external view;
```

### trustAttesters(uint8,address[])

- **Signature**: `trustAttesters(uint8,address[])`
- **Visibility**: external
- **Source Range**: 1426:83:225
- **Details**: [function_trustAttesters_uint8_address[].md](./function_trustAttesters_uint8_address[].md)

**Signature:**
```solidity
function trustAttesters(uint8 threshold, address[] calldata attesters) external;
```
