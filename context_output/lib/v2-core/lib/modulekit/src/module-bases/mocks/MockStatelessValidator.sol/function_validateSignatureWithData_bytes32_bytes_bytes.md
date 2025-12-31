# Function: validateSignatureWithData(bytes32,bytes,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]

## Metadata

- **Contract**: MockStatelessValidator
- **Signature**: `validateSignatureWithData(bytes32,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 560:217:226

## Implementation

```solidity
function validateSignatureWithData(bytes32, bytes calldata, bytes calldata) override external pure returns (bool validSig) {
    return true;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStatelessValidator.validateSignatureWithData(bytes32,bytes,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
