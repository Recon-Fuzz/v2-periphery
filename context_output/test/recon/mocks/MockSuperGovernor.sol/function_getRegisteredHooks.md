# Function: getRegisteredHooks()

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `getRegisteredHooks()`
- **Visibility**: public
- **Source Range**: 32859:120:642

## Implementation

```solidity
function getRegisteredHooks() public view returns (address[] memory) {
    return _getRegisteredHooksReturn_0;
}
```

## State Variable Reads

- **_getRegisteredHooksReturn_0** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.getRegisteredHooks() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
