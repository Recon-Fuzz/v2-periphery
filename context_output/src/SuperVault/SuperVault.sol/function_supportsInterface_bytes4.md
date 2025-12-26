# Function: supportsInterface(bytes4)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 21797:401:510

## Implementation

```solidity
/// @notice Checks if contract supports a given interface
///  @dev Implements ERC165 for ERC7540, ERC7741, ERC4626, ERC7575 support detection
///  @param interfaceId The interface identifier to check
///  @return True if the interface is supported, false otherwise
function supportsInterface(bytes4 interfaceId) public pure returns (bool) {
    return (((((interfaceId == type(IERC7540Redeem).interfaceId) || (interfaceId == type(IERC165).interfaceId)) || (interfaceId == type(IERC7741).interfaceId)) || (interfaceId == type(IERC4626).interfaceId)) || (interfaceId == type(IERC7575).interfaceId)) || (interfaceId == type(IERC7540Operator).interfaceId);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.supportsInterface(bytes4) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Checks if contract supports a given interface
 @dev Implements ERC165 for ERC7540, ERC7741, ERC4626, ERC7575 support detection
 @param interfaceId The interface identifier to check
 @return True if the interface is supported, false otherwise
