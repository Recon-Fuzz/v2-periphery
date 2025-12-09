# Function: deployNexusBootstrap()

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/nexus/NexusFactory.sol/contract_NexusFactory.md]

## Metadata

- **Contract**: NexusFactory
- **Signature**: `deployNexusBootstrap()`
- **Visibility**: public
- **Source Range**: 2410:260:184
- **Inherited From**: NexusPrecompiles

## Implementation

```solidity
/// @notice Deploys the NexusBootstrap contract from --via-ir precompiled bytecode
function deployNexusBootstrap() public returns (INexusBootstrap bootstrap) {
    bootstrap = INexusBootstrap(_deploy(NEXUS_BOOTSTRAP_BYTECODE));
    label(address(bootstrap), "NexusBootstrap");
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

### label(address,string)

- **Kind**: free-function
- **Source**: 971:93:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:label(address,string)`

```solidity
function label(address _addr, string memory _label) {
    Vm(VM_ADDR).label(_addr, _label);
}
```

## State Variable Reads

- **NEXUS_BOOTSTRAP_BYTECODE** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusPrecompiles.deployNexusBootstrap() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 1)
  │   💬 Args: [NEXUS_BOOTSTRAP_BYTECODE]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 2)
      💬 Args: [address(bootstrap), "NexusBootstrap"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Deploys the NexusBootstrap contract from --via-ir precompiled bytecode
