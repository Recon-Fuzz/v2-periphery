# Function: getInstallModuleCallData(struct AccountInstance,uint256,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getInstallModuleCallData(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 5358:360:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to install a module on an ERC7579 Account
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to install
///  @param initData bytes the data to pass to the module
///  @return callData bytes the callData to install the module
function getInstallModuleCallData(AccountInstance memory, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory callData) {
    callData = abi.encodeCall(IERC7579Account.installModule, (moduleType, module, initData));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getInstallModuleCallData(struct AccountInstance,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to install a module on an ERC7579 Account
 @param moduleType uint256 the type of the module
 @param module address the address of the module to install
 @param initData bytes the data to pass to the module
 @return callData bytes the callData to install the module
