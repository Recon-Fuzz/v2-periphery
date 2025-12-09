# Function: inspectPolymerState(bytes)

**Contract**: [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]

## Metadata

- **Contract**: MockCrossL2ProverV2
- **Signature**: `inspectPolymerState(bytes)`
- **Visibility**: external
- **Source Range**: 2979:450:567

## Implementation

```solidity
/// @notice Mock implementation of inspectPolymerState - returns dummy values
///  @dev This implementation is required to satisfy the ICrossL2ProverV2 interface
function inspectPolymerState(bytes calldata) external view returns (bytes32 stateRoot, uint64 height, bytes memory signature) {
    return (bytes32(uint256(0x123456)), uint64(block.number), new bytes(65));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockCrossL2ProverV2.inspectPolymerState(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Mock implementation of inspectPolymerState - returns dummy values
 @dev This implementation is required to satisfy the ICrossL2ProverV2 interface
