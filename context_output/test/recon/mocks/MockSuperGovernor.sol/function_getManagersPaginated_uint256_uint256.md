# Function: getManagersPaginated(uint256,uint256)

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `getManagersPaginated(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 30124:261:642

## Implementation

```solidity
function getManagersPaginated(uint256, uint256) public view returns (address[] memory, uint256) {
    return (_getManagersPaginatedReturn_0, _getManagersPaginatedReturn_1);
}
```

## State Variable Reads

- **_getManagersPaginatedReturn_0** (`address[]`)
- **_getManagersPaginatedReturn_1** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.getManagersPaginated(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
