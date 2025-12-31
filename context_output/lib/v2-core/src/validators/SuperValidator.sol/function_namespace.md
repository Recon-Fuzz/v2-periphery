# Function: namespace()

**Contract**: [lib/v2-core/src/validators/SuperValidator.sol/contract_SuperValidator.md]

## Metadata

- **Contract**: SuperValidator
- **Signature**: `namespace()`
- **Visibility**: public
- **Source Range**: 2581:93:439
- **Inherited From**: SuperValidatorBase

## Implementation

```solidity
function namespace() public pure returns (string memory) {
    return _namespace();
}
```

## Related Implementations

### _namespace()

- **Kind**: internal
- **Source**: 4150:108:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_namespace()`

```solidity
/// @notice Returns the namespace identifier for this validator
///  @dev Used for module compatibility and identification in the ERC-7579 framework
///  @return The string identifier for this validator class
function _namespace() virtual internal pure returns (string memory) {
    return "SuperValidator";
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperValidatorBase.namespace() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SuperValidatorBase._namespace() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
