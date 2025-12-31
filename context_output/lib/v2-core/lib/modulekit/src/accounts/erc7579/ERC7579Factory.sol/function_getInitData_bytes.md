# Function: getInitData(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/erc7579/ERC7579Factory.sol/contract_ERC7579Factory.md]

## Metadata

- **Contract**: ERC7579Factory
- **Signature**: `getInitData(bytes)`
- **Visibility**: public
- **Source Range**: 1693:743:151

## Implementation

```solidity
function getInitData(bytes memory initCode) public view returns (bytes memory _init) {
    (ERC7579BootstrapConfig[] memory _validators, ERC7579BootstrapConfig[] memory _executors, ERC7579BootstrapConfig memory hook, ERC7579BootstrapConfig[] memory fallbacks) = abi.decode(initCode, (ERC7579BootstrapConfig[], ERC7579BootstrapConfig[], ERC7579BootstrapConfig, ERC7579BootstrapConfig[]));
    _init = abi.encode(address(bootstrapDefault), abi.encodeCall(IERC7579Bootstrap.initMSA, (_validators, _executors, hook, fallbacks)));
}
```

## State Variable Reads

- **bootstrapDefault** (`contract IERC7579Bootstrap`) [lib/v2-core/lib/modulekit/src/accounts/erc7579/interfaces/IERC7579Bootstrap.sol/interface_IERC7579Bootstrap.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Factory.getInitData(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
