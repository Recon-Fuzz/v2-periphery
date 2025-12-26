# Function: getInitData(address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/nexus/NexusFactory.sol/contract_NexusFactory.md]

## Metadata

- **Contract**: NexusFactory
- **Signature**: `getInitData(address,bytes)`
- **Visibility**: public
- **Source Range**: 2095:571:169

## Implementation

```solidity
function getInitData(address validator, bytes memory initData) override public view returns (bytes memory _init) {
    NexusBootstrapConfig memory config = NexusBootstrapConfig({module: validator, data: initData});
    address[] memory attesters = new address[](1);
    attesters[0] = address(0x000000333034E9f539ce08819E12c1b8Cb29084d);
    return bootstrapDefault.getInitNexusWithSingleValidatorCalldata(config, IERC7484(REGISTRY_ADDR), attesters, 1);
}
```

## External Calls

- **INexusBootstrap::getInitNexusWithSingleValidatorCalldata(struct BootstrapConfig,contract IERC7484,address[],uint8)**

## State Variable Reads

- **bootstrapDefault** (`contract INexusBootstrap`) [lib/v2-core/lib/modulekit/src/accounts/nexus/interfaces/INexusBootstrap.sol/interface_INexusBootstrap.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusFactory.getInitData(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
