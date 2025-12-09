# Function: validateEvent(bytes)

**Contract**: [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]

## Metadata

- **Contract**: MockCrossL2ProverV2
- **Signature**: `validateEvent(bytes)`
- **Visibility**: external
- **Source Range**: 922:283:567

## Implementation

```solidity
function validateEvent(bytes calldata) external view returns (uint32 chainId, address emittingContract, bytes memory topics, bytes memory unindexedData) {
    return (_chainId, _emittingContract, _topics, _unindexedData);
}
```

## State Variable Reads

- **_chainId** (`uint32`)
- **_emittingContract** (`address`)
- **_topics** (`bytes`)
- **_unindexedData** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockCrossL2ProverV2.validateEvent(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
