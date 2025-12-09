# Function: pendingOwner()

**Contract**: [test/draft/src/VaultBank/VaultBankSuperPosition.sol/contract_VaultBankSuperPosition.md]

## Metadata

- **Contract**: VaultBankSuperPosition
- **Signature**: `pendingOwner()`
- **Visibility**: public
- **Source Range**: 1232:99:252
- **Inherited From**: Ownable2Step

## Implementation

```solidity
///  @dev Returns the address of the pending owner.
function pendingOwner() virtual public view returns (address) {
    return _pendingOwner;
}
```

## State Variable Reads

- **_pendingOwner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Ownable2Step.pendingOwner() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns the address of the pending owner.
