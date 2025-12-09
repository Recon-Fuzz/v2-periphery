# Contract: MockHook

## Metadata

- **Name**: MockHook
- **Type**: Contract
- **Path**: test/mocks/MockHook.sol

## Implements Interfaces

- **ISuperHookResultOutflow** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookResultOutflow.md]
- **ISuperHookResult** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookResult.md]
- **ISuperHook** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHook.md]

## State Variables

### hookType

```solidity
HookType public hookType
```

### outAmount

```solidity
uint256 public outAmount
```

### usedShares

```solidity
uint256 public usedShares
```

### asset

```solidity
address public asset
```

### preExecuteCalled

```solidity
bool public preExecuteCalled
```

### postExecuteCalled

```solidity
bool public postExecuteCalled
```

### executions

```solidity
Execution[] public executions
```

### preExecuteMutex

```solidity
bool public preExecuteMutex
```

### postExecuteMutex

```solidity
bool public postExecuteMutex
```

### caller

```solidity
address public caller
```

## Errors

### INCOMPLETE_HOOK_EXECUTION

```solidity
error INCOMPLETE_HOOK_EXECUTION();
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

### constructor(enum ISuperHook.HookType,address)

- **Signature**: `constructor(enum ISuperHook.HookType,address)`
- **Visibility**: public
- **Source Range**: 644:109:593
- **Details**: [function_constructor_enum_ISuperHook.HookType_address.md](./function_constructor_enum_ISuperHook.HookType_address.md)

**Signature:**
```solidity
constructor(HookType _hookType, address _asset);
```

### subtype()

- **Signature**: `subtype()`
- **Visibility**: external
- **Source Range**: 759:90:593
- **Details**: [function_subtype.md](./function_subtype.md)

**Signature:**
```solidity
function subtype() external pure returns (bytes32);
```

### setOutAmount(uint256,address)

- **Signature**: `setOutAmount(uint256,address)`
- **Visibility**: external
- **Source Range**: 855:99:593
- **Details**: [function_setOutAmount_uint256_address.md](./function_setOutAmount_uint256_address.md)

**Signature:**
```solidity
function setOutAmount(uint256 _outAmount, address) external;
```

### getOutAmount(address)

- **Signature**: `getOutAmount(address)`
- **Visibility**: external
- **Source Range**: 960:96:593
- **Details**: [function_getOutAmount_address.md](./function_getOutAmount_address.md)

**Signature:**
```solidity
function getOutAmount(address) external view returns (uint256);
```

### setUsedShares(uint256)

- **Signature**: `setUsedShares(uint256)`
- **Visibility**: external
- **Source Range**: 1062:94:593
- **Details**: [function_setUsedShares_uint256.md](./function_setUsedShares_uint256.md)

**Signature:**
```solidity
function setUsedShares(uint256 _usedShares) external;
```

### setExecutions(struct Execution[])

- **Signature**: `setExecutions(struct Execution[])`
- **Visibility**: external
- **Source Range**: 1162:212:593
- **Details**: [function_setExecutions_struct_Execution[].md](./function_setExecutions_struct_Execution[].md)

**Signature:**
```solidity
function setExecutions(Execution[] memory _executions) external;
```

### setAsset(address)

- **Signature**: `setAsset(address)`
- **Visibility**: external
- **Source Range**: 1380:74:593
- **Details**: [function_setAsset_address.md](./function_setAsset_address.md)

**Signature:**
```solidity
function setAsset(address _asset) external;
```

### preExecute(address,address,bytes)

- **Signature**: `preExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 1460:110:593
- **Details**: [function_preExecute_address_address_bytes.md](./function_preExecute_address_address_bytes.md)

**Signature:**
```solidity
function preExecute(address, address, bytes memory) override external;
```

### build(address,address,bytes)

- **Signature**: `build(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 1693:1042:593
- **Details**: [function_build_address_address_bytes.md](./function_build_address_address_bytes.md)

**Signature:**
```solidity
/// @dev Standard build pattern - MUST include preExecute first, postExecute last
///  @inheritdoc ISuperHook
function build(address prevHook, address account, bytes calldata hookData) virtual external view returns (Execution[] memory _executions);
```

### postExecute(address,address,bytes)

- **Signature**: `postExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 3063:112:593
- **Details**: [function_postExecute_address_address_bytes.md](./function_postExecute_address_address_bytes.md)

**Signature:**
```solidity
function postExecute(address, address, bytes memory) override external;
```

### lockForSP()

- **Signature**: `lockForSP()`
- **Visibility**: external
- **Source Range**: 3181:79:593
- **Details**: [function_lockForSP.md](./function_lockForSP.md)

**Signature:**
```solidity
function lockForSP() external pure returns (bool);
```

### spToken()

- **Signature**: `spToken()`
- **Visibility**: external
- **Source Range**: 3266:94:593
- **Details**: [function_spToken.md](./function_spToken.md)

**Signature:**
```solidity
function spToken() override external pure returns (address);
```

### vaultBank()

- **Signature**: `vaultBank()`
- **Visibility**: public
- **Source Range**: 3366:85:593
- **Details**: [function_vaultBank.md](./function_vaultBank.md)

**Signature:**
```solidity
function vaultBank() public pure returns (address);
```

### dstChainId()

- **Signature**: `dstChainId()`
- **Visibility**: public
- **Source Range**: 3457:77:593
- **Details**: [function_dstChainId.md](./function_dstChainId.md)

**Signature:**
```solidity
function dstChainId() public pure returns (uint256);
```

### resetExecutionState(address)

- **Signature**: `resetExecutionState(address)`
- **Visibility**: external
- **Source Range**: 3624:151:593
- **Details**: [function_resetExecutionState_address.md](./function_resetExecutionState_address.md)

**Signature:**
```solidity
/// @notice Resets execution state - ONLY callable by executor after accounting
function resetExecutionState(address) external;
```

### setExecutionContext(address)

- **Signature**: `setExecutionContext(address)`
- **Visibility**: external
- **Source Range**: 3781:88:593
- **Details**: [function_setExecutionContext_address.md](./function_setExecutionContext_address.md)

**Signature:**
```solidity
function setExecutionContext(address _caller) external;
```

### executionNonce()

- **Signature**: `executionNonce()`
- **Visibility**: external
- **Source Range**: 3875:83:593
- **Details**: [function_executionNonce.md](./function_executionNonce.md)

**Signature:**
```solidity
function executionNonce() external pure returns (uint256);
```

### lastCaller()

- **Signature**: `lastCaller()`
- **Visibility**: external
- **Source Range**: 3964:88:593
- **Details**: [function_lastCaller.md](./function_lastCaller.md)

**Signature:**
```solidity
function lastCaller() external view returns (address);
```
