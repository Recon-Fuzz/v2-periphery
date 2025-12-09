# Function: getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 11801:274:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to uninstall an ERC4337 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the prevalidation hook ERC4337
function getUninstallPrevalidationHookERC4337Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to uninstall an ERC4337 prevalidation hook
 @param initData bytes the data to pass to the module
 @return data bytes the callData to uninstall the prevalidation hook ERC4337
