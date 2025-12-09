# Function: isValidSignatureWithSender(address,bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]

## Metadata

- **Contract**: MockValidator
- **Signature**: `isValidSignatureWithSender(address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 766:257:228

## Implementation

```solidity
function isValidSignatureWithSender(address, bytes32, bytes calldata) virtual override external view returns (bytes4) {
    return EIP1271_SUCCESS;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockValidator.isValidSignatureWithSender(address,bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
