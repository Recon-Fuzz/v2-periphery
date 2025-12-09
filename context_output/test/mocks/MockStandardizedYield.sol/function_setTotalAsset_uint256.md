# Function: setTotalAsset(uint256)

**Contract**: [test/mocks/MockStandardizedYield.sol/contract_MockStandardizedYield.md]

## Metadata

- **Contract**: MockStandardizedYield
- **Signature**: `setTotalAsset(uint256)`
- **Visibility**: external
- **Source Range**: 2319:85:603

## Implementation

```solidity
function setTotalAsset(uint256 amount) external {
    totalSupply = amount;
}
```

## State Variable Writes

- **totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStandardizedYield.setTotalAsset(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
