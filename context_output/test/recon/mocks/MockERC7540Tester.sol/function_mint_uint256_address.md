# Function: mint(uint256,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 2759:289:641
- **Inherited From**: ERC7575

## Implementation

```solidity
function mint(uint256 shares, address receiver) virtual public returns (uint256 assets) {
    assets = previewMint(shares);
    asset.transferFrom(msg.sender, address(this), assets);
    _mint(receiver, shares);
    emit Deposit(msg.sender, receiver, assets, shares);
}
```

## Related Implementations

### previewMint(uint256)

- **Kind**: internal
- **Source**: 1926:193:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:previewMint(uint256)`

```solidity
function previewMint(uint256 shares) virtual public view returns (uint256) {
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

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 7079:471:73
- **Link**: `lib/setup-helpers/src/MockERC20.sol:ERC20:_mint(address,uint256)`

```solidity
function _mint(address to, uint256 amount) virtual internal {
    uint256 newTotalSupply = totalSupply + amount;
    if (newTotalSupply < totalSupply) revert MintOverflow(totalSupply, amount);
    totalSupply = newTotalSupply;
    unchecked {
        balanceOf[to] += amount;
    }
    emit Transfer(address(0), to, amount);
}
```

## External Calls

- **MockERC20::transferFrom(address,address,uint256)**

## State Variable Reads

- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]
- **totalSupply** (`uint256`)

## State Variable Writes

- **totalSupply** (`uint256`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7575.mint(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC7575.previewMint(uint256) (NodeID: 1)
  │   💬 Args: [shares]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC7575.totalAssets() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 3)
      💬 Args: [receiver, shares]
      👁️  Def: internal
```
