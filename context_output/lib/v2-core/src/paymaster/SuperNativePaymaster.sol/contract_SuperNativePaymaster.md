# Contract: SuperNativePaymaster

## Metadata

- **Name**: SuperNativePaymaster
- **Type**: Contract
- **Path**: lib/v2-core/src/paymaster/SuperNativePaymaster.sol
- **Documentation**: @title SuperNativePaymaster
   @author Superform Labs
   @notice A paymaster contract that allows users to pay for their operations with native tokens.
   @dev Inspired by https://github.com/0xPolycode/klaster-smart-contracts/blob/master/contracts/KlasterPaymasterV7.so

## Implements Interfaces

- **ISuperNativePaymaster** [lib/v2-core/src/interfaces/ISuperNativePaymaster.sol/interface_ISuperNativePaymaster.md]
- **IPaymaster** [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IPaymaster.sol/interface_IPaymaster.md]

## State Variables

### entryPoint (inherited from BasePaymaster)

```solidity
IEntryPoint public immutable entryPoint
```

**IEntryPoint**: [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IEntryPoint.sol/interface_IEntryPoint.md]

### PAYMASTER_VALIDATION_GAS_OFFSET (inherited from BasePaymaster)

```solidity
uint256 internal constant PAYMASTER_VALIDATION_GAS_OFFSET = UserOperationLib.PAYMASTER_VALIDATION_GAS_OFFSET
```

### PAYMASTER_POSTOP_GAS_OFFSET (inherited from BasePaymaster)

```solidity
uint256 internal constant PAYMASTER_POSTOP_GAS_OFFSET = UserOperationLib.PAYMASTER_POSTOP_GAS_OFFSET
```

### PAYMASTER_DATA_OFFSET (inherited from BasePaymaster)

```solidity
uint256 internal constant PAYMASTER_DATA_OFFSET = UserOperationLib.PAYMASTER_DATA_OFFSET
```

### MAX_NODE_OPERATOR_PREMIUM

```solidity
uint256 internal constant MAX_NODE_OPERATOR_PREMIUM = 10_000
```

## Errors

### ZERO_ADDRESS (inherited from ISuperNativePaymaster)

```solidity
/// @notice Thrown when a critical address parameter is set to the zero address
///  @dev Used in constructor when validating EntryPoint address
error ZERO_ADDRESS();
```

### EMPTY_MESSAGE_VALUE (inherited from ISuperNativePaymaster)

```solidity
/// @notice Thrown when an operation requires value but none was provided
///  @dev Used when checking for sufficient balance for operations
error EMPTY_MESSAGE_VALUE();
```

### INSUFFICIENT_BALANCE (inherited from ISuperNativePaymaster)

```solidity
/// @notice Thrown when there isn't enough balance to cover an operation
///  @dev Used during handleOps to ensure sufficient funds to execute operations
error INSUFFICIENT_BALANCE();
```

### INVALID_MAX_GAS_LIMIT (inherited from ISuperNativePaymaster)

```solidity
/// @notice Thrown when an invalid gas limit is specified
///  @dev Used to prevent gas limit abuse or errors
error INVALID_MAX_GAS_LIMIT();
```

### INVALID_NODE_OPERATOR_PREMIUM (inherited from ISuperNativePaymaster)

```solidity
/// @notice Thrown when a node operator premium exceeds the maximum allowed
///  @dev Node operator premium is capped at 10,000 basis points (100%)
error INVALID_NODE_OPERATOR_PREMIUM();
```

## Events

### SuperNativePaymasterPostOp (inherited from ISuperNativePaymaster)

```solidity
/// @notice Emitted after a post-operation is completed by the paymaster
///  @dev Includes the context data from the operation for tracking
///  @param context The encoded context data from the operation
event SuperNativePaymasterPostOp(bytes context);
```

### SuperNativePaymasterRefund (inherited from ISuperNativePaymaster)

```solidity
/// @notice Emitted when a refund is sent to an account
///  @dev Refunds are provided when users overpay for gas costs
///  @param sender The address receiving the refund
///  @param refundAmount The amount of native tokens refunded
///  @param initialRefund The initial refund amount before deposit check
event SuperNativePaymasterRefund(address indexed sender, uint256 refundAmount, uint256 initialRefund);
```

### UserOperationsHandled (inherited from ISuperNativePaymaster)

```solidity
/// @notice Emitted when a batch of user operations is handled
///  @param sender The address that handled the operations
///  @param numOps The number of operations handled
///  @param initialAmount The initial amount of native tokens
///  @param withdrawnAmount The amount of native tokens withdrawn
event UserOperationsHandled(address indexed sender, uint256 numOps, uint256 initialAmount, uint256 withdrawnAmount);
```

## Enums

### PostOpMode (inherited from IPaymaster)

```solidity
enum PostOpMode {
    opSucceeded,
    opReverted,
    postOpReverted
}
```

## Public/External Functions

### constructor(contract IEntryPoint)

- **Signature**: `constructor(contract IEntryPoint)`
- **Visibility**: public
- **Source Range**: 1300:75:436
- **Details**: [function_constructor_contract_IEntryPoint.md](./function_constructor_contract_IEntryPoint.md)

**Signature:**
```solidity
constructor(IEntryPoint _entryPoint) payable BasePaymaster(_entryPoint);
```

### calculateRefund(uint256,uint256,uint256,uint256)

- **Signature**: `calculateRefund(uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1608:635:436
- **Details**: [function_calculateRefund_uint256_uint256_uint256_uint256.md](./function_calculateRefund_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperNativePaymaster
function calculateRefund(uint256 maxGasLimit, uint256 maxFeePerGas, uint256 actualGasCost, uint256 nodeOperatorPremium) public pure returns (uint256 refund);
```

### handleOps(struct PackedUserOperation[])

- **Signature**: `handleOps(struct PackedUserOperation[])`
- **Visibility**: public
- **Source Range**: 2479:736:436
- **Details**: [function_handleOps_struct_PackedUserOperation[].md](./function_handleOps_struct_PackedUserOperation[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperNativePaymaster
function handleOps(PackedUserOperation[] calldata ops) public payable;
```

### simulateHandleOp(struct PackedUserOperation,address,bytes)

- **Signature**: `simulateHandleOp(struct PackedUserOperation,address,bytes)`
- **Visibility**: external
- **Source Range**: 3724:573:436
- **Details**: [function_simulateHandleOp_struct_PackedUserOperation_address_bytes.md](./function_simulateHandleOp_struct_PackedUserOperation_address_bytes.md)

**Signature:**
```solidity
/// @notice Simulate the handling of a user operation.
///  @dev used by Bundler to validate a user operation before executing it.
///  @dev `EntryPointSimulations` is not deployed. This works only with an `eth_call` while changing
///       the bytecode of `EntryPoint` with the one from `EntryPointSimulations`.
///  @param op The user operation to simulate.
///  @param target The target address of the user operation.
///  @param callData The call data for the user operation.
function simulateHandleOp(PackedUserOperation calldata op, address target, bytes calldata callData) external payable returns (IEntryPointSimulations.ExecutionResult memory);
```

### simulateValidation(struct PackedUserOperation)

- **Signature**: `simulateValidation(struct PackedUserOperation)`
- **Visibility**: external
- **Source Range**: 4682:489:436
- **Details**: [function_simulateValidation_struct_PackedUserOperation.md](./function_simulateValidation_struct_PackedUserOperation.md)

**Signature:**
```solidity
/// @notice Simulate the validation of a user operation.
///  @dev used by Bundler to validate a user operation before executing it.
///  @dev `EntryPointSimulations` is not deployed. This works only with an `eth_call` while changing
///       the bytecode of `EntryPoint` with the one from `EntryPointSimulations`.
///  @param op The user operation to simulate.
function simulateValidation(PackedUserOperation calldata op) external payable returns (IEntryPointSimulations.ValidationResult memory);
```

### validatePaymasterUserOp(struct PackedUserOperation,bytes32,uint256) (inherited from BasePaymaster)

- **Signature**: `validatePaymasterUserOp(struct PackedUserOperation,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 1781:349:442
- **Details**: [function_validatePaymasterUserOp_struct_PackedUserOperation_bytes32_uint256.md](./function_validatePaymasterUserOp_struct_PackedUserOperation_bytes32_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IPaymaster
function validatePaymasterUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash, uint256 maxCost) override external returns (bytes memory context, uint256 validationData);
```

### postOp(enum IPaymaster.PostOpMode,bytes,uint256,uint256) (inherited from BasePaymaster)

- **Signature**: `postOp(enum IPaymaster.PostOpMode,bytes,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2630:298:442
- **Details**: [function_postOp_enum_IPaymaster.PostOpMode_bytes_uint256_uint256.md](./function_postOp_enum_IPaymaster.PostOpMode_bytes_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IPaymaster
function postOp(PostOpMode mode, bytes calldata context, uint256 actualGasCost, uint256 actualUserOpFeePerGas) override external;
```

### getDeposit() (inherited from BasePaymaster)

- **Signature**: `getDeposit()`
- **Visibility**: public
- **Source Range**: 4413:111:442
- **Details**: [function_getDeposit.md](./function_getDeposit.md)

**Signature:**
```solidity
///  Return current paymaster's deposit on the entryPoint.
function getDeposit() public view returns (uint256);
```
