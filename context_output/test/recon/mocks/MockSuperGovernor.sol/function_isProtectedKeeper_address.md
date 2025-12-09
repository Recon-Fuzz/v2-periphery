# Function: isProtectedKeeper(address)

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `isProtectedKeeper(address)`
- **Visibility**: public
- **Source Range**: 36246:166:642

## Implementation

```solidity
function isProtectedKeeper(address) public view returns (bool) {
    return _isProtectedKeeperReturn_0;
}
```

## State Variable Reads

- **_isProtectedKeeperReturn_0** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.isProtectedKeeper(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
