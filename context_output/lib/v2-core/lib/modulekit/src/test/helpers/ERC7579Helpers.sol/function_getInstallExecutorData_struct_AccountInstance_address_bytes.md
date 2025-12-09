# Function: getInstallExecutorData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `getInstallExecutorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 7550:257:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to install executor on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the executor
function getInstallExecutorData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getInstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to install executor on an ERC7579 Account
 @param initData bytes the data to pass to the module
 @return data bytes the callData to install the executor
