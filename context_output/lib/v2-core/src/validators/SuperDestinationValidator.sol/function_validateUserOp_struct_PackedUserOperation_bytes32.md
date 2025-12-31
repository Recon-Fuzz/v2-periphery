# Function: validateUserOp(struct PackedUserOperation,bytes32)

**Contract**: [lib/v2-core/src/validators/SuperDestinationValidator.sol/contract_SuperDestinationValidator.md]

## Metadata

- **Contract**: SuperDestinationValidator
- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 1314:231:437

## Implementation

```solidity
/// @notice Validate a user operation
///  @dev Not implemented
function validateUserOp(PackedUserOperation calldata, bytes32) override external pure returns (ValidationData) {
    revert NOT_IMPLEMENTED();
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperDestinationValidator.validateUserOp(struct PackedUserOperation,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Validate a user operation
 @dev Not implemented
