# Function: init()

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/KernelFactory.sol/contract_KernelFactory.md]

## Metadata

- **Contract**: KernelFactory
- **Signature**: `init()`
- **Visibility**: public
- **Source Range**: 1257:204:156

## Implementation

```solidity
function init() override public {
    kernelImpl = deployKernel(ENTRYPOINT_ADDR);
    factory = deployKernelFactory(address(kernelImpl));
    hookMultiPlexer = new MockHookMultiPlexer();
}
```

## Related Implementations

### deployKernel(address)

- **Kind**: internal
- **Source**: 833:322:183
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/KernelPrecompiles.sol:KernelPrecompiles:deployKernel(address)`

```solidity
function deployKernel(address entrypoint) internal returns (IKernel kernel) {
    bytes memory creationBytecode = bytes.concat(KERNEL_BYTECODE, abi.encode(entrypoint));
    kernel = IKernel(_deploy(creationBytecode));
    label(address(kernel), "Kernel");
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

### label(address,string)

- **Kind**: free-function
- **Source**: 971:93:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:label(address,string)`

```solidity
function label(address _addr, string memory _label) {
    Vm(VM_ADDR).label(_addr, _label);
}
```

### deployKernelFactory(address)

- **Kind**: internal
- **Source**: 1568:411:183
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/KernelPrecompiles.sol:KernelPrecompiles:deployKernelFactory(address)`

```solidity
function deployKernelFactory(address kernelImpl) internal returns (IKernelFactory kernelFactory) {
    bytes memory creationBytecode = bytes.concat(KERNEL_FACTORY_BYTECODE, abi.encode(kernelImpl));
    kernelFactory = IKernelFactory(_deploy(creationBytecode));
    label(address(kernelFactory), "KernelFactory");
}
```

## State Variable Reads

- **kernelImpl** (`contract IKernel`) [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IKernel.sol/interface_IKernel.md]
- **KERNEL_BYTECODE** (`bytes`)
- **KERNEL_FACTORY_BYTECODE** (`bytes`)

## State Variable Writes

- **kernelImpl** (`contract IKernel`) [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IKernel.sol/interface_IKernel.md]
- **factory** (`contract IKernelFactory`) [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IKernelFactory.sol/interface_IKernelFactory.md]
- **hookMultiPlexer** (`contract MockHookMultiPlexer`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelFactory.init() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: KernelPrecompiles.deployKernel(address) (NodeID: 1)
  │   💬 Args: [ENTRYPOINT_ADDR]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 2)
  │ │   💬 Args: [creationBytecode]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 3)
  │     💬 Args: [address(kernel), "Kernel"]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: KernelPrecompiles.deployKernelFactory(address) (NodeID: 4)
      💬 Args: [address(kernelImpl)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 5)
    │   💬 Args: [creationBytecode]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 6)
        💬 Args: [address(kernelFactory), "KernelFactory"]
        👁️  Def: internal
```
