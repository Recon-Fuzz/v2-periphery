# Function: getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol/contract_NexusHelpers.md]

## Metadata

- **Contract**: NexusHelpers
- **Signature**: `getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 10310:272:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to install an ERC1271 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the prevalidation hook ERC1271
function getInstallPrevalidationHookERC1271Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to install an ERC1271 prevalidation hook
 @param initData bytes the data to pass to the module
 @return data bytes the callData to install the prevalidation hook ERC1271
