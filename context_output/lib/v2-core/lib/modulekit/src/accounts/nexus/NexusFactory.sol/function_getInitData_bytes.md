# Function: getInitData(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/nexus/NexusFactory.sol/contract_NexusFactory.md]

## Metadata

- **Contract**: NexusFactory
- **Signature**: `getInitData(bytes)`
- **Visibility**: public
- **Source Range**: 4741:940:169

## Implementation

```solidity
function getInitData(bytes memory initData) public view returns (bytes memory _init) {
    (NexusBootstrapConfig[] memory validators, NexusBootstrapConfig[] memory executors, NexusBootstrapConfig memory hook, NexusBootstrapConfig[] memory fallbacks) = abi.decode(initData, (NexusBootstrapConfig[], NexusBootstrapConfig[], NexusBootstrapConfig, NexusBootstrapConfig[]));
    address[] memory attesters = new address[](1);
    attesters[0] = address(0x000000333034E9f539ce08819E12c1b8Cb29084d);
    _init = abi.encode(address(bootstrapDefault), abi.encodeCall(INexusBootstrap.initNexus, (validators, executors, hook, fallbacks, IERC7484(REGISTRY_ADDR), attesters, 1)));
}
```

## State Variable Reads

- **bootstrapDefault** (`contract INexusBootstrap`) [lib/v2-core/lib/modulekit/src/accounts/nexus/interfaces/INexusBootstrap.sol/interface_INexusBootstrap.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusFactory.getInitData(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
