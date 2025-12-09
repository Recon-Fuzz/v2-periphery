# Function: setGetGasInfoReturn(struct MockSuperGovernor.ISuperGovernor_GasInfo)

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetGasInfoReturn(struct MockSuperGovernor.ISuperGovernor_GasInfo)`
- **Visibility**: public
- **Source Range**: 11234:121:642

## Implementation

```solidity
function setGetGasInfoReturn(ISuperGovernor_GasInfo memory _value0) public {
    _getGasInfoReturn_0 = _value0;
}
```

## State Variable Writes

- **_getGasInfoReturn_0** (`struct MockSuperGovernor.ISuperGovernor_GasInfo`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetGasInfoReturn(struct MockSuperGovernor.ISuperGovernor_GasInfo) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
