# Function: changeFeeRecipient(address)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `changeFeeRecipient(address)`
- **Visibility**: external
- **Source Range**: 20717:246:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function changeFeeRecipient(address newRecipient) external {
    if (msg.sender != address(_getSuperVaultAggregator())) revert ACCESS_DENIED();
    feeConfig.recipient = newRecipient;
    emit FeeRecipientChanged(newRecipient);
}
```

## Related Implementations

### _getSuperVaultAggregator()

- **Kind**: internal
- **Source**: 35041:251:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_getSuperVaultAggregator()`

```solidity
/// @notice Internal function to get the SuperVaultAggregator
///  @return The SuperVaultAggregator
function _getSuperVaultAggregator() internal view returns (ISuperVaultAggregator) {
    address aggregatorAddress = SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.SUPER_VAULT_AGGREGATOR());
    return ISuperVaultAggregator(aggregatorAddress);
}
```

## External Calls

- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::SUPER_VAULT_AGGREGATOR()**

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## State Variable Writes

- **feeConfig** (`struct ISuperVaultStrategy.FeeConfig`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.changeFeeRecipient(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Change the fee recipient when the primary manager is changed
 @param newRecipient New fee recipient
