# Function: createAccountWithModules(bytes32,struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[])

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/erc7579/ERC7579Factory.sol/contract_ERC7579Factory.md]

## Metadata

- **Contract**: ERC7579Factory
- **Signature**: `createAccountWithModules(bytes32,struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[])`
- **Visibility**: public
- **Source Range**: 1043:644:151

## Implementation

```solidity
function createAccountWithModules(bytes32 salt, ERC7579BootstrapConfig[] calldata validators, ERC7579BootstrapConfig[] calldata executors, ERC7579BootstrapConfig calldata _fallback, ERC7579BootstrapConfig[] calldata hooks) virtual public payable returns (address) {
    bytes memory initData = abi.encode(bootstrapDefault, abi.encodeCall(IERC7579Bootstrap.initMSA, (validators, executors, _fallback, hooks)));
    address account = deployMSAPRoxy(salt, address(implementation), initData);
    return account;
}
```

## Related Implementations

### deployMSAPRoxy(bytes32,address,bytes)

- **Kind**: internal
- **Source**: 877:466:182
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/ERC7579Precompiles.sol:ERC7579Precompiles:deployMSAPRoxy(bytes32,address,bytes)`

```solidity
function deployMSAPRoxy(bytes32 salt, address implementation, bytes memory initCode) internal returns (address) {
    return _deploy2(bytes.concat(MSAPROXY_BYTECODE, abi.encode(implementation, abi.encodeWithSelector(IMSA.initializeAccount.selector, initCode))), salt);
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

- **bootstrapDefault** (`contract IERC7579Bootstrap`) [lib/v2-core/lib/modulekit/src/accounts/erc7579/interfaces/IERC7579Bootstrap.sol/interface_IERC7579Bootstrap.md]
- **implementation** (`contract IERC7579Account`) [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Account.sol/interface_IERC7579Account.md]
- **MSAPROXY_BYTECODE** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Factory.createAccountWithModules(bytes32,struct BootstrapConfig[],struct BootstrapConfig[],struct BootstrapConfig,struct BootstrapConfig[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC7579Precompiles.deployMSAPRoxy(bytes32,address,bytes) (NodeID: 1)
      💬 Args: [salt, address(implementation), initData]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy2(bytes,bytes32) (NodeID: 2)
        💬 Args: [bytes.concat(MSAPROXY_BYTECODE, abi.encode(implementation, abi.encodeWithSelector(IMSA.initializeAccount.selector, initCode))), salt]
        👁️  Def: internal
```
