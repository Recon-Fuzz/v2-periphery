# Function: authorizations(address,bytes32)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `authorizations(address,bytes32)`
- **Visibility**: external
- **Source Range**: 13834:151:510

## Implementation

```solidity
/// @inheritdoc IERC7741
function authorizations(address controller, bytes32 nonce) external view returns (bool used) {
    return _authorizations[controller][nonce];
}
```

## State Variable Reads

- **_authorizations** (`mapping(address => mapping(bytes32 => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.authorizations(address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC7741

### Interface Documentation

 @dev Returns whether the given `nonce` has been used for the `controller`.
