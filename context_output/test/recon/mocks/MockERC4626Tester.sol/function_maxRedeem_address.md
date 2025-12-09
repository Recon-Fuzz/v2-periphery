# Function: maxRedeem(address)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 3172:112:637
- **Inherited From**: ERC4626

## Implementation

```solidity
function maxRedeem(address owner) virtual public view returns (uint256) {
    return balanceOf[owner];
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626.maxRedeem(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
