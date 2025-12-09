# Function: isValidSignatureWithSender(address,bytes32,bytes)

**Contract**: [lib/v2-core/src/validators/SuperDestinationValidator.sol/contract_SuperDestinationValidator.md]

## Metadata

- **Contract**: SuperDestinationValidator
- **Signature**: `isValidSignatureWithSender(address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 1600:233:437

## Implementation

```solidity
/// @notice Validate a signature with sender
function isValidSignatureWithSender(address, bytes32, bytes calldata) virtual override external pure returns (bytes4) {
    revert NOT_IMPLEMENTED();
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperDestinationValidator.isValidSignatureWithSender(address,bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Validate a signature with sender
