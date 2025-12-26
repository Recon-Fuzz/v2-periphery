# Function: setOperator(address,bool)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `setOperator(address,bool)`
- **Visibility**: external
- **Source Range**: 11051:284:510

## Implementation

```solidity
/// @inheritdoc IERC7540Operator
function setOperator(address operator, bool approved) external returns (bool success) {
    if (msg.sender == operator) revert UNAUTHORIZED();
    isOperator[msg.sender][operator] = approved;
    emit OperatorSet(msg.sender, operator, approved);
    return true;
}
```

## State Variable Writes

- **isOperator** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.setOperator(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC7540Operator

### Interface Documentation

 @dev Sets or removes an operator for the caller.
 @param operator The address of the operator.
 @param approved The approval status.
 @return Whether the call was executed successfully or not
