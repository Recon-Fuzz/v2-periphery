# Function: setNexusFactory(address)

**Contract**: [lib/v2-core/test/mocks/MockTargetExecutor.sol/contract_MockTargetExecutor.md]

## Metadata

- **Contract**: MockTargetExecutor
- **Signature**: `setNexusFactory(address)`
- **Visibility**: external
- **Source Range**: 2029:117:487

## Implementation

```solidity
function setNexusFactory(address nexusFactory_) external {
    nexusFactory = INexusFactory(nexusFactory_);
}
```

## State Variable Writes

- **nexusFactory** (`contract INexusFactory`) [lib/v2-core/src/vendor/nexus/INexusFactory.sol/interface_INexusFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTargetExecutor.setNexusFactory(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
