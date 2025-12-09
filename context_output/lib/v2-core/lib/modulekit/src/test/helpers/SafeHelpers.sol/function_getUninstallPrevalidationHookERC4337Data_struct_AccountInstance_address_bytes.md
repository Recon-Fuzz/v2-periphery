# Function: getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 12049:343:238

## Implementation

```solidity
/// @notice get callData to uninstall an ERC4337 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the prevalidation hook ERC4337
function getUninstallPrevalidationHookERC4337Data(AccountInstance memory, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encode(MODULE_TYPE_PREVALIDATION_HOOK_ERC4337, initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeHelpers.getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to uninstall an ERC4337 prevalidation hook
 @param initData bytes the data to pass to the module
 @return data bytes the callData to uninstall the prevalidation hook ERC4337
