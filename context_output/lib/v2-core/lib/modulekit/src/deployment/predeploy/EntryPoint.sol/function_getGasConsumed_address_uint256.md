# Function: getGasConsumed(address,uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `getGasConsumed(address,uint256)`
- **Visibility**: public
- **Source Range**: 390:137:91
- **Inherited From**: GasDebug

## Implementation

```solidity
function getGasConsumed(address account, uint256 phase) public view returns (uint256) {
    return gasConsumed[account][phase];
}
```

## State Variable Reads

- **gasConsumed** (`mapping(address => mapping(uint256 => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasDebug.getGasConsumed(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
