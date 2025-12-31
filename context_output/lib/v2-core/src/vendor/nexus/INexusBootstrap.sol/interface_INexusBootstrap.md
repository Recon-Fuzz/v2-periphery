# Interface: INexusBootstrap

## Metadata

- **Name**: INexusBootstrap
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/nexus/INexusBootstrap.sol

## Public/External Functions

### initNexus(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],contract IERC7484,address[],uint8)

- **Signature**: `initNexus(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 1855:310:461

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

### getInitNexusScopedCalldata(struct BootstrapConfig[],struct BootstrapConfig,contract IERC7484,address[],uint8)

- **Signature**: `getInitNexusScopedCalldata(struct BootstrapConfig[],struct BootstrapConfig,contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 2435:284:461

**Signature:**
```solidity
/// @notice Prepares calldata for the initNexusScoped function.
///  @param validators The configuration array for validator modules.
///  @param hook The configuration for the hook module.
///  @return init The prepared calldata for initNexusScoped.
function getInitNexusScopedCalldata(BootstrapConfig[] calldata validators, BootstrapConfig calldata hook, IERC7484 registry, address[] calldata attesters, uint8 threshold) external view returns (bytes memory init);;
```

### getInitNexusCalldata(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],contract IERC7484,address[],uint8)

- **Signature**: `getInitNexusCalldata(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 3127:370:461

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
