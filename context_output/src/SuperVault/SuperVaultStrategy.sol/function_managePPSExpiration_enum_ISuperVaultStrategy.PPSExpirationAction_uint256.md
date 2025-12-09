# Function: managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)`
- **Visibility**: external
- **Source Range**: 23048:408:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function managePPSExpiration(PPSExpirationAction action, uint256 staleness_) external {
    if (action == PPSExpirationAction.Propose) {
        _proposePPSExpiration(staleness_);
    } else if (action == PPSExpirationAction.Execute) {
        _updatePPSExpiration();
    } else if (action == PPSExpirationAction.Cancel) {
        _cancelPPSExpirationProposalUpdate();
    }
}
```

## Related Implementations

### _proposePPSExpiration(uint256)

- **Kind**: internal
- **Source**: 38314:578:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_proposePPSExpiration(uint256)`

```solidity
/// @notice Internal function to propose a PPS expiry threshold
///  @param _threshold The new PPS expiry threshold
function _proposePPSExpiration(uint256 _threshold) internal {
    _isPrimaryManager(msg.sender);
    if ((_threshold < MIN_PPS_EXPIRATION_THRESHOLD) || (_threshold > MAX_PPS_EXPIRATION_THRESHOLD)) {
        revert INVALID_PPS_EXPIRY_THRESHOLD();
    }
    uint256 currentProposedThreshold = proposedPPSExpiryThreshold;
    proposedPPSExpiryThreshold = _threshold;
    ppsExpiryThresholdEffectiveTime = block.timestamp + PROPOSAL_TIMELOCK;
    emit PPSExpirationProposed(currentProposedThreshold, _threshold, ppsExpiryThresholdEffectiveTime);
}
```

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

### _updatePPSExpiration()

- **Kind**: internal
- **Source**: 38966:531:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_updatePPSExpiration()`

```solidity
/// @notice Internal function to perform a PPS expiry threshold
function _updatePPSExpiration() internal {
    _isPrimaryManager(msg.sender);
    if (block.timestamp < ppsExpiryThresholdEffectiveTime) revert INVALID_TIMESTAMP();
    if (proposedPPSExpiryThreshold == 0) revert INVALID_PPS_EXPIRY_THRESHOLD();
    uint256 _proposed = proposedPPSExpiryThreshold;
    ppsExpiration = _proposed;
    ppsExpiryThresholdEffectiveTime = 0;
    proposedPPSExpiryThreshold = 0;
    emit PPSExpiryThresholdUpdated(_proposed);
}
```

### _cancelPPSExpirationProposalUpdate()

- **Kind**: internal
- **Source**: 39579:312:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_cancelPPSExpirationProposalUpdate()`

```solidity
/// @notice Internal function to cancel a PPS expiry threshold proposal
function _cancelPPSExpirationProposalUpdate() internal {
    _isPrimaryManager(msg.sender);
    if (ppsExpiryThresholdEffectiveTime == 0) revert NO_PROPOSAL();
    proposedPPSExpiryThreshold = 0;
    ppsExpiryThresholdEffectiveTime = 0;
    emit PPSExpiryThresholdProposalCanceled();
}
```

## State Variable Reads

- **MIN_PPS_EXPIRATION_THRESHOLD** (`uint256`)
- **MAX_PPS_EXPIRATION_THRESHOLD** (`uint256`)
- **proposedPPSExpiryThreshold** (`uint256`)
- **PROPOSAL_TIMELOCK** (`uint256`)
- **ppsExpiryThresholdEffectiveTime** (`uint256`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## State Variable Writes

- **proposedPPSExpiryThreshold** (`uint256`)
- **ppsExpiryThresholdEffectiveTime** (`uint256`)
- **ppsExpiration** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._proposePPSExpiration(uint256) (NodeID: 1)
  │   💬 Args: [staleness_]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPrimaryManager(address) (NodeID: 2)
  │     💬 Args: [msg.sender]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._updatePPSExpiration() (NodeID: 4)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPrimaryManager(address) (NodeID: 5)
  │     💬 Args: [msg.sender]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 6)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperVaultStrategy._cancelPPSExpirationProposalUpdate() (NodeID: 7)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPrimaryManager(address) (NodeID: 8)
        💬 Args: [msg.sender]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 9)
          💬 Args: [no args]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Manage PPS expiry threshold
 @param action Type of action (see PPSExpirationAction enum)
 @param ppsExpiration The new PPS expiry threshold
