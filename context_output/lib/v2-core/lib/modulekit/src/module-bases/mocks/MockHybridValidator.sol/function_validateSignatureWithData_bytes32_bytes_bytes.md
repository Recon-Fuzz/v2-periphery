# Function: validateSignatureWithData(bytes32,bytes,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHybridValidator.sol/contract_MockHybridValidator.md]

## Metadata

- **Contract**: MockHybridValidator
- **Signature**: `validateSignatureWithData(bytes32,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 1338:217:223

## Implementation

```solidity
function validateSignatureWithData(bytes32, bytes calldata, bytes calldata) override external pure returns (bool validSig) {
    return true;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHybridValidator.validateSignatureWithData(bytes32,bytes,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
