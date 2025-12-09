# Function: getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 6052:364:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to uninstall a module on an ERC7579 Account
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to uninstall
///  @param initData bytes the data to pass to the module
///  @return callData bytes the callData to uninstall the module
function getUninstallModuleCallData(AccountInstance memory, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory callData) {
    callData = abi.encodeCall(IERC7579Account.uninstallModule, (moduleType, module, initData));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to uninstall a module on an ERC7579 Account
 @param moduleType uint256 the type of the module
 @param module address the address of the module to uninstall
 @param initData bytes the data to pass to the module
 @return callData bytes the callData to uninstall the module
