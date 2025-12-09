# Function: redeem(address,uint256,address,uint256,bool)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `redeem(address,uint256,address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 3623:663:639

## Implementation

```solidity
function redeem(address receiver, uint256 amountSharesToRedeem, address tokenOut, uint256, bool) virtual public returns (uint256 amountTokenOut) {
    amountTokenOut = previewRedeem(tokenOut, amountSharesToRedeem);
    _burn(msg.sender, amountSharesToRedeem);
    uint256 lossyAmountTokenOut = amountTokenOut - ((amountTokenOut * lossOnWithdraw) / MAX_BPS);
    MockERC20(tokenOut).transfer(receiver, lossyAmountTokenOut);
    emit Redeem(msg.sender, receiver, tokenOut, amountSharesToRedeem, amountTokenOut);
}
```

## Related Implementations

### previewRedeem(address,uint256)

- **Kind**: internal
- **Source**: 2347:458:639
- **Link**: `test/recon/mocks/MockERC5115Tester.sol:ERC5115:previewRedeem(address,uint256)`

```solidity
function previewRedeem(address tokenOut, uint256 amountSharesToRedeem) virtual public view returns (uint256 amountTokenOut) {
    require(tokenOut == address(yieldToken), "Invalid token");
    uint256 supply = totalSupply;
    if (supply == 0) {
        return amountSharesToRedeem;
    }
    return (amountSharesToRedeem * yieldToken.balanceOf(address(this))) / supply;
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

- **unknown** (computed)

## State Variable Reads

- **lossOnWithdraw** (`uint256`)
- **MAX_BPS** (`uint256`)
- **yieldToken** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]
- **balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **balanceOf** (`mapping(address => uint256)`)
- **totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115Tester.redeem(address,uint256,address,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC5115.previewRedeem(address,uint256) (NodeID: 1)
  │   💬 Args: [tokenOut, amountSharesToRedeem]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 2)
      💬 Args: [msg.sender, amountSharesToRedeem]
      👁️  Def: internal
```
