# Function: constructor(address,address[],address[],bytes32[],address[])

**Contract**: [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Metadata

- **Contract**: SuperOracle
- **Signature**: `constructor(address,address[],address[],bytes32[],address[])`
- **Visibility**: public
- **Source Range**: 264:263:534

## Implementation

```solidity
constructor(address superGovernor_, address[] memory bases, address[] memory quotes, bytes32[] memory providers, address[] memory feeds) SuperOracleBase(superGovernor_,bases,quotes,providers,feeds) {}
```

## Related Implementations

### (address,address[],address[],bytes32[],address[])

- **Kind**: internal
- **Source**: 3517:913:535
- **Link**: `src/oracles/SuperOracleBase.sol:SuperOracleBase:constructor(address,address[],address[],bytes32[],address[])`

```solidity
/// @notice Initializes the oracle with governance authority and initial feed configurations
///  @param superGovernor_ Immutable governance contract address (cannot be zero)
///  @param bases Array of base asset addresses (token being priced)
///  @param quotes Array of quote asset addresses (pricing denomination)
///  @param providers Array of provider identifiers (e.g., keccak256("CHAINLINK"))
///  @param feeds Array of Chainlink aggregator addresses for corresponding base/quote/provider triples
///  @dev All arrays must have equal length. Sets default staleness to 1 day.
constructor(address superGovernor_, address[] memory bases, address[] memory quotes, bytes32[] memory providers, address[] memory feeds) {
    if (superGovernor_ == address(0)) revert ZERO_ADDRESS();
    SUPER_GOVERNOR = superGovernor_;
    defaultStaleness = 1 days;
    uint256 len = bases.length;
    if (((len != quotes.length) || (len != providers.length)) || (len != feeds.length)) {
        revert ARRAY_LENGTH_MISMATCH();
    }
    _validateOracleInputs(bases, quotes, providers, feeds);
    _configureOracles(bases, quotes, providers, feeds);
    emit OraclesConfigured(bases, quotes, providers, feeds);
    uint256 length = feeds.length;
    for (uint256 i; i < length; ++i) {
        feedMaxStaleness[feeds[i]] = defaultStaleness;
    }
}
```

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

- **defaultStaleness** (`uint256`)
- **AVERAGE_PROVIDER** (`bytes32`)
- **isProviderSet** (`mapping(bytes32 => bool)`)
- **activeProviders** (`bytes32[]`)
- **MAX_SAMPLE_PROVIDERS** (`uint256`)

## State Variable Writes

- **SUPER_GOVERNOR** (`address`)
- **defaultStaleness** (`uint256`)
- **feedMaxStaleness** (`mapping(address => uint256)`)
- **oracles** (`mapping(address => mapping(address => mapping(bytes32 => address)))`)
- **activeProviders** (`bytes32[]`)
- **isProviderSet** (`mapping(bytes32 => bool)`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperOracle.constructor(address,address[],address[],bytes32[],address[]) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperOracle
  └─ [1] 🏗️ CONSTRUCTOR: SuperOracleBase.constructor(address,address[],address[],bytes32[],address[]) (NodeID: 1)
      💬 Args: [superGovernor_, bases, quotes, providers, feeds]
      🏗️  Contract: SuperOracleBase
    ├─ [2] ⚙️ FUNCTION: SuperOracleBase._validateOracleInputs(address[],address[],bytes32[],address[]) (NodeID: 2)
    │   💬 Args: [bases, quotes, providers, feeds]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperOracleBase._configureOracles(address[],address[],bytes32[],address[]) (NodeID: 3)
        💬 Args: [bases, quotes, providers, feeds]
        👁️  Def: internal
```
