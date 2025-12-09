# Function: redeem(uint256,address,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 7942:470:641

## Implementation

```solidity
function redeem(uint256 shares, address receiver, address owner) public returns (uint256 assets) {
    assets = previewRedeem(shares);
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

### previewRedeem(uint256)

- **Kind**: internal
- **Source**: 2328:124:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:previewRedeem(uint256)`

```solidity
function previewRedeem(uint256 shares) virtual public view returns (uint256) {
    return convertToAssets(shares);
}
```

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
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.redeem(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC7575.previewRedeem(uint256) (NodeID: 1)
  │   💬 Args: [shares]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC7575.convertToAssets(uint256) (NodeID: 2)
  │     💬 Args: [shares]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: ERC7575.totalAssets() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 4)
      💬 Args: [owner, shares]
      👁️  Def: internal
```
