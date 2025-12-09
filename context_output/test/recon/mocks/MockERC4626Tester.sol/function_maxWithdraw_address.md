# Function: maxWithdraw(address)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 3035:131:637
- **Inherited From**: ERC4626

## Implementation

```solidity
function maxWithdraw(address owner) virtual public view returns (uint256) {
    return convertToAssets(balanceOf[owner]);
}
```

## Related Implementations

### convertToAssets(uint256)

- **Kind**: internal
- **Source**: 1944:197:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:convertToAssets(uint256)`

```solidity
function convertToAssets(uint256 shares) virtual public view returns (uint256) {
    uint256 supply = totalSupply;
    return (supply == 0) ? shares : ((shares * totalAssets()) / supply);
}
```

### totalAssets()

- **Kind**: internal
- **Source**: 1620:115:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:totalAssets()`

```solidity
function totalAssets() virtual public view returns (uint256) {
    return asset.balanceOf(address(this));
}
```

## State Variable Reads

- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626.maxWithdraw(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC4626.convertToAssets(uint256) (NodeID: 1)
      💬 Args: [balanceOf[owner]]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC4626.totalAssets() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: public
```
