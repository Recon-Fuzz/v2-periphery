# Function: inspectLogIdentifier(bytes)

**Contract**: [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]

## Metadata

- **Contract**: MockCrossL2ProverV2
- **Signature**: `inspectLogIdentifier(bytes)`
- **Visibility**: external
- **Source Range**: 1211:231:567

## Implementation

```solidity
function inspectLogIdentifier(bytes calldata) external pure returns (uint32 srcChain, uint64 blockNumber, uint16 receiptIndex, uint8 logIndex) {
    return (0, 0, 0, 0);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockCrossL2ProverV2.inspectLogIdentifier(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
