# Contract: MockHook

## Metadata

- **Name**: MockHook
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHook.sol

## Implements Interfaces

- **IHook** [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Module.sol/interface_IHook.md]
- **IModule** [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Module.sol/interface_IModule.md]

## State Variables

### TYPE_VALIDATOR (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_VALIDATOR = MODULE_TYPE_VALIDATOR
```

### TYPE_EXECUTOR (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_EXECUTOR = MODULE_TYPE_EXECUTOR
```

### TYPE_FALLBACK (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_FALLBACK = MODULE_TYPE_FALLBACK
```

### TYPE_HOOK (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_HOOK = MODULE_TYPE_HOOK
```

### TYPE_POLICY (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_POLICY = MODULE_TYPE_POLICY
```

### TYPE_SIGNER (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_SIGNER = MODULE_TYPE_SIGNER
```

### TYPE_STATELESS_VALIDATOR (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_STATELESS_VALIDATOR = MODULE_TYPE_STATELESS_VALIDATOR
```

### trustedForwarder (inherited from TrustedForwarder)

```solidity
mapping(address => address) public trustedForwarder
```

## Errors

### ModuleAlreadyInitialized (inherited from IModule)

```solidity
error ModuleAlreadyInitialized(address smartAccount);
```

### NotInitialized (inherited from IModule)

```solidity
error NotInitialized(address smartAccount);
```

## Public/External Functions

### onInstall(bytes)

- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 167:61:221
- **Details**: [function_onInstall_bytes.md](./function_onInstall_bytes.md)

**Signature:**
```solidity
function onInstall(bytes calldata data) override external;
```

### onUninstall(bytes)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 234:63:221
- **Details**: [function_onUninstall_bytes.md](./function_onUninstall_bytes.md)

**Signature:**
```solidity
function onUninstall(bytes calldata data) override external;
```

### isInitialized(address)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 613:148:221
- **Details**: [function_isInitialized_address.md](./function_isInitialized_address.md)

**Signature:**
```solidity
function isInitialized(address) external pure returns (bool);
```

### isModuleType(uint256)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 767:110:221
- **Details**: [function_isModuleType_uint256.md](./function_isModuleType_uint256.md)

**Signature:**
```solidity
function isModuleType(uint256 typeID) external pure returns (bool);
```

### setTrustedForwarder(address) (inherited from TrustedForwarder)

- **Signature**: `setTrustedForwarder(address)`
- **Visibility**: external
- **Source Range**: 366:114:230
- **Details**: [function_setTrustedForwarder_address.md](./function_setTrustedForwarder_address.md)

**Signature:**
```solidity
///  Set the trusted forwarder for an account
///  @param forwarder The address of the trusted forwarder
function setTrustedForwarder(address forwarder) external;
```

### clearTrustedForwarder() (inherited from TrustedForwarder)

- **Signature**: `clearTrustedForwarder()`
- **Visibility**: public
- **Source Range**: 552:98:230
- **Details**: [function_clearTrustedForwarder.md](./function_clearTrustedForwarder.md)

**Signature:**
```solidity
///  Clear the trusted forwarder for an account
function clearTrustedForwarder() public;
```

### isTrustedForwarder(address,address) (inherited from TrustedForwarder)

- **Signature**: `isTrustedForwarder(address,address)`
- **Visibility**: public
- **Source Range**: 906:153:230
- **Details**: [function_isTrustedForwarder_address_address.md](./function_isTrustedForwarder_address_address.md)

**Signature:**
```solidity
///  Check if a forwarder is trusted for an account
///  @param forwarder The address of the forwarder
///  @param account The address of the account
///  @return true if the forwarder is trusted for the account
function isTrustedForwarder(address forwarder, address account) public view returns (bool);
```

### preCheck(address,uint256,bytes) (inherited from ERC7579HookBase)

- **Signature**: `preCheck(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 632:302:203
- **Details**: [function_preCheck_address_uint256_bytes.md](./function_preCheck_address_uint256_bytes.md)

**Signature:**
```solidity
///  Precheck hook
///  @param msgSender sender of the transaction
///  @param msgValue value of the transaction
///  @param msgData data of the transaction
///  @return hookData data for the postcheck hook
function preCheck(address msgSender, uint256 msgValue, bytes calldata msgData) virtual external returns (bytes memory hookData);
```

### postCheck(bytes) (inherited from ERC7579HookBase)

- **Signature**: `postCheck(bytes)`
- **Visibility**: external
- **Source Range**: 1036:151:203
- **Details**: [function_postCheck_bytes.md](./function_postCheck_bytes.md)

**Signature:**
```solidity
///  Postcheck hook
///  @param hookData data from the precheck hook
function postCheck(bytes calldata hookData) virtual external;
```
