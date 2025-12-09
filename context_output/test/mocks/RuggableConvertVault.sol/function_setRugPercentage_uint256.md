# Function: setRugPercentage(uint256)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `setRugPercentage(uint256)`
- **Visibility**: external
- **Source Range**: 1755:129:608

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
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.setRugPercentage(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
