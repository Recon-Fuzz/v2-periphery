# Function: setGetVaultInfoReturn(address,address,uint8)

**Contract**: [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]

## Metadata

- **Contract**: MockSuperVaultStrategy
- **Signature**: `setGetVaultInfoReturn(address,address,uint8)`
- **Visibility**: public
- **Source Range**: 4275:217:645

## Implementation

```solidity
function setGetVaultInfoReturn(address _value0, address _value1, uint8 _value2) public {
    _getVaultInfoReturn_0 = _value0;
    _getVaultInfoReturn_1 = _value1;
    _getVaultInfoReturn_2 = _value2;
}
```

## State Variable Writes

- **_getVaultInfoReturn_0** (`address`)
- **_getVaultInfoReturn_1** (`address`)
- **_getVaultInfoReturn_2** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultStrategy.setGetVaultInfoReturn(address,address,uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
