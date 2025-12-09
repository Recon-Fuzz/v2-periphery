# Function: maxMint(address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `maxMint(address)`
- **Visibility**: public
- **Source Range**: 1429:105:641
- **Inherited From**: ERC7575

## Implementation

```solidity
function maxMint(address) virtual public pure returns (uint256) {
    return type(uint256).max;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7575.maxMint(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
