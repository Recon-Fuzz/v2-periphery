# Contract: MockPolicy

## Metadata

- **Name**: MockPolicy
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/mocks/MockPolicy.sol

## State Variables

### validationData

```solidity
mapping(address => uint256) public validationData
```

### userOpState

```solidity
mapping(bytes32 => mapping(address => mapping(address => uint256))) public userOpState
```

### actionState

```solidity
mapping(bytes32 => mapping(address => mapping(address => uint256))) public actionState
```

## Public/External Functions

### setValidationData(address,uint256)

- **Signature**: `setValidationData(address,uint256)`
- **Visibility**: external
- **Source Range**: 560:126:224
- **Details**: [function_setValidationData_address_uint256.md](./function_setValidationData_address_uint256.md)

**Signature:**
```solidity
function setValidationData(address account, uint256 validation) external;
```

### initializeWithMultiplexer(address,bytes32,bytes)

- **Signature**: `initializeWithMultiplexer(address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 692:200:224
- **Details**: [function_initializeWithMultiplexer_address_bytes32_bytes.md](./function_initializeWithMultiplexer_address_bytes32_bytes.md)

**Signature:**
```solidity
function initializeWithMultiplexer(address account, bytes32 configId, bytes calldata) external;
```

### checkUserOpPolicy(bytes32,struct PackedUserOperation)

- **Signature**: `checkUserOpPolicy(bytes32,struct PackedUserOperation)`
- **Visibility**: external
- **Source Range**: 898:255:224
- **Details**: [function_checkUserOpPolicy_bytes32_struct_PackedUserOperation.md](./function_checkUserOpPolicy_bytes32_struct_PackedUserOperation.md)

**Signature:**
```solidity
function checkUserOpPolicy(bytes32 id, PackedUserOperation calldata userOp) external returns (uint256);
```

### checkAction(bytes32,address,address,uint256,bytes)

- **Signature**: `checkAction(bytes32,address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 1159:275:224
- **Details**: [function_checkAction_bytes32_address_address_uint256_bytes.md](./function_checkAction_bytes32_address_address_uint256_bytes.md)

**Signature:**
```solidity
function checkAction(bytes32 id, address account, address, uint256, bytes calldata) external returns (uint256);
```

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 1440:92:224
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
function supportsInterface(bytes4) external pure returns (bool);
```

### check1271SignedAction(bytes32,address,address,bytes32,bytes)

- **Signature**: `check1271SignedAction(bytes32,address,address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 1538:214:224
- **Details**: [function_check1271SignedAction_bytes32_address_address_bytes32_bytes.md](./function_check1271SignedAction_bytes32_address_address_bytes32_bytes.md)

**Signature:**
```solidity
function check1271SignedAction(bytes32, address, address, bytes32, bytes calldata) external pure returns (bool);
```
