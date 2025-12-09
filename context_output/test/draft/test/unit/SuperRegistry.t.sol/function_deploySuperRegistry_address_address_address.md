# Function: deploySuperRegistry(address,address,address)

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `deploySuperRegistry(address,address,address)`
- **Visibility**: public
- **Source Range**: 754:202:572
- **Inherited From**: BaseTestSuperAsset

## Implementation

```solidity
/// @notice Deploy SuperRegistry with the given admin addresses and prover
///  @param superRegistryAdmin_ The address for super registry admin role
///  @param registryAdmin_ The address for registry admin role
///  @param prover_ The prover address
function deploySuperRegistry(address superRegistryAdmin_, address registryAdmin_, address prover_) public {
    superRegistry = new SuperRegistry(superRegistryAdmin_, registryAdmin_, prover_);
}
```

## State Variable Writes

- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTestSuperAsset.deploySuperRegistry(address,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Deploy SuperRegistry with the given admin addresses and prover
 @param superRegistryAdmin_ The address for super registry admin role
 @param registryAdmin_ The address for registry admin role
 @param prover_ The prover address
