# Function: totalAssets()

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 788:115:641
- **Inherited From**: ERC7575

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
┌─ [0] ⚙️ FUNCTION: ERC7575.totalAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
