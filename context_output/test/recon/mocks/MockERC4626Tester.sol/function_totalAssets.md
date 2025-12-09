# Function: totalAssets()

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 1620:115:637
- **Inherited From**: ERC4626

## Implementation

```solidity
function totalAssets() virtual public view returns (uint256) {
    return asset.balanceOf(address(this));
}
```

## External Calls

- **MockERC20::balanceOf(address)**

## State Variable Reads

- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626.totalAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
