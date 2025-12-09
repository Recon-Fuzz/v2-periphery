# Function: setEip712DomainReturn(bytes1,string,string,uint256,address,bytes32,uint256[])

**Contract**: [test/recon/mocks/MockSuperVault.sol/contract_MockSuperVault.md]

## Metadata

- **Contract**: MockSuperVault
- **Signature**: `setEip712DomainReturn(bytes1,string,string,uint256,address,bytes32,uint256[])`
- **Visibility**: public
- **Source Range**: 3698:659:643

## Implementation

```solidity
function setEip712DomainReturn(bytes1 _value0, string memory _value1, string memory _value2, uint256 _value3, address _value4, bytes32 _value5, uint256[] memory _value6) public {
    _eip712DomainReturn_0 = _value0;
    _eip712DomainReturn_1 = _value1;
    _eip712DomainReturn_2 = _value2;
    _eip712DomainReturn_3 = _value3;
    _eip712DomainReturn_4 = _value4;
    _eip712DomainReturn_5 = _value5;
    delete _eip712DomainReturn_6;
    for (uint256 i = 0; i < _value6.length; i++) {
        _eip712DomainReturn_6.push(_value6[i]);
    }
}
```

## State Variable Writes

- **_eip712DomainReturn_0** (`bytes1`)
- **_eip712DomainReturn_1** (`string`)
- **_eip712DomainReturn_2** (`string`)
- **_eip712DomainReturn_3** (`uint256`)
- **_eip712DomainReturn_4** (`address`)
- **_eip712DomainReturn_5** (`bytes32`)
- **_eip712DomainReturn_6** (`uint256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVault.setEip712DomainReturn(bytes1,string,string,uint256,address,bytes32,uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
