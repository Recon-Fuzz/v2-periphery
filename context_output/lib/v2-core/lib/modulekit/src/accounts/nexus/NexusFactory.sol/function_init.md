# Function: init()

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/nexus/NexusFactory.sol/contract_NexusFactory.md]

## Metadata

- **Contract**: NexusFactory
- **Signature**: `init()`
- **Visibility**: public
- **Source Range**: 913:251:169

## Implementation

```solidity
function init() override public {
    nexusImpl = deployNexus(ENTRYPOINT_ADDR);
    factory = deployNexusAccountFactory(nexusImpl, address(this));
    bootstrapDefault = deployNexusBootstrap();
}
```

## Related Implementations

### deployNexus(address)

- **Kind**: internal
- **Source**: 803:353:184
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/NexusPrecompiles.sol:NexusPrecompiles:deployNexus(address)`

```solidity
/// @notice Deploys Nexus from --via-ir precompiled bytecode
function deployNexus(address anEntryPoint) public returns (address nexus) {
    bytes memory creationBytecode = bytes.concat(NEXUS_BYTECODE, abi.encode(anEntryPoint));
    nexus = _deploy(creationBytecode);
    label(nexus, "Nexus");
}
```

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

### deployNexusAccountFactory(address,address)

- **Kind**: internal
- **Source**: 1790:527:184
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/NexusPrecompiles.sol:NexusPrecompiles:deployNexusAccountFactory(address,address)`

```solidity
/// @notice Deploys NexusAccountFactory from --via-ir precompiled bytecode
function deployNexusAccountFactory(address implementation, address owner) public returns (INexusAccountFactory factory) {
    bytes memory creationBytecode = bytes.concat(NEXUS_ACCOUNT_FACTORY_BYTECODE, abi.encode(implementation, owner));
    factory = INexusAccountFactory(_deploy(creationBytecode));
    label(address(factory), "NexusAccountFactory");
}
```

### deployNexusBootstrap()

- **Kind**: internal
- **Source**: 2410:260:184
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/NexusPrecompiles.sol:NexusPrecompiles:deployNexusBootstrap()`

```solidity
/// @notice Deploys the NexusBootstrap contract from --via-ir precompiled bytecode
function deployNexusBootstrap() public returns (INexusBootstrap bootstrap) {
    bootstrap = INexusBootstrap(_deploy(NEXUS_BOOTSTRAP_BYTECODE));
    label(address(bootstrap), "NexusBootstrap");
}
```

## State Variable Reads

- **nexusImpl** (`address`)
- **NEXUS_BYTECODE** (`bytes`)
- **NEXUS_ACCOUNT_FACTORY_BYTECODE** (`bytes`)
- **NEXUS_BOOTSTRAP_BYTECODE** (`bytes`)

## State Variable Writes

- **nexusImpl** (`address`)
- **factory** (`contract INexusAccountFactory`) [lib/v2-core/lib/modulekit/src/accounts/nexus/interfaces/INexusAccountFactory.sol/interface_INexusAccountFactory.md]
- **bootstrapDefault** (`contract INexusBootstrap`) [lib/v2-core/lib/modulekit/src/accounts/nexus/interfaces/INexusBootstrap.sol/interface_INexusBootstrap.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusFactory.init() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: NexusPrecompiles.deployNexus(address) (NodeID: 1)
  │   💬 Args: [ENTRYPOINT_ADDR]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 2)
  │     💬 Args: [creationBytecode]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: NexusPrecompiles.deployNexusAccountFactory(address,address) (NodeID: 3)
  │   💬 Args: [nexusImpl, address(this)]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 4)
  │     💬 Args: [creationBytecode]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: NexusPrecompiles.deployNexusBootstrap() (NodeID: 5)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 6)
        💬 Args: [NEXUS_BOOTSTRAP_BYTECODE]
        👁️  Def: internal
```
