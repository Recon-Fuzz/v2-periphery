# Function: createAccountWithModules(bytes32,struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[])

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/nexus/NexusFactory.sol/contract_NexusFactory.md]

## Metadata

- **Contract**: NexusFactory
- **Signature**: `createAccountWithModules(bytes32,struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[])`
- **Visibility**: public
- **Source Range**: 2672:839:169

## Implementation

```solidity
function createAccountWithModules(bytes32 salt, NexusBootstrapConfig[] calldata validators, NexusBootstrapConfig[] calldata executors, NexusBootstrapConfig calldata hook, NexusBootstrapConfig[] calldata fallbacks) virtual public payable returns (address) {
    address[] memory attesters = new address[](1);
    attesters[0] = address(0x000000333034E9f539ce08819E12c1b8Cb29084d);
    bytes memory initData = abi.encode(bootstrapDefault, abi.encodeCall(INexusBootstrap.initNexus, (validators, executors, hook, fallbacks, IERC7484(REGISTRY_ADDR), attesters, 1)));
    address account = deployNexusProxy(salt, nexusImpl, initData);
    return account;
}
```

## Related Implementations

### deployNexusProxy(bytes32,address,bytes)

- **Kind**: internal
- **Source**: 1232:473:184
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/NexusPrecompiles.sol:NexusPrecompiles:deployNexusProxy(bytes32,address,bytes)`

```solidity
/// @notice Deploys NexusProxy from --via-ir precompiled bytecode
function deployNexusProxy(bytes32 salt, address implementation, bytes memory initCode) internal returns (address) {
    return _deploy2(bytes.concat(NEXUS_PROXY_BYTECODE, abi.encode(implementation, abi.encodeWithSelector(INexus.initializeAccount.selector, initCode))), salt);
}
```

### _deploy2(bytes,bytes32)

- **Kind**: internal
- **Source**: 708:492:181
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/BytecodeDeployer.sol:BytecodeDeployer:_deploy2(bytes,bytes32)`

```solidity
/// @notice Deploys a contract using CREATE2, reverts on failure
function _deploy2(bytes memory creationBytecode, bytes32 salt) internal returns (address contractAddress) {
    assembly {
        contractAddress := create2(0, add(creationBytecode, 0x20), mload(creationBytecode), salt)
    }
    require(contractAddress != address(0), "Deployer: deployment failed");
}
```

## State Variable Reads

- **bootstrapDefault** (`contract INexusBootstrap`) [lib/v2-core/lib/modulekit/src/accounts/nexus/interfaces/INexusBootstrap.sol/interface_INexusBootstrap.md]
- **nexusImpl** (`address`)
- **NEXUS_PROXY_BYTECODE** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusFactory.createAccountWithModules(bytes32,struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: NexusPrecompiles.deployNexusProxy(bytes32,address,bytes) (NodeID: 1)
      💬 Args: [salt, nexusImpl, initData]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy2(bytes,bytes32) (NodeID: 2)
        💬 Args: [bytes.concat(NEXUS_PROXY_BYTECODE, abi.encode(implementation, abi.encodeWithSelector(INexus.initializeAccount.selector, initCode))), salt]
        👁️  Def: internal
```
