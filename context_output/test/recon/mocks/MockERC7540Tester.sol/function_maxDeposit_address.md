# Function: maxDeposit(address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `maxDeposit(address)`
- **Visibility**: public
- **Source Range**: 1315:108:641
- **Inherited From**: ERC7575

## Implementation

```solidity
function maxDeposit(address) virtual public pure returns (uint256) {
    return type(uint256).max;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7575.maxDeposit(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
