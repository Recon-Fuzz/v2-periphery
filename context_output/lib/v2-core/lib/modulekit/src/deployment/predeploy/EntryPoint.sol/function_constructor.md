# Function: constructor()

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 1607:241:90
- **Inherited From**: EntryPointSimulations

## Implementation

```solidity
///  simulation contract should not be deployed, and specifically, accounts should not trust
///  it as entrypoint, since the simulation functions don't check the signatures
constructor() {}
```

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: EntryPointSimulations.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: EntryPointSimulations
```

## Documentation

### Function Documentation

 simulation contract should not be deployed, and specifically, accounts should not trust
 it as entrypoint, since the simulation functions don't check the signatures
