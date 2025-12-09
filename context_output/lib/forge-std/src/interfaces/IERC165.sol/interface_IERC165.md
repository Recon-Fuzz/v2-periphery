# Interface: IERC165

## Metadata

- **Name**: IERC165
- **Type**: Interface
- **Path**: lib/forge-std/src/interfaces/IERC165.sol

## Public/External Functions

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 458:76:28

**Signature:**
```solidity
/// @notice Query if a contract implements an interface
///  @param interfaceID The interface identifier, as specified in ERC-165
///  @dev Interface identification is specified in ERC-165. This function
///  uses less than 30,000 gas.
///  @return `true` if the contract implements `interfaceID` and
///  `interfaceID` is not 0xffffffff, `false` otherwise
function supportsInterface(bytes4 interfaceID) external view returns (bool);;
```
