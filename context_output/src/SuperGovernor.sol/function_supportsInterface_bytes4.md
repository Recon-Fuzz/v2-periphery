# Function: supportsInterface(bytes4)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 32924:209:509

## Implementation

```solidity
/// @dev Advertise ISuperGovernor support for ERC-165 detection
function supportsInterface(bytes4 interfaceId) override(AccessControl) public view returns (bool) {
    return (interfaceId == type(ISuperGovernor).interfaceId) || super.supportsInterface(interfaceId);
}
```

## Related Implementations

### supportsInterface(bytes4)

- **Kind**: internal
- **Source**: 2541:202:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:supportsInterface(bytes4)`

```solidity
/// @inheritdoc IERC165
function supportsInterface(bytes4 interfaceId) virtual override public view returns (bool) {
    return (interfaceId == type(IAccessControl).interfaceId) || super.supportsInterface(interfaceId);
}
```

### supportsInterface(bytes4)

- **Kind**: internal
- **Source**: 730:146:292
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol:ERC165:supportsInterface(bytes4)`

```solidity
/// @inheritdoc IERC165
function supportsInterface(bytes4 interfaceId) virtual public view returns (bool) {
    return interfaceId == type(IERC165).interfaceId;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.supportsInterface(bytes4) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AccessControl.supportsInterface(bytes4) (NodeID: 1)
      💬 Args: [interfaceId]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC165.supportsInterface(bytes4) (NodeID: 2)
        💬 Args: [interfaceId]
        👁️  Def: public
```

## Documentation

### Function Documentation

@dev Advertise ISuperGovernor support for ERC-165 detection

### Interface Documentation

 @dev Returns true if this contract implements the interface defined by
 `interfaceId`. See the corresponding
 https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC section]
 to learn more about how these ids are created.
 This function call must use less than 30 000 gas.
