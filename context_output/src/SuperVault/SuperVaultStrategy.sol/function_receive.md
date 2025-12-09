# Function: receive()

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 5285:30:513

## Implementation

```solidity
/// @notice Allows the contract to receive native ETH
///  @dev Required for hooks that may send ETH back to the strategy
receive() external payable {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Allows the contract to receive native ETH
 @dev Required for hooks that may send ETH back to the strategy
