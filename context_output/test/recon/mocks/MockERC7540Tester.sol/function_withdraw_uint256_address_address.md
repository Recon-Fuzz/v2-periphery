# Function: withdraw(uint256,address,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 7462:474:641

## Implementation

```solidity
function withdraw(uint256 assets, address receiver, address owner) public returns (uint256 shares) {
    shares = previewWithdraw(assets);
    if (msg.sender != owner) {
        allowance[owner][msg.sender] -= shares;
    }
    _burn(owner, shares);
    uint256 lossyAssets = assets - ((assets * lossOnWithdraw) / MAX_BPS);
    asset.transfer(receiver, lossyAssets);
    emit Withdraw(msg.sender, receiver, owner, lossyAssets, shares);
}
```

## Related Implementations

### previewWithdraw(uint256)

- **Kind**: internal
- **Source**: 2125:197:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:previewWithdraw(uint256)`

```solidity
function previewWithdraw(uint256 assets) virtual public view returns (uint256) {
    uint256 supply = totalSupply;
    return (supply == 0) ? assets : ((assets * supply) / totalAssets());
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

### _burn(address,uint256)

- **Kind**: internal
- **Source**: 7556:478:73
- **Link**: `lib/setup-helpers/src/MockERC20.sol:ERC20:_burn(address,uint256)`

```solidity
function _burn(address from, uint256 amount) virtual internal {
    uint256 fromBalance = balanceOf[from];
    if (fromBalance < amount) revert InsufficientBalance(from, fromBalance, amount);
    balanceOf[from] = fromBalance - amount;
    unchecked {
        totalSupply -= amount;
    }
    emit Transfer(from, address(0), amount);
}
```

## External Calls

- **MockERC20::transfer(address,uint256)**

## Native Transfers

- **asset** (computed)

## State Variable Reads

- **lossOnWithdraw** (`uint256`)
- **MAX_BPS** (`uint256`)
- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]
- **balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **balanceOf** (`mapping(address => uint256)`)
- **totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.withdraw(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC7575.previewWithdraw(uint256) (NodeID: 1)
  │   💬 Args: [assets]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC7575.totalAssets() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 3)
      💬 Args: [owner, shares]
      👁️  Def: internal
```
