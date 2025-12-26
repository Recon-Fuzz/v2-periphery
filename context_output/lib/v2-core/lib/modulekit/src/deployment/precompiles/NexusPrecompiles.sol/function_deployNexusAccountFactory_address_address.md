# Function: deployNexusAccountFactory(address,address)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/precompiles/NexusPrecompiles.sol/contract_NexusPrecompiles.md]

## Metadata

- **Contract**: NexusPrecompiles
- **Signature**: `deployNexusAccountFactory(address,address)`
- **Visibility**: public
- **Source Range**: 1790:527:184

## Implementation

```solidity
/// @notice Deploys NexusAccountFactory from --via-ir precompiled bytecode
function deployNexusAccountFactory(address implementation, address owner) public returns (INexusAccountFactory factory) {
    bytes memory creationBytecode = bytes.concat(NEXUS_ACCOUNT_FACTORY_BYTECODE, abi.encode(implementation, owner));
    factory = INexusAccountFactory(_deploy(creationBytecode));
    label(address(factory), "NexusAccountFactory");
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

- **NEXUS_ACCOUNT_FACTORY_BYTECODE** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusPrecompiles.deployNexusAccountFactory(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 1)
      💬 Args: [creationBytecode]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Deploys NexusAccountFactory from --via-ir precompiled bytecode
