# Function: getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 10350:341:238

## Implementation

```solidity
/// @notice get callData to install an ERC1271 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the prevalidation hook ERC1271
function getInstallPrevalidationHookERC1271Data(AccountInstance memory, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encode(MODULE_TYPE_PREVALIDATION_HOOK_ERC1271, initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeHelpers.getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to install an ERC1271 prevalidation hook
 @param initData bytes the data to pass to the module
 @return data bytes the callData to install the prevalidation hook ERC1271
