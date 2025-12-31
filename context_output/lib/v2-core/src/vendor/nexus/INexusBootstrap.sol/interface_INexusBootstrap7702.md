# Interface: INexusBootstrap7702

## Metadata

- **Name**: INexusBootstrap7702
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/nexus/INexusBootstrap.sol

## Public/External Functions

### initNexus(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],struct BootstrapPreValidationHookConfig[],struct RegistryConfig)

- **Signature**: `initNexus(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[],struct BootstrapPreValidationHookConfig[],struct RegistryConfig)`
- **Visibility**: external
- **Source Range**: 1045:354:461

**Signature:**
```solidity
/// @notice Initializes the Nexus account with multiple modules.
///  @dev Intended to be called by the Nexus with a delegatecall.
///  @param validators The configuration array for validator modules. Should not contain the default validator.
///  @param executors The configuration array for executor modules.
///  @param hook The configuration for the hook module.
///  @param fallbacks The configuration array for fallback handler modules.
///  @param preValidationHooks The configuration array for pre-validation hooks.
///  @param registryConfig The registry configuration.
function initNexus(BootstrapConfig[] calldata validators, BootstrapConfig[] calldata executors, BootstrapConfig calldata hook, BootstrapConfig[] calldata fallbacks, BootstrapPreValidationHookConfig[] calldata preValidationHooks, RegistryConfig memory registryConfig) external payable;;
```
