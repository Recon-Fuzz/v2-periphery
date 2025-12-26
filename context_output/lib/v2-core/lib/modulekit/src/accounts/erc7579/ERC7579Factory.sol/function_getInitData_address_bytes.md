# Function: getInitData(address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/erc7579/ERC7579Factory.sol/contract_ERC7579Factory.md]

## Metadata

- **Contract**: ERC7579Factory
- **Signature**: `getInitData(address,bytes)`
- **Visibility**: public
- **Source Range**: 4176:745:151

## Implementation

```solidity
function getInitData(address validator, bytes memory initData) override public view returns (bytes memory _init) {
    ERC7579BootstrapConfig[] memory _validators = new ERC7579BootstrapConfig[](1);
    _validators[0].module = validator;
    _validators[0].data = initData;
    ERC7579BootstrapConfig[] memory _executors = new ERC7579BootstrapConfig[](0);
    ERC7579BootstrapConfig memory _hook;
    ERC7579BootstrapConfig[] memory _fallBacks = new ERC7579BootstrapConfig[](0);
    _init = abi.encode(address(bootstrapDefault), abi.encodeCall(IERC7579Bootstrap.initMSA, (_validators, _executors, _hook, _fallBacks)));
}
```

## State Variable Reads

- **bootstrapDefault** (`contract IERC7579Bootstrap`) [lib/v2-core/lib/modulekit/src/accounts/erc7579/interfaces/IERC7579Bootstrap.sol/interface_IERC7579Bootstrap.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Factory.getInitData(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
