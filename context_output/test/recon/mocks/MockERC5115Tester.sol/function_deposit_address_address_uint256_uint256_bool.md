# Function: deposit(address,address,uint256,uint256,bool)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `deposit(address,address,uint256,uint256,bool)`
- **Visibility**: public
- **Source Range**: 3186:431:639

## Implementation

```solidity
function deposit(address receiver, address tokenIn, uint256 amountTokenToDeposit, uint256 minSharesOut, bool depositFromInternalBalance) override public returns (uint256 amountSharesOut) {
    _performRevertBehaviour(revertBehaviour);
    return super.deposit(receiver, tokenIn, amountTokenToDeposit, minSharesOut, depositFromInternalBalance);
}
```

## Related Implementations

### _performRevertBehaviour(enum RevertType)

- **Kind**: internal
- **Source**: 4292:665:639
- **Link**: `test/recon/mocks/MockERC5115Tester.sol:MockERC5115Tester:_performRevertBehaviour(enum RevertType)`

```solidity
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

### deposit(address,address,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 856:582:639
- **Link**: `test/recon/mocks/MockERC5115Tester.sol:ERC5115:deposit(address,address,uint256,uint256,bool)`

```solidity
function deposit(address receiver, address tokenIn, uint256 amountTokenToDeposit, uint256, bool) virtual public returns (uint256 amountSharesOut) {
    amountSharesOut = previewDeposit(tokenIn, amountTokenToDeposit);
    MockERC20(tokenIn).transferFrom(msg.sender, address(this), amountTokenToDeposit);
    _mint(receiver, amountSharesOut);
    emit Deposit(msg.sender, receiver, tokenIn, amountTokenToDeposit, amountSharesOut);
}
```

### previewDeposit(address,uint256)

- **Kind**: internal
- **Source**: 1883:458:639
- **Link**: `test/recon/mocks/MockERC5115Tester.sol:ERC5115:previewDeposit(address,uint256)`

```solidity
function previewDeposit(address tokenIn, uint256 amountTokenToDeposit) virtual public view returns (uint256 amountSharesOut) {
    require(tokenIn == address(yieldToken), "Invalid token");
    uint256 supply = totalSupply;
    if (supply == 0) {
        return amountTokenToDeposit;
    }
    return (amountTokenToDeposit * supply) / yieldToken.balanceOf(address(this));
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

- **revertBehaviour** (`enum RevertType`)
- **yieldToken** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]
- **totalSupply** (`uint256`)

## State Variable Writes

- **totalSupply** (`uint256`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115Tester.deposit(address,address,uint256,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MockERC5115Tester._performRevertBehaviour(enum RevertType) (NodeID: 1)
  │   💬 Args: [revertBehaviour]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC5115.deposit(address,address,uint256,uint256,bool) (NodeID: 2)
      💬 Args: [receiver, tokenIn, amountTokenToDeposit, minSharesOut, depositFromInternalBalance]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ERC5115.previewDeposit(address,uint256) (NodeID: 3)
    │   💬 Args: [tokenIn, amountTokenToDeposit]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 4)
        💬 Args: [receiver, amountSharesOut]
        👁️  Def: internal
```
