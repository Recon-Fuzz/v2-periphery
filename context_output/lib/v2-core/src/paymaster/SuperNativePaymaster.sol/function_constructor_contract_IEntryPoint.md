# Function: constructor(contract IEntryPoint)

**Contract**: [lib/v2-core/src/paymaster/SuperNativePaymaster.sol/contract_SuperNativePaymaster.md]

## Metadata

- **Contract**: SuperNativePaymaster
- **Signature**: `constructor(contract IEntryPoint)`
- **Visibility**: public
- **Source Range**: 1300:75:436

## Implementation

```solidity
constructor(IEntryPoint _entryPoint) payable BasePaymaster(_entryPoint) {}
```

## Related Implementations

### (contract IEntryPoint)

- **Kind**: internal
- **Source**: 1244:129:442
- **Link**: `lib/v2-core/src/vendor/account-abstraction/BasePaymaster.sol:BasePaymaster:constructor(contract IEntryPoint)`

```solidity
constructor(IEntryPoint _entryPoint) {
    _validateEntryPointInterface(_entryPoint);
    entryPoint = _entryPoint;
}
```

### _validateEntryPointInterface(contract IEntryPoint)

- **Kind**: internal
- **Source**: 1492:252:442
- **Link**: `lib/v2-core/src/vendor/account-abstraction/BasePaymaster.sol:BasePaymaster:_validateEntryPointInterface(contract IEntryPoint)`

```solidity
function _validateEntryPointInterface(IEntryPoint _entryPoint) virtual internal {
    require(IERC165(address(_entryPoint)).supportsInterface(type(IEntryPoint).interfaceId), "IEntryPoint interface mismatch");
}
```

## State Variable Writes

- **entryPoint** (`contract IEntryPoint`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IEntryPoint.sol/interface_IEntryPoint.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperNativePaymaster.constructor(contract IEntryPoint) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperNativePaymaster
  └─ [1] 🏗️ CONSTRUCTOR: BasePaymaster.constructor(contract IEntryPoint) (NodeID: 1)
      💬 Args: [_entryPoint]
      🏗️  Contract: BasePaymaster
    └─ [2] ⚙️ FUNCTION: BasePaymaster._validateEntryPointInterface(contract IEntryPoint) (NodeID: 2)
        💬 Args: [_entryPoint]
        👁️  Def: internal
```
