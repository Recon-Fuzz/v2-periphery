# Function: getInstallValidatorData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol/contract_NexusHelpers.md]

## Metadata

- **Contract**: NexusHelpers
- **Signature**: `getInstallValidatorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 6622:257:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to install a validator on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the validator
function getInstallValidatorData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getInstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to install a validator on an ERC7579 Account
 @param initData bytes the data to pass to the module
 @return data bytes the callData to install the validator
