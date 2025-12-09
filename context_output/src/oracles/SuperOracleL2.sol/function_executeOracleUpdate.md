# Function: executeOracleUpdate()

**Contract**: [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Metadata

- **Contract**: SuperOracleL2
- **Signature**: `executeOracleUpdate()`
- **Visibility**: external
- **Source Range**: 6573:598:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function executeOracleUpdate() external {
    if (msg.sender != SUPER_GOVERNOR) revert UNAUTHORIZED_UPDATE_AUTHORITY();
    if (pendingUpdate.timestamp == 0) revert NO_PENDING_UPDATE();
    if (block.timestamp < (pendingUpdate.timestamp + TIMELOCK_PERIOD)) revert TIMELOCK_NOT_ELAPSED();
    _configureOracles(pendingUpdate.bases, pendingUpdate.quotes, pendingUpdate.providers, pendingUpdate.feeds);
    emit OracleUpdateExecuted(pendingUpdate.bases, pendingUpdate.quotes, pendingUpdate.providers, pendingUpdate.feeds);
    delete pendingUpdate;
}
```

## Related Implementations

### _configureOracles(address[],address[],bytes32[],address[])

- **Kind**: internal
- **Source**: 22378:921:535
- **Link**: `src/oracles/SuperOracleBase.sol:SuperOracleBase:_configureOracles(address[],address[],bytes32[],address[])`

```solidity
/// @notice Internal function to configure oracle feeds and update active provider list
///  @param bases Array of base asset addresses
///  @param quotes Array of quote asset addresses
///  @param providers Array of provider identifiers
///  @param feeds Array of Chainlink aggregator addresses
///  @dev Validates inputs via _validateOracleInputs() before calling.
///       Automatically adds new providers to activeProviders array (up to MAX_SAMPLE_PROVIDERS).
///       Reverts if adding a provider would exceed MAX_SAMPLE_PROVIDERS limit.
function _configureOracles(address[] memory bases, address[] memory quotes, bytes32[] memory providers, address[] memory feeds) internal {
    uint256 length = bases.length;
    for (uint256 i; i < length; ++i) {
        address base = bases[i];
        address quote = quotes[i];
        bytes32 provider = providers[i];
        address feed = feeds[i];
        oracles[base][quote][provider] = feed;
        bool providerExists = isProviderSet[provider];
        if (!providerExists) {
            if (activeProviders.length >= MAX_SAMPLE_PROVIDERS) {
                revert TOO_MANY_PROVIDERS();
            }
            activeProviders.push(provider);
            isProviderSet[provider] = true;
        }
    }
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`address`)
- **pendingUpdate** (`struct ISuperOracle.PendingUpdate`)
- **TIMELOCK_PERIOD** (`uint256`)
- **isProviderSet** (`mapping(bytes32 => bool)`)
- **activeProviders** (`bytes32[]`)
- **MAX_SAMPLE_PROVIDERS** (`uint256`)

## State Variable Writes

- **pendingUpdate** (`struct ISuperOracle.PendingUpdate`)
- **oracles** (`mapping(address => mapping(address => mapping(bytes32 => address)))`)
- **activeProviders** (`bytes32[]`)
- **isProviderSet** (`mapping(bytes32 => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.executeOracleUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperOracleBase._configureOracles(address[],address[],bytes32[],address[]) (NodeID: 1)
      💬 Args: [pendingUpdate.bases, pendingUpdate.quotes, pendingUpdate.providers, pendingUpdate.feeds]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Execute queued oracle update after timelock period
