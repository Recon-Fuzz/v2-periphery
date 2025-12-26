# Function: handleOperations4626Mint(address,uint256,uint256,uint256)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `handleOperations4626Mint(address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 8807:1191:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function handleOperations4626Mint(address controller, uint256 sharesNet, uint256 assetsGross, uint256 assetsNet) external {
    _requireVault();
    if (sharesNet == 0) revert INVALID_AMOUNT();
    if (controller == address(0)) revert ZERO_ADDRESS();
    ISuperVaultAggregator aggregator = _getSuperVaultAggregator();
    if (aggregator.isGlobalHooksRootVetoed()) {
        revert OPERATIONS_BLOCKED_BY_VETO();
    }
    _validateStrategyState(aggregator);
    uint256 feeBps = feeConfig.managementFeeBps;
    if (feeBps != 0) {
        uint256 feeAssets = assetsGross - assetsNet;
        if (feeAssets != 0) {
            address recipient = feeConfig.recipient;
            if (recipient == address(0)) revert ZERO_ADDRESS();
            _safeTokenTransfer(address(_asset), recipient, feeAssets);
            emit ManagementFeePaid(controller, recipient, feeAssets, feeBps);
        }
    }
    emit DepositHandled(controller, assetsNet, sharesNet);
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

### _safeTokenTransfer(address,address,uint256)

- **Kind**: internal
- **Source**: 44923:164:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_safeTokenTransfer(address,address,uint256)`

```solidity
/// @notice Internal function to safely transfer tokens
///  @param token Address of the token
///  @param recipient Address to receive the tokens
///  @param amount Amount of tokens to transfer
function _safeTokenTransfer(address token, address recipient, uint256 amount) private {
    if (amount > 0) IERC20(token).safeTransfer(recipient, amount);
}
```

## External Calls

- **ISuperVaultAggregator::isGlobalHooksRootVetoed()**
- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::SUPER_VAULT_AGGREGATOR()**
- **ISuperVaultAggregator::isStrategyPaused(address)**
- **ISuperVaultAggregator::isPPSStale(address)**
- **ISuperVaultAggregator::getLastUpdateTimestamp(address)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **feeConfig** (`struct ISuperVaultStrategy.FeeConfig`)
- **_asset** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_vault** (`address`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **ppsExpiration** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.handleOperations4626Mint(address,uint256,uint256,uint256) (NodeID: 0)
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
  └─ [1] ⚙️ FUNCTION: SuperVaultStrategy._safeTokenTransfer(address,address,uint256) (NodeID: 7)
      💬 Args: [address(_asset), recipient, feeAssets]
      👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Execute a 4626 mint by processing shares.
 @param controller The controller address
 @param sharesNet The amount of shares to mint
 @param assetsGross The amount of gross assets user has to deposit
 @param assetsNet The amount of net assets that strategy will receive
