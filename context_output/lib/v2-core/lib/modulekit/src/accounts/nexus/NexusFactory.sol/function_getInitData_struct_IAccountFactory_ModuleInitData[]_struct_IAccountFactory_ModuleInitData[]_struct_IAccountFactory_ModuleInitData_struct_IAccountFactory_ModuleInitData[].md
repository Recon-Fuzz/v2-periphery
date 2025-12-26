# Function: getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[])

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/nexus/NexusFactory.sol/contract_NexusFactory.md]

## Metadata

- **Contract**: NexusFactory
- **Signature**: `getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[])`
- **Visibility**: public
- **Source Range**: 3517:1218:169

## Implementation

```solidity
function getInitData(IAccountFactory.ModuleInitData[] memory _validators, IAccountFactory.ModuleInitData[] memory _executors, IAccountFactory.ModuleInitData memory _hook, IAccountFactory.ModuleInitData[] memory _fallbacks) override public view returns (bytes memory _init) {
    NexusBootstrapConfig[] memory validators = abi.decode(abi.encode(_validators), (NexusBootstrapConfig[]));
    NexusBootstrapConfig[] memory executors = abi.decode(abi.encode(_executors), (NexusBootstrapConfig[]));
    NexusBootstrapConfig memory hook = abi.decode(abi.encode(_hook), (NexusBootstrapConfig));
    NexusBootstrapConfig[] memory fallbacks = abi.decode(abi.encode(_fallbacks), (NexusBootstrapConfig[]));
    address[] memory attesters = new address[](1);
    attesters[0] = address(0x000000333034E9f539ce08819E12c1b8Cb29084d);
    _init = abi.encode(address(bootstrapDefault), abi.encodeCall(INexusBootstrap.initNexus, (validators, executors, hook, fallbacks, IERC7484(REGISTRY_ADDR), attesters, 1)));
}
```

## State Variable Reads

- **bootstrapDefault** (`contract INexusBootstrap`) [lib/v2-core/lib/modulekit/src/accounts/nexus/interfaces/INexusBootstrap.sol/interface_INexusBootstrap.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusFactory.getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
