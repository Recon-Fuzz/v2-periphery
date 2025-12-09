# Function: getUninstallFallbackData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol/contract_NexusHelpers.md]

## Metadata

- **Contract**: NexusHelpers
- **Signature**: `getUninstallFallbackData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 8769:406:237

## Implementation

```solidity
/// @notice Gets the data to uninstall a fallback on an account instance
///  @param initData the data to pass to the module
///  @return data the data to uninstall the fallback
function getUninstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    (bytes4 selector, , bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encodePacked(selector, _initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusHelpers.getUninstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to uninstall a fallback on an account instance
 @param initData the data to pass to the module
 @return data the data to uninstall the fallback
