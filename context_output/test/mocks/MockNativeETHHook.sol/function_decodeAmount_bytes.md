# Function: decodeAmount(bytes)

**Contract**: [test/mocks/MockNativeETHHook.sol/contract_MockNativeETHHook.md]

## Metadata

- **Contract**: MockNativeETHHook
- **Signature**: `decodeAmount(bytes)`
- **Visibility**: external
- **Source Range**: 4558:414:599

## Implementation

```solidity
/// @notice Decode the amount from hook data
///  @param data The hook data to decode
///  @return The amount value
function decodeAmount(bytes memory data) external pure returns (uint256) {
    if (data.length >= 84) {
        uint256 amount;
        assembly {
            amount := mload(add(data, 84))
        }
        return amount;
    }
    return 0;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockNativeETHHook.decodeAmount(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Decode the amount from hook data
 @param data The hook data to decode
 @return The amount value
