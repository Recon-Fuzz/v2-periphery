# Function: setTVL(uint256)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `setTVL(uint256)`
- **Visibility**: external
- **Source Range**: 787:66:607

## Implementation

```solidity
function setTVL(uint256 _tvl) external {
    tvl = _tvl;
}
```

## State Variable Writes

- **tvl** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.setTVL(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
