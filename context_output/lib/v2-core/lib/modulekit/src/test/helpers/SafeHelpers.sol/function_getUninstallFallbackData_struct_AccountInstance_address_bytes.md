# Function: getUninstallFallbackData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getUninstallFallbackData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 9731:400:238

## Implementation

```solidity
/// @notice Gets the data to install a fallback on an account instance
///  @param initData the data to pass to the fallback
///  @return data the data to install the fallback
function getUninstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    (bytes4 selector, , bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encode(selector, _initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeHelpers.getUninstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to install a fallback on an account instance
 @param initData the data to pass to the fallback
 @return data the data to install the fallback
