# Function: redeem(uint256,address,address)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 5903:403:637

## Implementation

```solidity
/// @dev Redeem shares, reverts as specified
function redeem(uint256 shares, address receiver, address owner) override public returns (uint256) {
    _performRevertBehaviour(revertBehaviours[FunctionType.REDEEM]);
    uint256 assets = previewRedeem(shares);
    uint256 lossyAssets = assets - ((assets * lossOnWithdraw) / MAX_BPS);
    _withdraw(msg.sender, receiver, owner, lossyAssets, shares);
    return lossyAssets;
}
```

## Related Implementations

### _performRevertBehaviour(enum RevertType)

- **Kind**: internal
- **Source**: 7411:758:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:MockERC4626Tester:_performRevertBehaviour(enum RevertType)`

```solidity
/// @dev Revert in different ways to test the revert behaviour
function _performRevertBehaviour(RevertType action) internal pure {
    if (action == RevertType.THROW) {
        revert("A normal Revert");
    }
    if (action == RevertType.OOG) {
        uint256 i;
        while (true) {
            ++i;
        }
    }
    if (action == RevertType.RETURN_BOMB) {
        uint256 _bytes = 2_000_000;
        assembly {
            return(0, _bytes)
        }
    }
    if (action == RevertType.REVERT_BOMB) {
        uint256 _bytes = 2_000_000;
        assembly {
            revert(0, _bytes)
        }
    }
    return;
}
```

### previewRedeem(uint256)

- **Kind**: internal
- **Source**: 7137:201:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:MockERC4626Tester:previewRedeem(uint256)`

```solidity
/// @dev Preview redeem, reverts as specified
function previewRedeem(uint256 shares) override public view returns (uint256) {
    _performRevertBehaviour(revertBehaviours[FunctionType.REDEEM]);
    return super.previewRedeem(shares);
}
```

### previewRedeem(uint256)

- **Kind**: internal
- **Source**: 2680:124:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:previewRedeem(uint256)`

```solidity
function previewRedeem(uint256 shares) virtual public view returns (uint256) {
    return convertToAssets(shares);
}
```

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

### _withdraw(address,address,address,uint256,uint256)

- **Kind**: internal
- **Source**: 3552:415:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:_withdraw(address,address,address,uint256,uint256)`

```solidity
function _withdraw(address caller, address receiver, address owner, uint256 assets, uint256 shares) virtual internal {
    if (caller != owner) {
        allowance[owner][caller] -= shares;
    }
    _burn(owner, shares);
    asset.transfer(receiver, assets);
    emit Withdraw(caller, receiver, owner, assets, shares);
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

## State Variable Reads

- **revertBehaviours** (`mapping(enum FunctionType => enum RevertType)`)
- **lossOnWithdraw** (`uint256`)
- **MAX_BPS** (`uint256`)
- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]
- **balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **balanceOf** (`mapping(address => uint256)`)
- **totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626Tester.redeem(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MockERC4626Tester._performRevertBehaviour(enum RevertType) (NodeID: 1)
  │   💬 Args: [revertBehaviours[FunctionType.REDEEM]]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MockERC4626Tester.previewRedeem(uint256) (NodeID: 2)
  │   💬 Args: [shares]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: MockERC4626Tester._performRevertBehaviour(enum RevertType) (NodeID: 3)
  │ │   💬 Args: [revertBehaviours[FunctionType.REDEEM]]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC4626.previewRedeem(uint256) (NodeID: 4)
  │     💬 Args: [shares]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: ERC4626.convertToAssets(uint256) (NodeID: 5)
  │       💬 Args: [shares]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: ERC4626.totalAssets() (NodeID: 6)
  │         💬 Args: [no args]
  │         👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC4626._withdraw(address,address,address,uint256,uint256) (NodeID: 7)
      💬 Args: [msg.sender, receiver, owner, lossyAssets, shares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 8)
        💬 Args: [owner, shares]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Redeem shares, reverts as specified
