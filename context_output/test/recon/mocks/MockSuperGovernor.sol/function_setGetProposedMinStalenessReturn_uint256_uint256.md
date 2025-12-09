# Function: setGetProposedMinStalenessReturn(uint256,uint256)

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetProposedMinStalenessReturn(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 12440:194:642

## Implementation

```solidity
function setGetProposedMinStalenessReturn(uint256 _value0, uint256 _value1) public {
    _getProposedMinStalenessReturn_0 = _value0;
    _getProposedMinStalenessReturn_1 = _value1;
}
```

## State Variable Writes

- **_getProposedMinStalenessReturn_0** (`uint256`)
- **_getProposedMinStalenessReturn_1** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetProposedMinStalenessReturn(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
