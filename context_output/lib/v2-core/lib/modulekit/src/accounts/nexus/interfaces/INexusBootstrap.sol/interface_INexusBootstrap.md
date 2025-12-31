# Interface: INexusBootstrap

## Metadata

- **Name**: INexusBootstrap
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/nexus/interfaces/INexusBootstrap.sol

## Public/External Functions

### initNexusWithSingleValidator(contract IModule,bytes,contract IERC7484,address[],uint8)

- **Signature**: `initNexusWithSingleValidator(contract IModule,bytes,contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 612:214:172

**Signature:**
```solidity
/// @notice Initializes the Nexus account with a single validator.
///  @dev Intended to be called by the Nexus with a delegatecall.
///  @param validator The address of the validator module.
///  @param data The initialization data for the validator module.
function initNexusWithSingleValidator(IERC7579Module validator, bytes calldata data, IERC7484 registry, address[] calldata attesters, uint8 threshold) external;;
```

### initNexus(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],contract IERC7484,address[],uint8)

- **Signature**: `initNexus(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 1252:310:172

**Signature:**
```solidity
/// @notice Initializes the Nexus account with multiple modules.
///  @dev Intended to be called by the Nexus with a delegatecall.
///  @param validators The configuration array for validator modules.
///  @param executors The configuration array for executor modules.
///  @param hook The configuration for the hook module.
///  @param fallbacks The configuration array for fallback handler modules.
function initNexus(BootstrapConfig[] calldata validators, BootstrapConfig[] calldata executors, BootstrapConfig calldata hook, BootstrapConfig[] calldata fallbacks, IERC7484 registry, address[] calldata attesters, uint8 threshold) external;;
```

### initNexusScoped(struct BootstrapConfig[],struct BootstrapConfig,contract IERC7484,address[],uint8)

- **Signature**: `initNexusScoped(struct BootstrapConfig[],struct BootstrapConfig,contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 1845:224:172

**Signature:**
```solidity
/// @notice Initializes the Nexus account with a scoped set of modules.
///  @dev Intended to be called by the Nexus with a delegatecall.
///  @param validators The configuration array for validator modules.
///  @param hook The configuration for the hook module.
function initNexusScoped(BootstrapConfig[] calldata validators, BootstrapConfig calldata hook, IERC7484 registry, address[] calldata attesters, uint8 threshold) external;;
```

### getInitNexusCalldata(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],contract IERC7484,address[],uint8)

- **Signature**: `getInitNexusCalldata(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 2477:370:172

**Signature:**
```solidity
/// @notice Prepares calldata for the initNexus function.
///  @param validators The configuration array for validator modules.
///  @param executors The configuration array for executor modules.
///  @param hook The configuration for the hook module.
///  @param fallbacks The configuration array for fallback handler modules.
///  @return init The prepared calldata for initNexus.
function getInitNexusCalldata(BootstrapConfig[] calldata validators, BootstrapConfig[] calldata executors, BootstrapConfig calldata hook, BootstrapConfig[] calldata fallbacks, IERC7484 registry, address[] calldata attesters, uint8 threshold) external view returns (bytes memory init);;
```

### getInitNexusScopedCalldata(struct BootstrapConfig[],struct BootstrapConfig,contract IERC7484,address[],uint8)

- **Signature**: `getInitNexusScopedCalldata(struct BootstrapConfig[],struct BootstrapConfig,contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 3117:284:172

**Signature:**
```solidity
/// @notice Prepares calldata for the initNexusScoped function.
///  @param validators The configuration array for validator modules.
///  @param hook The configuration for the hook module.
///  @return init The prepared calldata for initNexusScoped.
function getInitNexusScopedCalldata(BootstrapConfig[] calldata validators, BootstrapConfig calldata hook, IERC7484 registry, address[] calldata attesters, uint8 threshold) external view returns (bytes memory init);;
```

### getInitNexusWithSingleValidatorCalldata(struct BootstrapConfig,contract IERC7484,address[],uint8)

- **Signature**: `getInitNexusWithSingleValidatorCalldata(struct BootstrapConfig,contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 3634:255:172

**Signature:**
```solidity
/// @notice Prepares calldata for the initNexusWithSingleValidator function.
///  @param validator The configuration for the validator module.
///  @return init The prepared calldata for initNexusWithSingleValidator.
function getInitNexusWithSingleValidatorCalldata(BootstrapConfig calldata validator, IERC7484 registry, address[] calldata attesters, uint8 threshold) external view returns (bytes memory init);;
```
