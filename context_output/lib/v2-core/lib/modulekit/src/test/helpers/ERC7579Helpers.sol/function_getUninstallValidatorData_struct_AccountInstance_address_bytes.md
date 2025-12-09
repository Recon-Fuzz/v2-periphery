# Function: getUninstallValidatorData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `getUninstallValidatorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 1076:816:234

## Implementation

```solidity
/// @notice get callData to uninstall a validator on an ERC7579 Account
///  @param instance AccountInstance the account instance to uninstall the validator from
///  @param module address the address of the module to uninstall
///  @param initData bytes the data to pass to the module
function getUninstallValidatorData(AccountInstance memory instance, address module, bytes memory initData) virtual override public view returns (bytes memory data) {
    address previous;
    (address[] memory array, ) = IAccountModulesPaginated(instance.account).getValidatorsPaginated(address(0x1), 100);
    if (array.length == 1) {
        previous = address(0x1);
    } else if (array[0] == module) {
        previous = address(0x1);
    } else {
        for (uint256 i = 1; i < array.length; i++) {
            if (array[i] == module) previous = array[i - 1];
        }
    }
    data = abi.encode(previous, initData);
}
```

## External Calls

- **IAccountModulesPaginated::getValidatorsPaginated(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Helpers.getUninstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to uninstall a validator on an ERC7579 Account
 @param instance AccountInstance the account instance to uninstall the validator from
 @param module address the address of the module to uninstall
 @param initData bytes the data to pass to the module
