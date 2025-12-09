# Function: setGetProposedSuperBankHookMerkleRootReturn(bytes32,uint256)

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetProposedSuperBankHookMerkleRootReturn(bytes32,uint256)`
- **Visibility**: public
- **Source Range**: 12716:227:642

## Implementation

```solidity
function setGetProposedSuperBankHookMerkleRootReturn(bytes32 _value0, uint256 _value1) public {
    _getProposedSuperBankHookMerkleRootReturn_0 = _value0;
    _getProposedSuperBankHookMerkleRootReturn_1 = _value1;
}
```

## State Variable Writes

- **_getProposedSuperBankHookMerkleRootReturn_0** (`bytes32`)
- **_getProposedSuperBankHookMerkleRootReturn_1** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetProposedSuperBankHookMerkleRootReturn(bytes32,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
