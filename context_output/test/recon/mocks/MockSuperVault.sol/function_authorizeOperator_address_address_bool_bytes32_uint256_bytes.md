# Function: authorizeOperator(address,address,bool,bytes32,uint256,bytes)

**Contract**: [test/recon/mocks/MockSuperVault.sol/contract_MockSuperVault.md]

## Metadata

- **Contract**: MockSuperVault
- **Signature**: `authorizeOperator(address,address,bool,bytes32,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 14350:360:643

## Implementation

```solidity
function authorizeOperator(address, address, bool, bytes32, uint256, bytes memory) public view returns (bool) {
    return _authorizeOperatorReturn_0;
}
```

## State Variable Reads

- **_authorizeOperatorReturn_0** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVault.authorizeOperator(address,address,bool,bytes32,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
