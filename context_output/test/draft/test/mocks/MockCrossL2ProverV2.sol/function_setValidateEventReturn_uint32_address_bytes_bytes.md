# Function: setValidateEventReturn(uint32,address,bytes,bytes)

**Contract**: [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]

## Metadata

- **Contract**: MockCrossL2ProverV2
- **Signature**: `setValidateEventReturn(uint32,address,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 454:337:567

## Implementation

```solidity
function setValidateEventReturn(uint32 chainId_, address emittingContract_, bytes memory topics_, bytes memory unindexedData_) external {
    _chainId = chainId_;
    _emittingContract = emittingContract_;
    _topics = topics_;
    _unindexedData = unindexedData_;
}
```

## State Variable Writes

- **_chainId** (`uint32`)
- **_emittingContract** (`address`)
- **_topics** (`bytes`)
- **_unindexedData** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockCrossL2ProverV2.setValidateEventReturn(uint32,address,bytes,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
