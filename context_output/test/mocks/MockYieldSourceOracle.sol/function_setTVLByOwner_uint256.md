# Function: setTVLByOwner(uint256)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `setTVLByOwner(uint256)`
- **Visibility**: external
- **Source Range**: 859:94:607

## Implementation

```solidity
function setTVLByOwner(uint256 _tvlByOwner) external {
    tvlByOwner = _tvlByOwner;
}
```

## State Variable Writes

- **tvlByOwner** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.setTVLByOwner(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
