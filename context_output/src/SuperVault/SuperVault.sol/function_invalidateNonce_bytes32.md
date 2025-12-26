# Function: invalidateNonce(bytes32)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `invalidateNonce(bytes32)`
- **Visibility**: external
- **Source Range**: 14165:230:510

## Implementation

```solidity
/// @inheritdoc IERC7741
function invalidateNonce(bytes32 nonce) external {
    if (_authorizations[msg.sender][nonce]) revert INVALID_NONCE();
    _authorizations[msg.sender][nonce] = true;
    emit NonceInvalidated(msg.sender, nonce);
}
```

## State Variable Reads

- **_authorizations** (`mapping(address => mapping(bytes32 => bool))`)

## State Variable Writes

- **_authorizations** (`mapping(address => mapping(bytes32 => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.invalidateNonce(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC7741

### Interface Documentation

 @dev Revokes the given `nonce` for `msg.sender` as the `owner`.
