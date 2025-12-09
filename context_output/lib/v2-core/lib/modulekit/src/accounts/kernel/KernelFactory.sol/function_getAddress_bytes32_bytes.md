# Function: getAddress(bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/KernelFactory.sol/contract_KernelFactory.md]

## Metadata

- **Contract**: KernelFactory
- **Signature**: `getAddress(bytes32,bytes)`
- **Visibility**: public
- **Source Range**: 1681:141:156

## Implementation

```solidity
function getAddress(bytes32 salt, bytes memory data) override public returns (address) {
    return factory.getAddress(data, salt);
}
```

## External Calls

- **IKernelFactory::getAddress(bytes,bytes32)**

## State Variable Reads

- **factory** (`contract IKernelFactory`) [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IKernelFactory.sol/interface_IKernelFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelFactory.getAddress(bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
