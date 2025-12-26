# Function: init()

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/safe/SafeFactory.sol/contract_SafeFactory.md]

## Metadata

- **Contract**: SafeFactory
- **Signature**: `init()`
- **Visibility**: public
- **Source Range**: 1032:253:173

## Implementation

```solidity
function init() override public {
    safe7579 = deploySafe7579();
    launchpad = deploySafe7579Launchpad(ENTRYPOINT_ADDR, REGISTRY_ADDR);
    safeSingleton = deploySafeSingleton();
    safeProxyFactory = deploySafeProxyFactory();
}
```

## Related Implementations

### deploySafe7579()

- **Kind**: internal
- **Source**: 732:182:185
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/Safe7579Precompiles.sol:Safe7579Precompiles:deploySafe7579()`

```solidity
function deploySafe7579() internal returns (ISafe7579 safe) {
    safe = ISafe7579(_deploy2(SAFE7579_BYTECODE, keccak256("123")));
    label(address(safe), "Safe7579");
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

### deploySafe7579Launchpad(address,address)

- **Kind**: internal
- **Source**: 920:500:185
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/Safe7579Precompiles.sol:Safe7579Precompiles:deploySafe7579Launchpad(address,address)`

```solidity
function deploySafe7579Launchpad(address entrypoint, address registry) internal returns (ISafe7579Launchpad safeLaunchpad) {
    bytes memory creationBytecode = bytes.concat(SAFE7579_LAUNCHPAD_BYTECODE, abi.encode(entrypoint, registry));
    safeLaunchpad = ISafe7579Launchpad(_deploy2(creationBytecode, keccak256("123")));
    label(address(safeLaunchpad), "Safe7579Launchpad");
}
```

### deploySafeSingleton()

- **Kind**: internal
- **Source**: 1426:203:185
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/Safe7579Precompiles.sol:Safe7579Precompiles:deploySafeSingleton()`

```solidity
function deploySafeSingleton() internal returns (address safeSingleton) {
    safeSingleton = _deploy2(SAFE_SINGLETON_BYTECODE, keccak256("123"));
    label(safeSingleton, "SafeSingleton");
}
```

### deploySafeProxyFactory()

- **Kind**: internal
- **Source**: 1635:260:185
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/Safe7579Precompiles.sol:Safe7579Precompiles:deploySafeProxyFactory()`

```solidity
function deploySafeProxyFactory() internal returns (ISafeProxyFactory safeProxyFactory) {
    safeProxyFactory = ISafeProxyFactory(_deploy2(SAFE_PROXY_FACTORY_BYTECODE, keccak256("123")));
    label(address(safeProxyFactory), "SafeProxyFactory");
}
```

## State Variable Reads

- **SAFE7579_BYTECODE** (`bytes`)
- **SAFE7579_LAUNCHPAD_BYTECODE** (`bytes`)
- **SAFE_SINGLETON_BYTECODE** (`bytes`)
- **SAFE_PROXY_FACTORY_BYTECODE** (`bytes`)

## State Variable Writes

- **safe7579** (`contract ISafe7579`) [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafe7579.sol/interface_ISafe7579.md]
- **launchpad** (`contract ISafe7579Launchpad`) [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafe7579Launchpad.sol/interface_ISafe7579Launchpad.md]
- **safeSingleton** (`address`)
- **safeProxyFactory** (`contract ISafeProxyFactory`) [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafeProxyFactory.sol/interface_ISafeProxyFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeFactory.init() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Safe7579Precompiles.deploySafe7579() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy2(bytes,bytes32) (NodeID: 2)
  │     💬 Args: [SAFE7579_BYTECODE, keccak256("123")]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Safe7579Precompiles.deploySafe7579Launchpad(address,address) (NodeID: 3)
  │   💬 Args: [ENTRYPOINT_ADDR, REGISTRY_ADDR]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy2(bytes,bytes32) (NodeID: 4)
  │     💬 Args: [creationBytecode, keccak256("123")]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Safe7579Precompiles.deploySafeSingleton() (NodeID: 5)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy2(bytes,bytes32) (NodeID: 6)
  │     💬 Args: [SAFE_SINGLETON_BYTECODE, keccak256("123")]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Safe7579Precompiles.deploySafeProxyFactory() (NodeID: 7)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy2(bytes,bytes32) (NodeID: 8)
        💬 Args: [SAFE_PROXY_FACTORY_BYTECODE, keccak256("123")]
        👁️  Def: internal
```
