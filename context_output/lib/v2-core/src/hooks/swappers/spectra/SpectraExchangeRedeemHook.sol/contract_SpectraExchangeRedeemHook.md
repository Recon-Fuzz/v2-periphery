# Contract: SpectraExchangeRedeemHook

## Metadata

- **Name**: SpectraExchangeRedeemHook
- **Type**: Contract
- **Path**: lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeRedeemHook.sol
- **Documentation**: @title SpectraExchangeRedeemHook
   @author Superform Labs
   @dev data has the following structure
   @notice         bytes32 placeholder = bytes32(BytesLib.slice(data, 0, 32), 0);
   @notice         address asset = BytesLib.toAddress(data, 32);
   @notice         address pt = BytesLib.toAddress(data, 52);
   @notice         address recipient = BytesLib.toAddress(data, 72);
   @notice         uint256 minAssets = BytesLib.toUint256(data, 92);
   @notice         uint256 sharesToBurn = BytesLib.toUint256(data, 124);
   @notice         bool usePrevHookAmount = _decodeBool(data, 156);
   @notice         bytes1 command = BytesLib.slice(data, 157, 1);

## Implements Interfaces

- **ISuperHookContextAware** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookContextAware.md]
- **ISuperHookInspector** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookInspector.md]
- **ISuperHookResult** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookResult.md]
- **ISuperHookSetter** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookSetter.md]
- **ISuperHook** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHook.md]

## State Variables

### usedShares (inherited from BaseHook)

```solidity
/// @notice The number of shares used by this hook's operation
///  @dev Used for accounting and tracking consumption of position shares
uint256 public transient usedShares
```

### spToken (inherited from BaseHook)

```solidity
/// @notice The special token address (if any) associated with this hook's operation
///  @dev May be used to track token addresses for various operations
address public transient spToken
```

### asset (inherited from BaseHook)

```solidity
/// @notice The primary asset address this hook operates on
///  @dev Typically the base token or asset being processed
address public transient asset
```

### executionNonce (inherited from BaseHook)

```solidity
/// @notice Execution nonce for creating unique contexts
uint256 public transient executionNonce
```

### lastCaller (inherited from BaseHook)

```solidity
/// @notice Last execution context caller
address public transient lastCaller
```

### OUT_AMOUNT_OFFSET (inherited from BaseHook)

```solidity
uint256 private constant OUT_AMOUNT_OFFSET = 1
```

### PRE_EXECUTE_MUTEX_OFFSET (inherited from BaseHook)

```solidity
uint256 private constant PRE_EXECUTE_MUTEX_OFFSET = 2
```

### POST_EXECUTE_MUTEX_OFFSET (inherited from BaseHook)

```solidity
uint256 private constant POST_EXECUTE_MUTEX_OFFSET = 3
```

### HOOK_EXECUTION_STORAGE (inherited from BaseHook)

```solidity
/// @notice Base storage key for hook execution state
bytes32 private constant HOOK_EXECUTION_STORAGE = keccak256("hook.execution.state")
```

### ACCOUNT_CONTEXT_STORAGE (inherited from BaseHook)

```solidity
/// @notice Storage key for account context mapping
bytes32 private constant ACCOUNT_CONTEXT_STORAGE = keccak256("hook.account.context")
```

### SUB_TYPE (inherited from BaseHook)

```solidity
/// @notice The specific subtype identifier for this hook
///  @dev Used to identify specialized hook types beyond the basic HookType enum
bytes32 public immutable SUB_TYPE
```

### hookType (inherited from BaseHook)

```solidity
/// @notice The type of hook (NONACCOUNTING, INFLOW, OUTFLOW)
///  @dev Determines how the hook impacts accounting in the system
ISuperHook.HookType public hookType
```

### USE_PREV_HOOK_AMOUNT_POSITION

```solidity
uint256 private constant USE_PREV_HOOK_AMOUNT_POSITION = 156
```

### SHARES_POSITION

```solidity
uint256 private constant SHARES_POSITION = 124
```

### REDEEM_IBT_FOR_ASSET

```solidity
bytes1 public constant REDEEM_IBT_FOR_ASSET = bytes1(uint8(SpectraCommands.REDEEM_IBT_FOR_ASSET))
```

### REDEEM_PT_FOR_ASSET

```solidity
bytes1 public constant REDEEM_PT_FOR_ASSET = bytes1(uint8(SpectraCommands.REDEEM_PT_FOR_ASSET))
```

### SELECTOR

```solidity
bytes4 public constant SELECTOR = bytes4(keccak256("execute(bytes,bytes[])"))
```

### ROUTER

```solidity
address public immutable ROUTER
```

## Structs

### RedeemParams

```solidity
struct RedeemParams {
    address pt;
    address asset;
    address recipient;
    uint256 minAssets;
    uint256 sharesToBurn;
    bool usePrevHookAmount;
    bytes1 command;
}
```

## Errors

### NOT_AUTHORIZED (inherited from BaseHook)

```solidity
/// @notice Thrown when a caller attempts to execute hook methods without proper authorization
///  @dev Used by security validation to prevent unauthorized hook execution
error NOT_AUTHORIZED();
```

### AMOUNT_NOT_VALID (inherited from BaseHook)

```solidity
/// @notice Thrown when an amount parameter is invalid (e.g., zero or overflow)
///  @dev Used in validation checks for asset amounts and share values
error AMOUNT_NOT_VALID();
```

### ADDRESS_NOT_VALID (inherited from BaseHook)

```solidity
/// @notice Thrown when an address parameter is invalid (e.g., zero address)
///  @dev Used in validation checks for tokens, accounts, and other addresses
error ADDRESS_NOT_VALID();
```

### UNAUTHORIZED_CALLER (inherited from BaseHook)

```solidity
/// @notice Thrown when a caller is not authorized to execute hook methods
///  @dev Used by security validation to prevent unauthorized hook execution
error UNAUTHORIZED_CALLER();
```

### PRE_EXECUTE_ALREADY_CALLED (inherited from BaseHook)

```solidity
/// @notice Thrown when preExecute is called more than once
///  @dev Used to prevent reentrancy attacks and ensure proper execution flow
error PRE_EXECUTE_ALREADY_CALLED();
```

### POST_EXECUTE_ALREADY_CALLED (inherited from BaseHook)

```solidity
/// @notice Thrown when postExecute is called more than once
///  @dev Used to prevent reentrancy attacks and ensure proper execution flow
error POST_EXECUTE_ALREADY_CALLED();
```

### INCOMPLETE_HOOK_EXECUTION (inherited from BaseHook)

```solidity
/// @notice Thrown when a hook execution is incomplete
///  @dev Used to prevent incomplete hook execution
error INCOMPLETE_HOOK_EXECUTION();
```

### CANNOT_SET_OUT_AMOUNT (inherited from BaseHook)

```solidity
/// @notice Thrown when trying to set outAmount after preExecute or postExecute
///  @dev Used to prevent setting outAmount after preExecute or postExecute
error CANNOT_SET_OUT_AMOUNT();
```

### INVALID_PT

```solidity
error INVALID_PT();
```

### INVALID_ASSET

```solidity
error INVALID_ASSET();
```

### INVALID_COMMAND

```solidity
error INVALID_COMMAND();
```

### INVALID_RECIPIENT

```solidity
error INVALID_RECIPIENT();
```

### INVALID_MIN_ASSETS

```solidity
error INVALID_MIN_ASSETS();
```

## Enums

### HookType (inherited from ISuperHook)

```solidity
/// @notice Defines the possible types of hooks in the system
///  @dev Used to determine how the hook affects accounting and what operations it performs
enum HookType {
    NONACCOUNTING,
    INFLOW,
    OUTFLOW
}
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2663:177:393
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address router_) BaseHook(HookType.NONACCOUNTING,HookSubTypes.PTYT);
```

### decodeUsePrevHookAmount(bytes)

- **Signature**: `decodeUsePrevHookAmount(bytes)`
- **Visibility**: external
- **Source Range**: 4936:153:393
- **Details**: [function_decodeUsePrevHookAmount_bytes.md](./function_decodeUsePrevHookAmount_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHookContextAware
function decodeUsePrevHookAmount(bytes memory data) external pure returns (bool);
```

### inspect(bytes)

- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 5135:232:393
- **Details**: [function_inspect_bytes.md](./function_inspect_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory);
```

### setExecutionContext(address) (inherited from BaseHook)

- **Signature**: `setExecutionContext(address)`
- **Visibility**: external
- **Source Range**: 5193:135:364
- **Details**: [function_setExecutionContext_address.md](./function_setExecutionContext_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function setExecutionContext(address caller) external;
```

### build(address,address,bytes) (inherited from BaseHook)

- **Signature**: `build(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 5451:1084:364
- **Details**: [function_build_address_address_bytes.md](./function_build_address_address_bytes.md)

**Signature:**
```solidity
/// @dev Standard build pattern - MUST include preExecute first, postExecute last
///  @inheritdoc ISuperHook
function build(address prevHook, address account, bytes calldata hookData) virtual external view returns (Execution[] memory executions);
```

### preExecute(address,address,bytes) (inherited from BaseHook)

- **Signature**: `preExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 6572:390:364
- **Details**: [function_preExecute_address_address_bytes.md](./function_preExecute_address_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function preExecute(address prevHook, address account, bytes calldata data) external;
```

### postExecute(address,address,bytes) (inherited from BaseHook)

- **Signature**: `postExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 6999:395:364
- **Details**: [function_postExecute_address_address_bytes.md](./function_postExecute_address_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function postExecute(address prevHook, address account, bytes calldata data) external;
```

### setOutAmount(uint256,address) (inherited from BaseHook)

- **Signature**: `setOutAmount(uint256,address)`
- **Visibility**: external
- **Source Range**: 7437:394:364
- **Details**: [function_setOutAmount_uint256_address.md](./function_setOutAmount_uint256_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHookSetter
function setOutAmount(uint256 _outAmount, address caller) external;
```

### getOutAmount(address) (inherited from BaseHook)

- **Signature**: `getOutAmount(address)`
- **Visibility**: public
- **Source Range**: 7837:142:364
- **Details**: [function_getOutAmount_address.md](./function_getOutAmount_address.md)

**Signature:**
```solidity
function getOutAmount(address caller) public view returns (uint256);
```

### resetExecutionState(address) (inherited from BaseHook)

- **Signature**: `resetExecutionState(address)`
- **Visibility**: external
- **Source Range**: 8016:316:364
- **Details**: [function_resetExecutionState_address.md](./function_resetExecutionState_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function resetExecutionState(address caller) external onlyLastCaller();
```

### subtype() (inherited from BaseHook)

- **Signature**: `subtype()`
- **Visibility**: external
- **Source Range**: 8553:83:364
- **Details**: [function_subtype.md](./function_subtype.md)

**Signature:**
```solidity
/// @inheritdoc ISuperHook
function subtype() external view returns (bytes32);
```
