# Function: init()

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/erc7579/ERC7579Factory.sol/contract_ERC7579Factory.md]

## Metadata

- **Contract**: ERC7579Factory
- **Signature**: `init()`
- **Visibility**: public
- **Source Range**: 717:141:151

## Implementation

```solidity
function init() override public {
    implementation = deployERC7579Account();
    bootstrapDefault = deployERC7579Bootstrap();
}
```

## Related Implementations

### deployERC7579Account()

- **Kind**: internal
- **Source**: 738:133:182
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/ERC7579Precompiles.sol:ERC7579Precompiles:deployERC7579Account()`

```solidity
function deployERC7579Account() internal returns (IERC7579Account) {
    return IERC7579Account(_deploy(ERC7579_BYTECODE));
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

### deployERC7579Bootstrap()

- **Kind**: internal
- **Source**: 1349:149:182
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/ERC7579Precompiles.sol:ERC7579Precompiles:deployERC7579Bootstrap()`

```solidity
function deployERC7579Bootstrap() internal returns (IERC7579Bootstrap) {
    return IERC7579Bootstrap(_deploy(ERC7579_BOOTSTRAP_BYTECODE));
}
```

## State Variable Reads

- **ERC7579_BYTECODE** (`bytes`)
- **ERC7579_BOOTSTRAP_BYTECODE** (`bytes`)

## State Variable Writes

- **implementation** (`contract IERC7579Account`) [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Account.sol/interface_IERC7579Account.md]
- **bootstrapDefault** (`contract IERC7579Bootstrap`) [lib/v2-core/lib/modulekit/src/accounts/erc7579/interfaces/IERC7579Bootstrap.sol/interface_IERC7579Bootstrap.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Factory.init() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC7579Precompiles.deployERC7579Account() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 2)
  │     💬 Args: [ERC7579_BYTECODE]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC7579Precompiles.deployERC7579Bootstrap() (NodeID: 3)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 4)
        💬 Args: [ERC7579_BOOTSTRAP_BYTECODE]
        👁️  Def: internal
```
