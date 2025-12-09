# Contract: SuperBank

## Metadata

- **Name**: SuperBank
- **Type**: Contract
- **Path**: src/SuperBank.sol
- **Documentation**: @title SuperBank
   @notice Compounds protocol revenue into UP and distributes it to sUP and treasury.

## Implements Interfaces

- **ISuperBank** [src/interfaces/ISuperBank.sol/interface_ISuperBank.md]
- **IHookExecutionData** [src/interfaces/IHookExecutionData.sol/interface_IHookExecutionData.md]

## State Variables

### NOT_ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant NOT_ENTERED = 1
```

### ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant ENTERED = 2
```

### _status (inherited from ReentrancyGuard)

```solidity
uint256 private _status
```

### BPS_PRECISION

```solidity
uint256 private constant BPS_PRECISION = 10_000
```

### SUPER_GOVERNOR

```solidity
ISuperGovernor public immutable SUPER_GOVERNOR
```

**ISuperGovernor**: [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## Structs

### HookExecutionData (inherited from IHookExecutionData)

```solidity
/// @notice Data required for executing hooks with Merkle proof verification.
///  @param hooks Array of addresses of hooks to execute.
///  @param data Array of arbitrary data to pass to each hook.
///  @param merkleProofs Double array of Merkle proofs verifying each hook's allowed targets.
///  @param expectedAssetsOrSharesOut Array of minimum expected output amounts for slippage protection.
struct HookExecutionData {
    address[] hooks;
    bytes[] data;
    bytes32[][] merkleProofs;
    uint256[] expectedAssetsOrSharesOut;
}
```

## Errors

### INVALID_ADDRESS (inherited from ISuperBank)

```solidity
/// @notice Error thrown when an invalid address is provided.
error INVALID_ADDRESS();
```

### TRANSFER_FAILED (inherited from ISuperBank)

```solidity
/// @notice Error thrown when a transfer fails.
error TRANSFER_FAILED();
```

### INVALID_UP_AMOUNT_TO_DISTRIBUTE (inherited from ISuperBank)

```solidity
/// @notice Error thrown when an invalid UP amount is provided.
error INVALID_UP_AMOUNT_TO_DISTRIBUTE();
```

### INVALID_BANK_MANAGER (inherited from ISuperBank)

```solidity
/// @notice Error thrown when an invalid bank manager is provided.
error INVALID_BANK_MANAGER();
```

### INVALID_REVENUE_SHARE (inherited from ISuperBank)

```solidity
/// @notice Error thrown when revenue share exceeds maximum allowed (BPS_PRECISION).
error INVALID_REVENUE_SHARE();
```

### ReentrancyGuardReentrantCall (inherited from ReentrancyGuard)

```solidity
///  @dev Unauthorized reentrant call.
error ReentrancyGuardReentrantCall();
```

### INVALID_HOOK (inherited from Bank)

```solidity
error INVALID_HOOK();
```

### INVALID_MERKLE_PROOF (inherited from Bank)

```solidity
error INVALID_MERKLE_PROOF();
```

### HOOK_VALIDATION_FAILED (inherited from Bank)

```solidity
error HOOK_VALIDATION_FAILED();
```

### HOOK_EXECUTION_FAILED (inherited from Bank)

```solidity
error HOOK_EXECUTION_FAILED();
```

### HOOK_NOT_REGISTERED (inherited from Bank)

```solidity
error HOOK_NOT_REGISTERED();
```

### ZERO_LENGTH_ARRAY (inherited from Bank)

```solidity
error ZERO_LENGTH_ARRAY();
```

### ZERO_AMOUNT (inherited from Bank)

```solidity
error ZERO_AMOUNT();
```

### INVALID_ARRAY_LENGTH (inherited from Bank)

```solidity
error INVALID_ARRAY_LENGTH();
```

### ZERO_ADDRESS (inherited from Bank)

```solidity
error ZERO_ADDRESS();
```

### MINIMUM_OUTPUT_AMOUNT_NOT_MET (inherited from Bank)

```solidity
error MINIMUM_OUTPUT_AMOUNT_NOT_MET();
```

## Events

### RevenueDistributed (inherited from ISuperBank)

```solidity
/// @notice Emitted when revenue is distributed to sUP and Treasury.
///  @param upToken The address of the UP token.
///  @param supStrategyVault The address of the sUP strategy.
///  @param treasury The address of the Treasury.
///  @param supAmount The amount sent to sUP.
///  @param treasuryAmount The amount sent to Treasury.
event RevenueDistributed(address indexed upToken, address indexed supStrategyVault, address indexed treasury, uint256 supAmount, uint256 treasuryAmount);
```

### HooksExecuted (inherited from Bank)

```solidity
/// @notice Emitted when hooks are executed.
///  @param hooks The addresses of the hooks that were executed.
///  @param data The data passed to each hook.
event HooksExecuted(address[] hooks, bytes[] data);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 890:168:508
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address superGovernor_);
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 1631:30:508
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
receive() external payable;
```

### distribute(uint256)

- **Signature**: `distribute(uint256)`
- **Visibility**: external
- **Source Range**: 1698:1522:508
- **Details**: [function_distribute_uint256.md](./function_distribute_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperBank
function distribute(uint256 upAmount) external onlyBankManager();
```

### executeHooks(struct IHookExecutionData.HookExecutionData)

- **Signature**: `executeHooks(struct IHookExecutionData.HookExecutionData)`
- **Visibility**: external
- **Source Range**: 3257:153:508
- **Details**: [function_executeHooks_struct_IHookExecutionData.HookExecutionData.md](./function_executeHooks_struct_IHookExecutionData.HookExecutionData.md)

**Signature:**
```solidity
/// @inheritdoc ISuperBank
function executeHooks(ISuperBank.HookExecutionData calldata executionData) external payable onlyBankManager();
```
