# Function: eip712Domain()

**Contract**: [test/recon/mocks/MockSuperVault.sol/contract_MockSuperVault.md]

## Metadata

- **Contract**: MockSuperVault
- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 16034:435:643

## Implementation

```solidity
function eip712Domain() public view returns (bytes1, string memory, string memory, uint256, address, bytes32, uint256[] memory) {
    return (_eip712DomainReturn_0, _eip712DomainReturn_1, _eip712DomainReturn_2, _eip712DomainReturn_3, _eip712DomainReturn_4, _eip712DomainReturn_5, _eip712DomainReturn_6);
}
```

## State Variable Reads

- **_eip712DomainReturn_0** (`bytes1`)
- **_eip712DomainReturn_1** (`string`)
- **_eip712DomainReturn_2** (`string`)
- **_eip712DomainReturn_3** (`uint256`)
- **_eip712DomainReturn_4** (`address`)
- **_eip712DomainReturn_5** (`bytes32`)
- **_eip712DomainReturn_6** (`uint256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVault.eip712Domain() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
