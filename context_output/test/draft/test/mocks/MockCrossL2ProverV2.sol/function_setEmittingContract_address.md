# Function: setEmittingContract(address)

**Contract**: [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]

## Metadata

- **Contract**: MockCrossL2ProverV2
- **Signature**: `setEmittingContract(address)`
- **Visibility**: external
- **Source Range**: 797:119:567

## Implementation

```solidity
function setEmittingContract(address emittingContract_) external {
    _emittingContract = emittingContract_;
}
```

## State Variable Writes

- **_emittingContract** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockCrossL2ProverV2.setEmittingContract(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
