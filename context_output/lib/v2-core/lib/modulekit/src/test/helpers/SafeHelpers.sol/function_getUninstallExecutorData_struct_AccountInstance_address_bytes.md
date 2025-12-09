# Function: getUninstallExecutorData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getUninstallExecutorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 7738:813:238

## Implementation

```solidity
/// @notice Gets the data to install an executor on an account instance
///  @param instance AccountInstance the account instance to install the executor on
///  @param initData the data to pass to the executor
///  @return data the data to install the executor
function getUninstallExecutorData(AccountInstance memory instance, address module, bytes memory initData) virtual override public view returns (bytes memory data) {
    address previous;
    (address[] memory array, ) = IAccountModulesPaginated(instance.account).getExecutorsPaginated(address(0x1), 100);
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

- **IAccountModulesPaginated::getExecutorsPaginated(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeHelpers.getUninstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to install an executor on an account instance
 @param instance AccountInstance the account instance to install the executor on
 @param initData the data to pass to the executor
 @return data the data to install the executor
