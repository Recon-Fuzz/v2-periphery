# Function: mint(uint256,address)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 5183:204:637

## Implementation

```solidity
/// @dev Mint shares, reverts as specified
function mint(uint256 shares, address receiver) override public returns (uint256) {
    _performRevertBehaviour(revertBehaviours[FunctionType.MINT]);
    return super.mint(shares, receiver);
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

### mint(uint256,address)

- **Kind**: internal
- **Source**: 905:213:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:mint(uint256,address)`

```solidity
function mint(uint256 shares, address receiver) virtual public returns (uint256) {
    uint256 assets = previewMint(shares);
    _deposit(msg.sender, receiver, assets, shares);
    return assets;
}
```

### previewMint(uint256)

- **Kind**: internal
- **Source**: 6621:195:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:MockERC4626Tester:previewMint(uint256)`

```solidity
/// @dev Preview mint, reverts as specified
function previewMint(uint256 shares) override public view returns (uint256) {
    _performRevertBehaviour(revertBehaviours[FunctionType.MINT]);
    return super.previewMint(shares);
}
```

### previewMint(uint256)

- **Kind**: internal
- **Source**: 2278:193:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:previewMint(uint256)`

```solidity
function previewMint(uint256 shares) virtual public view returns (uint256) {
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

### _deposit(address,address,uint256,uint256)

- **Kind**: internal
- **Source**: 3290:256:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:_deposit(address,address,uint256,uint256)`

```solidity
function _deposit(address caller, address receiver, uint256 assets, uint256 shares) virtual internal {
    asset.transferFrom(caller, address(this), assets);
    _mint(receiver, shares);
    emit Deposit(caller, receiver, assets, shares);
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

## State Variable Reads

- **revertBehaviours** (`mapping(enum FunctionType => enum RevertType)`)
- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]
- **totalSupply** (`uint256`)

## State Variable Writes

- **totalSupply** (`uint256`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626Tester.mint(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MockERC4626Tester._performRevertBehaviour(enum RevertType) (NodeID: 1)
  │   💬 Args: [revertBehaviours[FunctionType.MINT]]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC4626.mint(uint256,address) (NodeID: 2)
      💬 Args: [shares, receiver]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: MockERC4626Tester.previewMint(uint256) (NodeID: 3)
    │   💬 Args: [shares]
    │   👁️  Def: public
    │ ├─ [3] ⚙️ FUNCTION: MockERC4626Tester._performRevertBehaviour(enum RevertType) (NodeID: 4)
    │ │   💬 Args: [revertBehaviours[FunctionType.MINT]]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ERC4626.previewMint(uint256) (NodeID: 5)
    │     💬 Args: [shares]
    │     👁️  Def: public
    │   └─ [4] ⚙️ FUNCTION: ERC4626.totalAssets() (NodeID: 6)
    │       💬 Args: [no args]
    │       👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC4626._deposit(address,address,uint256,uint256) (NodeID: 7)
        💬 Args: [msg.sender, receiver, assets, shares]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 8)
          💬 Args: [receiver, shares]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Mint shares, reverts as specified
