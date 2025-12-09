# Function: maxMint(address)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `maxMint(address)`
- **Visibility**: public
- **Source Range**: 2924:105:637
- **Inherited From**: ERC4626

## Implementation

```solidity
function maxMint(address) virtual public view returns (uint256) {
    return type(uint256).max;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626.maxMint(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
