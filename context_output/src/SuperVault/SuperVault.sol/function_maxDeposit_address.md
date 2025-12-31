# Function: maxDeposit(address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `maxDeposit(address)`
- **Visibility**: public
- **Source Range**: 15766:154:510

## Implementation

```solidity
/// @inheritdoc IERC4626
function maxDeposit(address) override public view returns (uint256) {
    if (!_canAcceptDeposits()) return 0;
    return type(uint256).max;
}
```

## Related Implementations

### _canAcceptDeposits()

- **Kind**: internal
- **Source**: 25073:321:510
- **Link**: `src/SuperVault/SuperVault.sol:SuperVault:_canAcceptDeposits()`

```solidity
/// @notice Combined check for deposits acceptance
///  @dev Reduces external calls by fetching aggregator address once
///  @dev Previously: 4 external calls (2x getAddress + 2x aggregator checks)
///  @dev Now: 3 external calls (1x getAddress + 2x aggregator checks)
///  @return True if deposits can be accepted (not paused and PPS not stale)
function _canAcceptDeposits() internal view returns (bool) {
    address aggregatorAddress = _getAggregatorAddress();
    ISuperVaultAggregator aggregator = ISuperVaultAggregator(aggregatorAddress);
    return (!aggregator.isStrategyPaused(address(strategy))) && (!aggregator.isPPSStale(address(strategy)));
}
```

### _getAggregatorAddress()

- **Kind**: internal
- **Source**: 25515:155:510
- **Link**: `src/SuperVault/SuperVault.sol:SuperVault:_getAggregatorAddress()`

```solidity
/// @notice Helper to get aggregator address once
///  @return Address of the SuperVaultAggregator contract
function _getAggregatorAddress() internal view returns (address) {
    return SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.SUPER_VAULT_AGGREGATOR());
}
```

## External Calls

- **ISuperVaultAggregator::isStrategyPaused(address)**
- **ISuperVaultAggregator::isPPSStale(address)**
- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::SUPER_VAULT_AGGREGATOR()**

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.maxDeposit(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SuperVault._canAcceptDeposits() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperVault._getAggregatorAddress() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC4626

### Interface Documentation

 @dev Returns the maximum amount of the underlying asset that can be deposited into the Vault for the receiver,
 through a deposit call.
 - MUST return a limited value if receiver is subject to some deposit limit.
 - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of assets that may be deposited.
 - MUST NOT revert.
