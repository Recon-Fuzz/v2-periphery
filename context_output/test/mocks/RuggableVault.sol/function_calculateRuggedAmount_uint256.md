# Function: calculateRuggedAmount(uint256)

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `calculateRuggedAmount(uint256)`
- **Visibility**: public
- **Source Range**: 2136:132:609

## Implementation

```solidity
function calculateRuggedAmount(uint256 amount) public view returns (uint256) {
    return (amount * rugPercentage) / 10_000;
}
```

## State Variable Reads

- **rugPercentage** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableVault.calculateRuggedAmount(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
