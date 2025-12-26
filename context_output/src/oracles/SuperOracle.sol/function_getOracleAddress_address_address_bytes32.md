# Function: getOracleAddress(address,address,bytes32)

**Contract**: [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Metadata

- **Contract**: SuperOracle
- **Signature**: `getOracleAddress(address,address,bytes32)`
- **Visibility**: external
- **Source Range**: 7210:306:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function getOracleAddress(address base, address quote, bytes32 provider) external view returns (address oracle) {
    if (!isProviderSet[provider]) revert INVALID_ORACLE_PROVIDER();
    oracle = oracles[base][quote][provider];
    if (oracle == address(0)) revert NO_ORACLES_CONFIGURED();
}
```

## State Variable Reads

- **isProviderSet** (`mapping(bytes32 => bool)`)
- **oracles** (`mapping(address => mapping(address => mapping(bytes32 => address)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.getOracleAddress(address,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Get oracle address for a base asset and provider
 @param base Base asset address
 @param quote Quote asset address
 @param provider Provider id
 @return oracle Oracle address
