# Function: proposeVaultFeeConfigUpdate(uint256,uint256,address)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `proposeVaultFeeConfigUpdate(uint256,uint256,address)`
- **Visibility**: external
- **Source Range**: 21009:780:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function proposeVaultFeeConfigUpdate(uint256 performanceFeeBps, uint256 managementFeeBps, address recipient) external {
    _isPrimaryManager(msg.sender);
    if (performanceFeeBps > MAX_PERFORMANCE_FEE) revert INVALID_PERFORMANCE_FEE_BPS();
    if (managementFeeBps > BPS_PRECISION) revert INVALID_PERFORMANCE_FEE_BPS();
    if (recipient == address(0)) revert ZERO_ADDRESS();
    proposedFeeConfig = FeeConfig({performanceFeeBps: performanceFeeBps, managementFeeBps: managementFeeBps, recipient: recipient});
    feeConfigEffectiveTime = block.timestamp + PROPOSAL_TIMELOCK;
    emit VaultFeeConfigProposed(performanceFeeBps, managementFeeBps, recipient, feeConfigEffectiveTime);
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

## External Calls

- **ISuperVaultAggregator::isMainManager(address,address)**
- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::SUPER_VAULT_AGGREGATOR()**

## State Variable Reads

- **MAX_PERFORMANCE_FEE** (`uint256`)
- **BPS_PRECISION** (`uint256`)
- **PROPOSAL_TIMELOCK** (`uint256`)
- **feeConfigEffectiveTime** (`uint256`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## State Variable Writes

- **proposedFeeConfig** (`struct ISuperVaultStrategy.FeeConfig`)
- **feeConfigEffectiveTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.proposeVaultFeeConfigUpdate(uint256,uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperVaultStrategy._isPrimaryManager(address) (NodeID: 1)
      💬 Args: [msg.sender]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Propose or execute a hook root update
 @notice Propose changes to vault-specific fee configuration
 @param performanceFeeBps New performance fee in basis points
 @param managementFeeBps New management fee in basis points
 @param recipient New fee recipient
 @dev IMPORTANT: Before executing the proposed update (via executeVaultFeeConfigUpdate),
      manager should call skimPerformanceFee() to collect performance fees on existing profits
      under the current fee structure to avoid losing profit or incorrect fee calculations.
