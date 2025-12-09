# Contract: NexusHelpers

## Metadata

- **Name**: NexusHelpers
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol
- **Documentation**: @notice Helper functions for the Nexus ERC7579 implementation

## Public/External Functions

### execUserOp(struct AccountInstance,bytes,address)

- **Signature**: `execUserOp(struct AccountInstance,bytes,address)`
- **Visibility**: public
- **Source Range**: 1249:982:237
- **Details**: [function_execUserOp_struct_AccountInstance_bytes_address.md](./function_execUserOp_struct_AccountInstance_bytes_address.md)

**Signature:**
```solidity
/// @notice Gets userOp and userOpHash for an executing calldata on an account instance
///  @param instance AccountInstance the account instance to execute the callData on
///  @param callData bytes the calldata to execute
///  @param txValidator address the address of the validator
///  @return userOp PackedUserOperation the user operation
///  @return userOpHash bytes32 the hash of the user operation
function execUserOp(AccountInstance memory instance, bytes memory callData, address txValidator) override public view returns (PackedUserOperation memory userOp, bytes32 userOpHash);
```

### configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address)

- **Signature**: `configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address)`
- **Visibility**: public
- **Source Range**: 4289:1455:237
- **Details**: [function_configModuleUserOp_struct_AccountInstance_uint256_address_bytes_bool_address.md](./function_configModuleUserOp_struct_AccountInstance_uint256_address_bytes_bool_address.md)

**Signature:**
```solidity
/// @notice Configures a userop for an account instance to install or uninstall a module
///  @param instance AccountInstance the account instance to configure the userop for
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module
///  @param initData data the data to pass to the module
///  @param isInstall bool whether to install or uninstall the module
///  @param txValidator address the address of the validator
///  @return userOp PackedUserOperation the packed user operation
///  @return userOpHash bytes32 the hash of the user operation
function configModuleUserOp(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData, bool isInstall, address txValidator) override public view returns (PackedUserOperation memory userOp, bytes32 userOpHash);
```

### getUninstallValidatorData(struct AccountInstance,address,bytes)

- **Signature**: `getUninstallValidatorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 6028:816:237
- **Details**: [function_getUninstallValidatorData_struct_AccountInstance_address_bytes.md](./function_getUninstallValidatorData_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice Gets the data to install a validator on an account instance
///  @param instance AccountInstance the account instance to install the validator on
///  @param initData the data to pass to the validator
///  @return data the data to install the validator
function getUninstallValidatorData(AccountInstance memory instance, address module, bytes memory initData) virtual override public view returns (bytes memory data);
```

### getUninstallExecutorData(struct AccountInstance,address,bytes)

- **Signature**: `getUninstallExecutorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 7128:813:237
- **Details**: [function_getUninstallExecutorData_struct_AccountInstance_address_bytes.md](./function_getUninstallExecutorData_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice Gets the data to install a validator on an account instance
///  @param instance AccountInstance the account instance to install the validator on
///  @param initData the data to pass to the validator
///  @return data the data to install the validator
function getUninstallExecutorData(AccountInstance memory instance, address module, bytes memory initData) virtual override public view returns (bytes memory data);
```

### getInstallFallbackData(struct AccountInstance,address,bytes)

- **Signature**: `getInstallFallbackData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 8131:444:237
- **Details**: [function_getInstallFallbackData_struct_AccountInstance_address_bytes.md](./function_getInstallFallbackData_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice Gets the data to install a fallback on an account instance
///  @param initData the data to pass to the module
///  @return data the data to install the fallback
function getInstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data);
```

### getUninstallFallbackData(struct AccountInstance,address,bytes)

- **Signature**: `getUninstallFallbackData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 8769:406:237
- **Details**: [function_getUninstallFallbackData_struct_AccountInstance_address_bytes.md](./function_getUninstallFallbackData_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice Gets the data to uninstall a fallback on an account instance
///  @param initData the data to pass to the module
///  @return data the data to uninstall the fallback
function getUninstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data);
```

### isValidSignature(struct AccountInstance,address,bytes32,bytes)

- **Signature**: `isValidSignature(struct AccountInstance,address,bytes32,bytes)`
- **Visibility**: public
- **Source Range**: 9858:439:237
- **Details**: [function_isValidSignature_struct_AccountInstance_address_bytes32_bytes.md](./function_isValidSignature_struct_AccountInstance_address_bytes32_bytes.md)

**Signature:**
```solidity
/// @notice Checks if a signature is valid for an account instance
///  @param instance AccountInstance the account instance to check the signature on
///  @param validator address the address of the validator
///  @param hash bytes32 the hash of the data that is signed
///  @param signature bytes the signature to check
///  @return isValid bool whether the signature is valid, return true if isValidSignature return
///  EIP1271_MAGIC_VALUE
function isValidSignature(AccountInstance memory instance, address validator, bytes32 hash, bytes memory signature) virtual override public deployAccountForAction(instance) returns (bool isValid);
```

### formatERC1271Signature(struct AccountInstance,address,bytes)

- **Signature**: `formatERC1271Signature(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 10535:286:237
- **Details**: [function_formatERC1271Signature_struct_AccountInstance_address_bytes.md](./function_formatERC1271Signature_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice Formats an ERC1271 signature for an account instance
///  @param validator address the address of the validator
///  @param signature bytes the signature to format
///  @return bytes the formatted signature
function formatERC1271Signature(AccountInstance memory, address validator, bytes memory signature) virtual override public returns (bytes memory);
```

### getInstallModuleCallData(struct AccountInstance,uint256,address,bytes) (inherited from HelperBase)

- **Signature**: `getInstallModuleCallData(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 5358:360:235
- **Details**: [function_getInstallModuleCallData_struct_AccountInstance_uint256_address_bytes.md](./function_getInstallModuleCallData_struct_AccountInstance_uint256_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to install a module on an ERC7579 Account
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to install
///  @param initData bytes the data to pass to the module
///  @return callData bytes the callData to install the module
function getInstallModuleCallData(AccountInstance memory, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory callData);
```

### getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes) (inherited from HelperBase)

- **Signature**: `getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 6052:364:235
- **Details**: [function_getUninstallModuleCallData_struct_AccountInstance_uint256_address_bytes.md](./function_getUninstallModuleCallData_struct_AccountInstance_uint256_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to uninstall a module on an ERC7579 Account
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to uninstall
///  @param initData bytes the data to pass to the module
///  @return callData bytes the callData to uninstall the module
function getUninstallModuleCallData(AccountInstance memory, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory callData);
```

### getInstallValidatorData(struct AccountInstance,address,bytes) (inherited from HelperBase)

- **Signature**: `getInstallValidatorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 6622:257:235
- **Details**: [function_getInstallValidatorData_struct_AccountInstance_address_bytes.md](./function_getInstallValidatorData_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to install a validator on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the validator
function getInstallValidatorData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data);
```

### getInstallExecutorData(struct AccountInstance,address,bytes) (inherited from HelperBase)

- **Signature**: `getInstallExecutorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 7550:257:235
- **Details**: [function_getInstallExecutorData_struct_AccountInstance_address_bytes.md](./function_getInstallExecutorData_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to install executor on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the executor
function getInstallExecutorData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data);
```

### getInstallHookData(struct AccountInstance,address,bytes) (inherited from HelperBase)

- **Signature**: `getInstallHookData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 8465:252:235
- **Details**: [function_getInstallHookData_struct_AccountInstance_address_bytes.md](./function_getInstallHookData_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to install hook on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the hook
function getInstallHookData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data);
```

### getUninstallHookData(struct AccountInstance,address,bytes) (inherited from HelperBase)

- **Signature**: `getUninstallHookData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 8915:254:235
- **Details**: [function_getUninstallHookData_struct_AccountInstance_address_bytes.md](./function_getUninstallHookData_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to uninstall hook on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the hook
function getUninstallHookData(AccountInstance memory, address, bytes memory initData) virtual public pure returns (bytes memory data);
```

### getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (inherited from HelperBase)

- **Signature**: `getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 10310:272:235
- **Details**: [function_getInstallPrevalidationHookERC1271Data_struct_AccountInstance_address_bytes.md](./function_getInstallPrevalidationHookERC1271Data_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to install an ERC1271 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the prevalidation hook ERC1271
function getInstallPrevalidationHookERC1271Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data);
```

### getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (inherited from HelperBase)

- **Signature**: `getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 10809:272:235
- **Details**: [function_getInstallPrevalidationHookERC4337Data_struct_AccountInstance_address_bytes.md](./function_getInstallPrevalidationHookERC4337Data_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to install an ERC4337 prevalidation hook ERC4337
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the prevalidation hook ERC4337
function getInstallPrevalidationHookERC4337Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data);
```

### getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (inherited from HelperBase)

- **Signature**: `getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 11304:274:235
- **Details**: [function_getUninstallPrevalidationHookERC1271Data_struct_AccountInstance_address_bytes.md](./function_getUninstallPrevalidationHookERC1271Data_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to uninstall an ERC1271 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the prevalidation hook ERC1271
function getUninstallPrevalidationHookERC1271Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data);
```

### getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (inherited from HelperBase)

- **Signature**: `getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 11801:274:235
- **Details**: [function_getUninstallPrevalidationHookERC4337Data_struct_AccountInstance_address_bytes.md](./function_getUninstallPrevalidationHookERC4337Data_struct_AccountInstance_address_bytes.md)

**Signature:**
```solidity
/// @notice get callData to uninstall an ERC4337 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the prevalidation hook ERC4337
function getUninstallPrevalidationHookERC4337Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data);
```

### isModuleInstalled(struct AccountInstance,uint256,address) (inherited from HelperBase)

- **Signature**: `isModuleInstalled(struct AccountInstance,uint256,address)`
- **Visibility**: public
- **Source Range**: 12624:304:235
- **Details**: [function_isModuleInstalled_struct_AccountInstance_uint256_address.md](./function_isModuleInstalled_struct_AccountInstance_uint256_address.md)

**Signature:**
```solidity
/// @notice Checks if a module is installed on an ERC7579 Account
///  @param instance AccountInstance the account instance to check the module on
///  @param moduleTypeId uint256 the type of the module
///  @param module address the address of the module to check
///  @return bool whether the module is installed
function isModuleInstalled(AccountInstance memory instance, uint256 moduleTypeId, address module) virtual public deployAccountForAction(instance) returns (bool);
```

### isModuleInstalled(struct AccountInstance,uint256,address,bytes) (inherited from HelperBase)

- **Signature**: `isModuleInstalled(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 13345:405:235
- **Details**: [function_isModuleInstalled_struct_AccountInstance_uint256_address_bytes.md](./function_isModuleInstalled_struct_AccountInstance_uint256_address_bytes.md)

**Signature:**
```solidity
/// @notice Checks if a module is installed on an ERC7579 Account
///  @param instance AccountInstance the account instance to check the module on
///  @param moduleTypeId uint256 the type of the module
///  @param module address the address of the module to check
///  @param additionalContext bytes additional context to pass to the module
///  @return bool whether the module is installed
function isModuleInstalled(AccountInstance memory instance, uint256 moduleTypeId, address module, bytes memory additionalContext) virtual public deployAccountForAction(instance) returns (bool);
```

### getInstallModuleData(struct AccountInstance,uint256,address,bytes) (inherited from HelperBase)

- **Signature**: `getInstallModuleData(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 14183:1139:235
- **Details**: [function_getInstallModuleData_struct_AccountInstance_uint256_address_bytes.md](./function_getInstallModuleData_struct_AccountInstance_uint256_address_bytes.md)

**Signature:**
```solidity
/// @notice Gets the data to install a module on an ERC7579 Account, based on the module type
///  @param instance AccountInstance the account instance to install the module on
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to install
///  @param initData bytes the data to pass to the module
///  @return data bytes the data to install the module
function getInstallModuleData(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory);
```

### getUninstallModuleData(struct AccountInstance,uint256,address,bytes) (inherited from HelperBase)

- **Signature**: `getUninstallModuleData(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 15765:1153:235
- **Details**: [function_getUninstallModuleData_struct_AccountInstance_uint256_address_bytes.md](./function_getUninstallModuleData_struct_AccountInstance_uint256_address_bytes.md)

**Signature:**
```solidity
/// @notice Gets the data to uninstall a module on an ERC7579 Account, based on the module type
///  @param instance AccountInstance the account instance to uninstall the module from
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to uninstall
///  @param initData bytes the data to pass to the module
///  @return data bytes the data to uninstall the module
function getUninstallModuleData(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory);
```

### formatERC1271Hash(struct AccountInstance,address,bytes32) (inherited from HelperBase)

- **Signature**: `formatERC1271Hash(struct AccountInstance,address,bytes32)`
- **Visibility**: public
- **Source Range**: 18087:217:235
- **Details**: [function_formatERC1271Hash_struct_AccountInstance_address_bytes32.md](./function_formatERC1271Hash_struct_AccountInstance_address_bytes32.md)

**Signature:**
```solidity
/// @notice Formats a hash for an ERC1271 signature
///  @param hash bytes32 the hash to format
///  @return bytes32 the formatted hash
function formatERC1271Hash(AccountInstance memory, address, bytes32 hash) virtual public returns (bytes32);
```

### deployAccount(struct AccountInstance) (inherited from HelperBase)

- **Signature**: `deployAccount(struct AccountInstance)`
- **Visibility**: public
- **Source Range**: 19133:605:235
- **Details**: [function_deployAccount_struct_AccountInstance.md](./function_deployAccount_struct_AccountInstance.md)

**Signature:**
```solidity
/// @notice Deploys an account instance, if it has not been deployed yet
///          reverts if no initCode is provided
///  @param instance AccountInstance the account instance to deploy
function deployAccount(AccountInstance memory instance) virtual public;
```

### encode(address,uint256,bytes) (inherited from HelperBase)

- **Signature**: `encode(address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 20733:551:235
- **Details**: [function_encode_address_uint256_bytes.md](./function_encode_address_uint256_bytes.md)

**Signature:**
```solidity
/// @notice Encode a single ERC7579 Execution Transaction
///  @param target address the target
///  @param value uint256 the value
///  @param callData bytes the callData of the call
///  @return erc7579Tx bytes the encoded ERC7579 transaction
function encode(address target, uint256 value, bytes memory callData) virtual public pure returns (bytes memory erc7579Tx);
```

### encode(struct Execution[]) (inherited from HelperBase)

- **Signature**: `encode(struct Execution[])`
- **Visibility**: public
- **Source Range**: 21481:444:235
- **Details**: [function_encode_struct_Execution[].md](./function_encode_struct_Execution[].md)

**Signature:**
```solidity
/// @notice Encode a batch of ERC7579 Execution Transactions
///  @param executions Execution[] the array of executions
///  @return erc7579Tx bytes the encoded ERC7579 transaction
function encode(Execution[] memory executions) virtual public pure returns (bytes memory erc7579Tx);
```

### toExecutions(address[],uint256[],bytes[]) (inherited from HelperBase)

- **Signature**: `toExecutions(address[],uint256[],bytes[])`
- **Visibility**: public
- **Source Range**: 22255:602:235
- **Details**: [function_toExecutions_address[]_uint256[]_bytes[].md](./function_toExecutions_address[]_uint256[]_bytes[].md)

**Signature:**
```solidity
/// @notice Convert arrays of targets, values, and callDatas to an array of Executions
///  @param targets address[] the array of targets
///  @param values uint256[] the array of values
///  @param callDatas bytes[] the array of callDatas
///  @return executions Execution[] the array of encoded executions
function toExecutions(address[] memory targets, uint256[] memory values, bytes[] memory callDatas) virtual public pure returns (Execution[] memory executions);
```

### getNonce(struct AccountInstance,bytes,address) (inherited from HelperBase)

- **Signature**: `getNonce(struct AccountInstance,bytes,address)`
- **Visibility**: public
- **Source Range**: 23309:343:235
- **Details**: [function_getNonce_struct_AccountInstance_bytes_address.md](./function_getNonce_struct_AccountInstance_bytes_address.md)

**Signature:**
```solidity
/// @notice Get the nonce for an account instance
///  @param instance AccountInstance the account instance to get the nonce for
///  @param txValidator address the address of the validator
///  @return nonce uint256 the nonce
function getNonce(AccountInstance memory instance, bytes memory, address txValidator) virtual public returns (uint256 nonce);
```
