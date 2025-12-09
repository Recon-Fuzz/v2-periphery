# Function: maxMint(address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `maxMint(address)`
- **Visibility**: external
- **Source Range**: 15955:153:510

## Implementation

```solidity
/// @inheritdoc IERC4626
function maxMint(address) override external view returns (uint256) {
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

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.maxMint(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
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

 @dev Returns the maximum amount of the Vault shares that can be minted for the receiver, through a mint call.
 - MUST return a limited value if receiver is subject to some mint limit.
 - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of shares that may be minted.
 - MUST NOT revert.
