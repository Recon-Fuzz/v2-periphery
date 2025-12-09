# Function: setRugPercentage(uint256)

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `setRugPercentage(uint256)`
- **Visibility**: external
- **Source Range**: 1970:129:609

## Implementation

```solidity
function setRugPercentage(uint256 percentage) external {
    rugPercentage = (percentage > 10_000) ? 10_000 : percentage;
}
```

## State Variable Writes

- **rugPercentage** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableVault.setRugPercentage(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
