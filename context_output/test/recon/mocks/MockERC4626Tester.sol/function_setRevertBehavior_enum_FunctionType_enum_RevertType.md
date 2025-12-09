# Function: setRevertBehavior(enum FunctionType,enum RevertType)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `setRevertBehavior(enum FunctionType,enum RevertType)`
- **Visibility**: public
- **Source Range**: 8290:108:637

## Implementation

```solidity
/// @dev Specify the revert behavior on each function
function setRevertBehavior(FunctionType ft, RevertType rt) public {
    revertBehaviours[ft] = rt;
}
```

## State Variable Writes

- **revertBehaviours** (`mapping(enum FunctionType => enum RevertType)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626Tester.setRevertBehavior(enum FunctionType,enum RevertType) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev Specify the revert behavior on each function
