# Function: getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[])

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/erc7579/ERC7579Factory.sol/contract_ERC7579Factory.md]

## Metadata

- **Contract**: ERC7579Factory
- **Signature**: `getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[])`
- **Visibility**: public
- **Source Range**: 2442:1000:151

## Implementation

```solidity
function getInitData(IAccountFactory.ModuleInitData[] memory _validators, IAccountFactory.ModuleInitData[] memory _executors, IAccountFactory.ModuleInitData memory _hook, IAccountFactory.ModuleInitData[] memory _fallbacks) public view returns (bytes memory _init) {
    ERC7579BootstrapConfig[] memory validators = abi.decode(abi.encode(_validators), (ERC7579BootstrapConfig[]));
    ERC7579BootstrapConfig[] memory executors = abi.decode(abi.encode(_executors), (ERC7579BootstrapConfig[]));
    ERC7579BootstrapConfig memory hook = abi.decode(abi.encode(_hook), (ERC7579BootstrapConfig));
    ERC7579BootstrapConfig[] memory fallbacks = abi.decode(abi.encode(_fallbacks), (ERC7579BootstrapConfig[]));
    _init = abi.encode(address(bootstrapDefault), abi.encodeCall(IERC7579Bootstrap.initMSA, (validators, executors, hook, fallbacks)));
}
```

## State Variable Reads

- **bootstrapDefault** (`contract IERC7579Bootstrap`) [lib/v2-core/lib/modulekit/src/accounts/erc7579/interfaces/IERC7579Bootstrap.sol/interface_IERC7579Bootstrap.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Factory.getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
