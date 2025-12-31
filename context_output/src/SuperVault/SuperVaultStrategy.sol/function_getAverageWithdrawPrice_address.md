# Function: getAverageWithdrawPrice(address)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `getAverageWithdrawPrice(address)`
- **Visibility**: external
- **Source Range**: 28070:178:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function getAverageWithdrawPrice(address controller) external view returns (uint256 averageWithdrawPrice) {
    return superVaultState[controller].averageWithdrawPrice;
}
```

## State Variable Reads

- **superVaultState** (`mapping(address => struct ISuperVaultStrategy.SuperVaultState)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.getAverageWithdrawPrice(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Get the average withdraw price for a controller
 @param controller The controller address
 @return averageWithdrawPrice The average withdraw price
