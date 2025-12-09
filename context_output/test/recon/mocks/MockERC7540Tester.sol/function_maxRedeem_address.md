# Function: maxRedeem(address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 1677:112:641
- **Inherited From**: ERC7575

## Implementation

```solidity
function maxRedeem(address owner) virtual public view returns (uint256) {
    return balanceOf[owner];
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7575.maxRedeem(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
