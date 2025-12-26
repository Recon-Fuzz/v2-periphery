# Function: resetHighWaterMark(uint256)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `resetHighWaterMark(uint256)`
- **Visibility**: external
- **Source Range**: 22722:280:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function resetHighWaterMark(uint256 newHwmPps) external {
    if (msg.sender != address(_getSuperVaultAggregator())) revert ACCESS_DENIED();
    if (newHwmPps == 0) revert INVALID_PPS();
    vaultHwmPps = newHwmPps;
    emit HighWaterMarkReset(newHwmPps);
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

- **vaultHwmPps** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.resetHighWaterMark(uint256) (NodeID: 0)
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

@notice Reset the high-water mark PPS to the current PPS
 @dev This function is only callable by Aggregator
 @dev This function will reset the High Water Mark (vaultHwmPps) to the current PPS value
 @param newHwmPps The new high-water mark PPS value
