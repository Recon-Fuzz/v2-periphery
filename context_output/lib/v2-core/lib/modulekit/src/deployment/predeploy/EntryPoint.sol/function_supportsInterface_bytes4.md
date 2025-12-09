# Function: supportsInterface(bytes4)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 730:146:292
- **Inherited From**: ERC165

## Implementation

```solidity
/// @inheritdoc IERC165
function supportsInterface(bytes4 interfaceId) virtual public view returns (bool) {
    return interfaceId == type(IERC165).interfaceId;
}
```

## Call Tree

```
No call tree available
```

## Documentation

### Function Documentation

@inheritdoc IERC165

### Interface Documentation

 @dev Returns true if this contract implements the interface defined by
 `interfaceId`. See the corresponding
 https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC section]
 to learn more about how these ids are created.
 This function call must use less than 30 000 gas.
