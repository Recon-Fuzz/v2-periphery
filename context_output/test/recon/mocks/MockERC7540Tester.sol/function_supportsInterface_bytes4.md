# Function: supportsInterface(bytes4)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 12802:149:641

## Implementation

```solidity
/// @notice ERC165 interface detection
function supportsInterface(bytes4 interfaceId) override external pure returns (bool) {
    return interfaceId == type(IERC165).interfaceId;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.supportsInterface(bytes4) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice ERC165 interface detection

### Interface Documentation

 @dev Returns true if this contract implements the interface defined by
 `interfaceId`. See the corresponding
 https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC section]
 to learn more about how these ids are created.
 This function call must use less than 30 000 gas.
