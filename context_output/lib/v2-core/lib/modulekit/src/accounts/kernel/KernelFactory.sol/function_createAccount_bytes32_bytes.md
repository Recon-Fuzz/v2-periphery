# Function: createAccount(bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/KernelFactory.sol/contract_KernelFactory.md]

## Metadata

- **Contract**: KernelFactory
- **Signature**: `createAccount(bytes32,bytes)`
- **Visibility**: public
- **Source Range**: 1467:208:156

## Implementation

```solidity
function createAccount(bytes32 salt, bytes memory data) override public returns (address account) {
    account = factory.createAccount(data, salt);
}
```

## External Calls

- **IKernelFactory::createAccount(bytes,bytes32)**

## State Variable Reads

- **factory** (`contract IKernelFactory`) [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IKernelFactory.sol/interface_IKernelFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelFactory.createAccount(bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
