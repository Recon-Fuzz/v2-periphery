# Function: getUninstallHookData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `getUninstallHookData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 8915:254:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to uninstall hook on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the hook
function getUninstallHookData(AccountInstance memory, address, bytes memory initData) virtual public pure returns (bytes memory data) {
    data = initData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getUninstallHookData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to uninstall hook on an ERC7579 Account
 @param initData bytes the data to pass to the module
 @return data bytes the callData to uninstall the hook
