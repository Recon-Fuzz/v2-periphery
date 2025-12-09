# Function: getInstallFallbackData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol/contract_NexusHelpers.md]

## Metadata

- **Contract**: NexusHelpers
- **Signature**: `getInstallFallbackData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 8131:444:237

## Implementation

```solidity
/// @notice Gets the data to install a fallback on an account instance
///  @param initData the data to pass to the module
///  @return data the data to install the fallback
function getInstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    (bytes4 selector, CallType callType, bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encodePacked(selector, callType, _initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusHelpers.getInstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to install a fallback on an account instance
 @param initData the data to pass to the module
 @return data the data to install the fallback
