# Function: queueOracleUpdate(address[],address[],bytes32[],address[])

**Contract**: [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Metadata

- **Contract**: SuperOracle
- **Signature**: `queueOracleUpdate(address[],address[],bytes32[],address[])`
- **Visibility**: external
- **Source Range**: 5755:779:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function queueOracleUpdate(address[] calldata bases, address[] calldata quotes, bytes32[] calldata providers, address[] calldata feeds) external {
    if (msg.sender != SUPER_GOVERNOR) revert UNAUTHORIZED_UPDATE_AUTHORITY();
    uint256 length = bases.length;
    if (((length != quotes.length) || (length != providers.length)) || (length != feeds.length)) {
        revert ARRAY_LENGTH_MISMATCH();
    }
    _validateOracleInputs(bases, quotes, providers, feeds);
    pendingUpdate = PendingUpdate({bases: bases, quotes: quotes, providers: providers, feeds: feeds, timestamp: block.timestamp});
    emit OracleUpdateQueued(bases, quotes, providers, feeds, block.timestamp);
}
```

## Related Implementations

### _validateOracleInputs(address[],address[],bytes32[],address[])

- **Kind**: internal
- **Source**: 12128:715:535
- **Link**: `src/oracles/SuperOracleBase.sol:SuperOracleBase:_validateOracleInputs(address[],address[],bytes32[],address[])`

```solidity
function _validateOracleInputs(address[] memory bases, address[] memory quotes, bytes32[] memory providers, address[] memory feeds) internal pure {
    uint256 length = bases.length;
    for (uint256 i; i < length; ++i) {
        address base = bases[i];
        address quote = quotes[i];
        bytes32 provider = providers[i];
        address feed = feeds[i];
        if (provider == bytes32(0)) revert ZERO_PROVIDER();
        if (provider == AVERAGE_PROVIDER) revert AVERAGE_PROVIDER_NOT_ALLOWED();
        if (((base == address(0)) || (quote == address(0))) || (feed == address(0))) revert ZERO_ADDRESS();
    }
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`address`)
- **AVERAGE_PROVIDER** (`bytes32`)

## State Variable Writes

- **pendingUpdate** (`struct ISuperOracle.PendingUpdate`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.queueOracleUpdate(address[],address[],bytes32[],address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperOracleBase._validateOracleInputs(address[],address[],bytes32[],address[]) (NodeID: 1)
      💬 Args: [bases, quotes, providers, feeds]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Queue oracle update for timelock
 @param bases Array of base assets
 @param providers Array of provider ids
 @param quotes Array of quote assets
 @param feeds Array of oracle addresses
