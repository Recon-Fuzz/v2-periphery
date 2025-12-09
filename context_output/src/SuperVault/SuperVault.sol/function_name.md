# Function: name()

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2697:144:34
- **Inherited From**: ERC20Upgradeable

## Implementation

```solidity
///  @dev Returns the name of the token.
function name() virtual public view returns (string memory) {
    ERC20Storage storage $ = _getERC20Storage();
    return $._name;
}
```

## Related Implementations

### _getERC20Storage()

- **Kind**: internal
- **Source**: 1947:153:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_getERC20Storage()`

```solidity
function _getERC20Storage() private pure returns (ERC20Storage storage $) {
    assembly {
        $.slot := ERC20StorageLocation
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Upgradeable.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20Upgradeable._getERC20Storage() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: private
```

## Documentation

### Function Documentation

 @dev Returns the name of the token.

### Interface Documentation

 @dev Returns the name of the token.
