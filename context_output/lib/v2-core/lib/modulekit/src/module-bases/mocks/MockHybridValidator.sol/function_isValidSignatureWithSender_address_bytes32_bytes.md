# Function: isValidSignatureWithSender(address,bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHybridValidator.sol/contract_MockHybridValidator.md]

## Metadata

- **Contract**: MockHybridValidator
- **Signature**: `isValidSignatureWithSender(address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 753:257:223

## Implementation

```solidity
function isValidSignatureWithSender(address, bytes32, bytes calldata) virtual override external view returns (bytes4) {
    return EIP1271_SUCCESS;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHybridValidator.isValidSignatureWithSender(address,bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
