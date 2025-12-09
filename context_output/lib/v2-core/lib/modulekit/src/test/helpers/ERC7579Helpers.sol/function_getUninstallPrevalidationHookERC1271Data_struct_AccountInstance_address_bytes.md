# Function: getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 11304:274:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to uninstall an ERC1271 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the prevalidation hook ERC1271
function getUninstallPrevalidationHookERC1271Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to uninstall an ERC1271 prevalidation hook
 @param initData bytes the data to pass to the module
 @return data bytes the callData to uninstall the prevalidation hook ERC1271
