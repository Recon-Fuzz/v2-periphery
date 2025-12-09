# Function: maxWithdraw(address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 1540:131:641
- **Inherited From**: ERC7575

## Implementation

```solidity
function maxWithdraw(address owner) virtual public view returns (uint256) {
    return convertToAssets(balanceOf[owner]);
}
```

## Related Implementations

### convertToAssets(uint256)

- **Kind**: internal
- **Source**: 1112:197:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:convertToAssets(uint256)`

```solidity
function convertToAssets(uint256 shares) virtual public view returns (uint256) {
    uint256 supply = totalSupply;
    return (supply == 0) ? shares : ((shares * totalAssets()) / supply);
}
```

### totalAssets()

- **Kind**: internal
- **Source**: 788:115:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:totalAssets()`

```solidity
function totalAssets() virtual public view returns (uint256) {
    return asset.balanceOf(address(this));
}
```

## State Variable Reads

- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7575.maxWithdraw(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC7575.convertToAssets(uint256) (NodeID: 1)
      💬 Args: [balanceOf[owner]]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC7575.totalAssets() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: public
```
