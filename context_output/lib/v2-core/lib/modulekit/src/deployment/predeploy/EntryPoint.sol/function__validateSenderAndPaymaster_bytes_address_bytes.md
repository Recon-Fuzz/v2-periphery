# Function: _validateSenderAndPaymaster(bytes,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `_validateSenderAndPaymaster(bytes,address,bytes)`
- **Visibility**: external
- **Source Range**: 5490:718:90
- **Inherited From**: EntryPointSimulations

## Implementation

```solidity
///  Called only during simulation.
///  This function always reverts to prevent warm/cold storage differentiation in simulation vs execution.
///  @param initCode         - The smart account constructor code.
///  @param sender           - The sender address.
///  @param paymasterAndData - The paymaster address (followed by other params, ignored by this method)
function _validateSenderAndPaymaster(bytes calldata initCode, address sender, bytes calldata paymasterAndData) external view {
    if ((initCode.length == 0) && (sender.code.length == 0)) {
        revert("AA20 account not deployed");
    }
    if (paymasterAndData.length >= 20) {
        address paymaster = address(bytes20(paymasterAndData[0:20]));
        if (paymaster.code.length == 0) {
            revert("AA30 paymaster not deployed");
        }
    }
    revert("");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EntryPointSimulations._validateSenderAndPaymaster(bytes,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 Called only during simulation.
 This function always reverts to prevent warm/cold storage differentiation in simulation vs execution.
 @param initCode         - The smart account constructor code.
 @param sender           - The sender address.
 @param paymasterAndData - The paymaster address (followed by other params, ignored by this method)
