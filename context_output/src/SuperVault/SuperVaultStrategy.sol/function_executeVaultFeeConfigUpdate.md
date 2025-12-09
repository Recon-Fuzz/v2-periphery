# Function: executeVaultFeeConfigUpdate()

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `executeVaultFeeConfigUpdate()`
- **Visibility**: external
- **Source Range**: 21835:841:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function executeVaultFeeConfigUpdate() external {
    _isPrimaryManager(msg.sender);
    if (block.timestamp < feeConfigEffectiveTime) revert INVALID_TIMESTAMP();
    if (proposedFeeConfig.recipient == address(0)) revert ZERO_ADDRESS();
    uint256 currentPPS = getStoredPPS();
    uint256 oldHwmPps = vaultHwmPps;
    feeConfig = proposedFeeConfig;
    delete proposedFeeConfig;
    feeConfigEffectiveTime = 0;
    vaultHwmPps = currentPPS;
    emit VaultFeeConfigUpdated(feeConfig.performanceFeeBps, feeConfig.managementFeeBps, feeConfig.recipient);
    emit HWMPPSUpdated(currentPPS, oldHwmPps, 0, 0);
}
```

## Related Implementations

### _isPrimaryManager(address)

- **Kind**: internal
- **Source**: 35738:203:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isPrimaryManager(address)`

```solidity
/// @notice Internal function to check if a manager is the primary manager
///  @param manager_ The manager to check
function _isPrimaryManager(address manager_) internal view {
    if (!_getSuperVaultAggregator().isMainManager(manager_, address(this))) {
        revert MANAGER_NOT_AUTHORIZED();
    }
}
```

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

### getStoredPPS()

- **Kind**: internal
- **Source**: 24587:126:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:getStoredPPS()`

```solidity
/// @inheritdoc ISuperVaultStrategy
function getStoredPPS() public view returns (uint256) {
    return _getSuperVaultAggregator().getPPS(address(this));
}
```

## State Variable Reads

- **feeConfigEffectiveTime** (`uint256`)
- **proposedFeeConfig** (`struct ISuperVaultStrategy.FeeConfig`)
- **vaultHwmPps** (`uint256`)
- **feeConfig** (`struct ISuperVaultStrategy.FeeConfig`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## State Variable Writes

- **feeConfig** (`struct ISuperVaultStrategy.FeeConfig`)
- **proposedFeeConfig** (`struct ISuperVaultStrategy.FeeConfig`)
- **feeConfigEffectiveTime** (`uint256`)
- **vaultHwmPps** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.executeVaultFeeConfigUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._isPrimaryManager(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperVaultStrategy.getStoredPPS() (NodeID: 3)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 4)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Execute the proposed vault fee configuration update after timelock
 @dev IMPORTANT: Manager should call skimPerformanceFee() before executing this update
      to collect performance fees on existing profits under the current fee structure.
      Otherwise, profit earned under the old fee percentage will be lost or incorrectly calculated.
 @dev This function will reset the High Water Mark (vaultHwmPps) to the current PPS value
      to avoid incorrect fee calculations with the new fee structure.
