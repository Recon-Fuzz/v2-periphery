# Function: getUninstallValidatorData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `getUninstallValidatorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 7089:259:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to uninstall a validator on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the validator
function getUninstallValidatorData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getUninstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to uninstall a validator on an ERC7579 Account
 @param initData bytes the data to pass to the module
 @return data bytes the callData to uninstall the validator
