# Function: replaceCalldataAmount(bytes,uint256)

**Contract**: [test/mocks/MockNativeETHHook.sol/contract_MockNativeETHHook.md]

## Metadata

- **Contract**: MockNativeETHHook
- **Signature**: `replaceCalldataAmount(bytes,uint256)`
- **Visibility**: external
- **Source Range**: 5167:312:599

## Implementation

```solidity
/// @notice Replace the amount in hook calldata
///  @param data The original hook data
///  @param newAmount The new amount to replace with
///  @return The updated hook data
function replaceCalldataAmount(bytes memory data, uint256 newAmount) external pure returns (bytes memory) {
    if (data.length >= 84) {
        assembly {
            mstore(add(data, 84), newAmount)
        }
    }
    return data;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockNativeETHHook.replaceCalldataAmount(bytes,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Replace the amount in hook calldata
 @param data The original hook data
 @param newAmount The new amount to replace with
 @return The updated hook data
