# Function: handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 10773:831:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function handleOperations7540(Operation operation, address controller, address receiver, uint256 amount) external {
    _requireVault();
    ISuperVaultAggregator aggregator = _getSuperVaultAggregator();
    if (operation == Operation.RedeemRequest) {
        _validateStrategyState(aggregator);
        _handleRequestRedeem(controller, amount);
    } else if (operation == Operation.ClaimCancelRedeem) {
        _handleClaimCancelRedeem(controller);
    } else if (operation == Operation.ClaimRedeem) {
        _handleClaimRedeem(controller, receiver, amount);
    } else if (operation == Operation.CancelRedeemRequest) {
        _handleCancelRedeemRequest(controller);
    } else {
        revert ACTION_TYPE_DISALLOWED();
    }
}
```

## Related Implementations

### _requireVault()

- **Kind**: internal
- **Source**: 45598:104:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_requireVault()`

```solidity
/// @notice Internal function to check if the caller is the vault
///  @dev This is used to prevent unauthorized access to certain functions
function _requireVault() internal view {
    if (msg.sender != _vault) revert ACCESS_DENIED();
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

### _validateStrategyState(contract ISuperVaultAggregator)

- **Kind**: internal
- **Source**: 47789:269:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_validateStrategyState(contract ISuperVaultAggregator)`

```solidity
/// @notice Validates full pps state by checking pause, stale, and PPS update status
///  @dev Used for operations that require current PPS for calculations:
///       - handleOperations4626Deposit: Needs PPS to calculate shares from assets
///       - handleOperations4626Mint: Needs PPS to validate asset requirements
///       - fulfillRedeemRequests: Needs current PPS to calculate assets from shares
///  @param aggregator The SuperVaultAggregator contract
function _validateStrategyState(ISuperVaultAggregator aggregator) internal view {
    if (_isPaused(aggregator)) revert STRATEGY_PAUSED();
    if (_isPPSStale(aggregator)) revert STALE_PPS();
    if (_isPPSNotUpdated(aggregator)) revert PPS_EXPIRED();
}
```

### _isPaused(contract ISuperVaultAggregator)

- **Kind**: internal
- **Source**: 45919:148:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isPaused(contract ISuperVaultAggregator)`

```solidity
/// @notice Checks if the strategy is currently paused
///  @dev This calls SuperVaultAggregator.isStrategyPaused to determine pause status
///  @return True if the strategy is paused, false otherwise
function _isPaused(ISuperVaultAggregator aggregator) internal view returns (bool) {
    return aggregator.isStrategyPaused(address(this));
}
```

### _isPPSStale(contract ISuperVaultAggregator)

- **Kind**: internal
- **Source**: 46256:144:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isPPSStale(contract ISuperVaultAggregator)`

```solidity
/// @notice Checks if the PPS is stale
///  @dev This calls SuperVaultAggregator.isPPSStale to determine stale status
///  @return True if the PPS is stale, false otherwise
function _isPPSStale(ISuperVaultAggregator aggregator) internal view returns (bool) {
    return aggregator.isPPSStale(address(this));
}
```

### _isPPSNotUpdated(contract ISuperVaultAggregator)

- **Kind**: internal
- **Source**: 46667:635:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isPPSNotUpdated(contract ISuperVaultAggregator)`

```solidity
/// @notice Checks if the PPS is not updated
///  @dev This checks if the PPS has not been updated since the `ppsExpiration` time
///  @param aggregator The SuperVaultAggregator contract
///  @return True if the PPS is not updated, false otherwise
function _isPPSNotUpdated(ISuperVaultAggregator aggregator) internal view returns (bool) {
    uint256 lastPPSUpdateTimestamp = aggregator.getLastUpdateTimestamp(address(this));
    return (block.timestamp - lastPPSUpdateTimestamp) > ppsExpiration;
}
```

### _handleRequestRedeem(address,uint256)

- **Kind**: internal
- **Source**: 40929:1562:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_handleRequestRedeem(address,uint256)`

```solidity
/// @notice Internal function to handle a redeem
///  @param controller Address of the controller
///  @param shares Amount of shares
function _handleRequestRedeem(address controller, uint256 shares) private {
    if (shares == 0) revert INVALID_AMOUNT();
    if (controller == address(0)) revert ZERO_ADDRESS();
    SuperVaultState storage state = superVaultState[controller];
    uint256 currentPPS = getStoredPPS();
    if (currentPPS == 0) revert INVALID_PPS();
    if (state.pendingRedeemRequest > 0) {
        uint256 existingSharesInRequest = state.pendingRedeemRequest;
        uint256 newTotalSharesInRequest = existingSharesInRequest + shares;
        state.averageRequestPPS = ((existingSharesInRequest * state.averageRequestPPS) + (shares * currentPPS)) / newTotalSharesInRequest;
        state.pendingRedeemRequest = newTotalSharesInRequest;
    } else {
        state.pendingRedeemRequest = shares;
        state.averageRequestPPS = currentPPS;
    }
    emit RedeemRequestPlaced(controller, controller, shares);
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

### _handleClaimCancelRedeem(address)

- **Kind**: internal
- **Source**: 43221:625:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_handleClaimCancelRedeem(address)`

```solidity
/// @notice Internal function to handle a claim redeem cancellation
///  @param controller Address of the controller
function _handleClaimCancelRedeem(address controller) private {
    if (controller == address(0)) revert ZERO_ADDRESS();
    SuperVaultState storage state = superVaultState[controller];
    uint256 pendingShares = state.claimableCancelRedeemRequest;
    if (pendingShares == 0) revert REQUEST_NOT_FOUND();
    if (!state.pendingCancelRedeemRequest) revert CANCELLATION_REDEEM_REQUEST_PENDING();
    state.pendingCancelRedeemRequest = false;
    state.claimableCancelRedeemRequest = 0;
    emit RedeemRequestCanceled(controller, pendingShares);
}
```

### _handleClaimRedeem(address,address,uint256)

- **Kind**: internal
- **Source**: 44299:410:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_handleClaimRedeem(address,address,uint256)`

```solidity
/// @notice Internal function to handle a redeem claim
///  @dev Only updates state. Vault is responsible for calling Escrow.returnAssets() after this returns.
///       Callers (SuperVault.withdraw/redeem) already validate assetsToClaim <= state.maxWithdraw.
///  @param controller Address of the controller
///  @param receiver Address of the receiver (used for event only)
///  @param assetsToClaim Amount of assets to claim
function _handleClaimRedeem(address controller, address receiver, uint256 assetsToClaim) private {
    if (assetsToClaim == 0) revert INVALID_AMOUNT();
    if (controller == address(0)) revert ZERO_ADDRESS();
    SuperVaultState storage state = superVaultState[controller];
    state.maxWithdraw -= assetsToClaim;
    emit RedeemRequestClaimed(receiver, controller, assetsToClaim, 0);
}
```

### _handleCancelRedeemRequest(address)

- **Kind**: internal
- **Source**: 42623:468:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_handleCancelRedeemRequest(address)`

```solidity
/// @notice Internal function to handle a redeem cancellation request
///  @param controller Address of the controller
function _handleCancelRedeemRequest(address controller) private {
    if (controller == address(0)) revert ZERO_ADDRESS();
    SuperVaultState storage state = superVaultState[controller];
    if (state.pendingRedeemRequest == 0) revert REQUEST_NOT_FOUND();
    if (state.pendingCancelRedeemRequest) revert CANCELLATION_REDEEM_REQUEST_PENDING();
    state.pendingCancelRedeemRequest = true;
    emit RedeemCancelRequestPlaced(controller);
}
```

## State Variable Reads

- **_vault** (`address`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **ppsExpiration** (`uint256`)
- **superVaultState** (`mapping(address => struct ISuperVaultStrategy.SuperVaultState)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._requireVault() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._validateStrategyState(contract ISuperVaultAggregator) (NodeID: 3)
  │   💬 Args: [aggregator]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPaused(contract ISuperVaultAggregator) (NodeID: 4)
  │ │   💬 Args: [aggregator]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPPSStale(contract ISuperVaultAggregator) (NodeID: 5)
  │ │   💬 Args: [aggregator]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPPSNotUpdated(contract ISuperVaultAggregator) (NodeID: 6)
  │     💬 Args: [aggregator]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._handleRequestRedeem(address,uint256) (NodeID: 7)
  │   💬 Args: [controller, amount]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy.getStoredPPS() (NodeID: 8)
  │     💬 Args: [no args]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 9)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._handleClaimCancelRedeem(address) (NodeID: 10)
  │   💬 Args: [controller]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._handleClaimRedeem(address,address,uint256) (NodeID: 11)
  │   💬 Args: [controller, receiver, amount]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: SuperVaultStrategy._handleCancelRedeemRequest(address) (NodeID: 12)
      💬 Args: [controller]
      👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Execute async redeem requests (redeem, cancel, claim).
 @param op The operation type (RedeemRequest, CancelRedeem, ClaimRedeem)
 @param controller The controller address
 @param receiver The receiver address
 @param amount The amount of assets or shares
