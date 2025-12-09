# Function: nonces(address)

**Contract**: [test/mocks/MockUp.sol/contract_MockUp.md]

## Metadata

- **Contract**: MockUp
- **Signature**: `nonces(address)`
- **Visibility**: public
- **Source Range**: 538:107:280
- **Inherited From**: Nonces

## Implementation

```solidity
///  @dev Returns the next unused nonce for an address.
function nonces(address owner) virtual public view returns (uint256) {
    return _nonces[owner];
}
```

## Call Tree

```
No call tree available
```

## Documentation

### Function Documentation

 @dev Returns the next unused nonce for an address.

### Interface Documentation

 @dev Returns the current nonce for `owner`. This value must be
 included whenever a signature is generated for {permit}.
 Every successful call to {permit} increases ``owner``'s nonce by one. This
 prevents a signature from being used multiple times.
