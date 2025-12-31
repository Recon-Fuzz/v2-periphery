# Function: deployNexus(address)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/nexus/NexusFactory.sol/contract_NexusFactory.md]

## Metadata

- **Contract**: NexusFactory
- **Signature**: `deployNexus(address)`
- **Visibility**: public
- **Source Range**: 803:353:184
- **Inherited From**: NexusPrecompiles

## Implementation

```solidity
/// @notice Deploys Nexus from --via-ir precompiled bytecode
function deployNexus(address anEntryPoint) public returns (address nexus) {
    bytes memory creationBytecode = bytes.concat(NEXUS_BYTECODE, abi.encode(anEntryPoint));
    nexus = _deploy(creationBytecode);
    label(nexus, "Nexus");
}
```

## Related Implementations

### _deploy(bytes)

- **Kind**: internal
- **Source**: 221:412:181
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/BytecodeDeployer.sol:BytecodeDeployer:_deploy(bytes)`

```solidity
/// @notice Deploys a contract using CREATE, reverts on failure
function _deploy(bytes memory creationBytecode) internal returns (address contractAddress) {
    assembly {
        contractAddress := create(0, add(creationBytecode, 0x20), mload(creationBytecode))
    }
    require(contractAddress != address(0), "Deployer: deployment failed");
}
```

## State Variable Reads

- **NEXUS_BYTECODE** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusPrecompiles.deployNexus(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 1)
      💬 Args: [creationBytecode]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Deploys Nexus from --via-ir precompiled bytecode
