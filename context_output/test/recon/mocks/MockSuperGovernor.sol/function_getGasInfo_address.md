# Function: getGasInfo(address)

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `getGasInfo(address)`
- **Visibility**: public
- **Source Range**: 29889:178:642

## Implementation

```solidity
function getGasInfo(address) public view returns (ISuperGovernor_GasInfo memory) {
    return _getGasInfoReturn_0;
}
```

## State Variable Reads

- **_getGasInfoReturn_0** (`struct MockSuperGovernor.ISuperGovernor_GasInfo`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.getGasInfo(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
