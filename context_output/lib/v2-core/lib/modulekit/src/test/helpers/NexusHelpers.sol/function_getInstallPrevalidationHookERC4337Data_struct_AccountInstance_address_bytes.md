# Function: getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol/contract_NexusHelpers.md]

## Metadata

- **Contract**: NexusHelpers
- **Signature**: `getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 10809:272:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to install an ERC4337 prevalidation hook ERC4337
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the prevalidation hook ERC4337
function getInstallPrevalidationHookERC4337Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to install an ERC4337 prevalidation hook ERC4337
 @param initData bytes the data to pass to the module
 @return data bytes the callData to install the prevalidation hook ERC4337
