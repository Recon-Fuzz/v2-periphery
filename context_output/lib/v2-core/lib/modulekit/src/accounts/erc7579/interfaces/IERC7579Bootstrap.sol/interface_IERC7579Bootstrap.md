# Interface: IERC7579Bootstrap

## Metadata

- **Name**: IERC7579Bootstrap
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/erc7579/interfaces/IERC7579Bootstrap.sol

## Public/External Functions

### singleInitMSA(contract IModule,bytes)

- **Signature**: `singleInitMSA(contract IModule,bytes)`
- **Visibility**: external
- **Source Range**: 260:72:152

**Signature:**
```solidity
function singleInitMSA(IModule validator, bytes calldata data) external;;
```

### initMSA(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[])

- **Signature**: `initMSA(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[])`
- **Visibility**: external
- **Source Range**: 557:222:152

**Signature:**
```solidity
///  This function is intended to be called by the MSA with a delegatecall.
///  Make sure that the MSA already initilazed the linked lists in the ModuleManager prior to
///  calling this function
function initMSA(BootstrapConfig[] calldata $valdiators, BootstrapConfig[] calldata $executors, BootstrapConfig calldata _hook, BootstrapConfig[] calldata _fallbacks) external;;
```

### _getInitMSACalldata(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[])

- **Signature**: `_getInitMSACalldata(struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[])`
- **Visibility**: external
- **Source Range**: 785:283:152

**Signature:**
```solidity
function _getInitMSACalldata(BootstrapConfig[] calldata $valdiators, BootstrapConfig[] calldata $executors, BootstrapConfig calldata _hook, BootstrapConfig[] calldata _fallbacks) external view returns (bytes memory init);;
```
