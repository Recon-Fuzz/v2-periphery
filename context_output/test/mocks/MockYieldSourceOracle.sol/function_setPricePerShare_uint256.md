# Function: setPricePerShare(uint256)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `setPricePerShare(uint256)`
- **Visibility**: external
- **Source Range**: 675:106:607

## Implementation

```solidity
function setPricePerShare(uint256 _pricePerShare) external {
    pricePerShare = _pricePerShare;
}
```

## State Variable Writes

- **pricePerShare** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.setPricePerShare(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
