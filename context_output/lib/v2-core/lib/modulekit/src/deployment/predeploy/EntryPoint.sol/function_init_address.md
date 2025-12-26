# Function: init(address)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `init(address)`
- **Visibility**: public
- **Source Range**: 595:123:187

## Implementation

```solidity
function init(address entrypointAddr) public {
    _entrypointAddr = entrypointAddr;
    initSenderCreator();
}
```

## Related Implementations

### initSenderCreator()

- **Kind**: internal
- **Source**: 724:342:187
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol:EntryPointSimulationsPatch:initSenderCreator()`

```solidity
function initSenderCreator() override internal {
    address createdObj = address(uint160(uint256(keccak256(abi.encodePacked(hex"d694", _entrypointAddr, hex"01")))));
    _newSenderCreator = SenderCreator(createdObj);
}
```

## State Variable Reads

- **_entrypointAddr** (`address`)

## State Variable Writes

- **_entrypointAddr** (`address`)
- **_newSenderCreator** (`contract SenderCreator`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/SenderCreator.sol/contract_SenderCreator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EntryPointSimulationsPatch.init(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: EntryPointSimulationsPatch.initSenderCreator() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
