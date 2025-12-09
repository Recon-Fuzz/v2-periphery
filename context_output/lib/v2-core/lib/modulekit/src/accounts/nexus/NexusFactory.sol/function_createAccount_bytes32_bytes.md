# Function: createAccount(bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/nexus/NexusFactory.sol/contract_NexusFactory.md]

## Metadata

- **Contract**: NexusFactory
- **Signature**: `createAccount(bytes32,bytes)`
- **Visibility**: public
- **Source Range**: 1170:219:169

## Implementation

```solidity
function createAccount(bytes32 salt, bytes memory initCode) override public returns (address account) {
    return deployNexusProxy(salt, nexusImpl, initCode);
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

- **nexusImpl** (`address`)
- **NEXUS_PROXY_BYTECODE** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusFactory.createAccount(bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: NexusPrecompiles.deployNexusProxy(bytes32,address,bytes) (NodeID: 1)
      💬 Args: [salt, nexusImpl, initCode]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy2(bytes,bytes32) (NodeID: 2)
        💬 Args: [bytes.concat(NEXUS_PROXY_BYTECODE, abi.encode(implementation, abi.encodeWithSelector(INexus.initializeAccount.selector, initCode))), salt]
        👁️  Def: internal
```
