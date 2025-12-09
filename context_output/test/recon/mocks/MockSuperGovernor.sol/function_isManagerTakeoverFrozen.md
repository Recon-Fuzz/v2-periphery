# Function: isManagerTakeoverFrozen()

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `isManagerTakeoverFrozen()`
- **Visibility**: public
- **Source Range**: 36074:118:642

## Implementation

```solidity
function isManagerTakeoverFrozen() public view returns (bool) {
    return _isManagerTakeoverFrozenReturn_0;
}
```

## State Variable Reads

- **_isManagerTakeoverFrozenReturn_0** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.isManagerTakeoverFrozen() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
