# Function: executeBatch(address[],bytes[])

**Contract**: [test/mocks/MockMultisig.sol/contract_MockMultisig.md]

## Metadata

- **Contract**: MockMultisig
- **Signature**: `executeBatch(address[],bytes[])`
- **Visibility**: external
- **Source Range**: 520:457:598

## Implementation

```solidity
/// @notice Execute multiple calls in a single transaction
///  @param targets Array of target contract addresses
///  @param data Array of calldata for each call
///  @return results Array of return data from each call
function executeBatch(address[] calldata targets, bytes[] calldata data) external returns (bytes[] memory results) {
    require(targets.length == data.length, "Length mismatch");
    results = new bytes[](targets.length);
    for (uint256 i = 0; i < targets.length; i++) {
        (bool success, bytes memory result) = targets[i].call(data[i]);
        require(success, "Call failed");
        results[i] = result;
    }
}
```

## External Calls

- **address::call(bytes calldata)**

## Native Transfers

- **unknown** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockMultisig.executeBatch(address[],bytes[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Execute multiple calls in a single transaction
 @param targets Array of target contract addresses
 @param data Array of calldata for each call
 @return results Array of return data from each call
