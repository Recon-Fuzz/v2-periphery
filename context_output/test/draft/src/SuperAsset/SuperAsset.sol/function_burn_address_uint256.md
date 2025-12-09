# Function: burn(address,uint256)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 9050:113:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function burn(address from, uint256 amount) external {
    _onlyManager();
    _burn(from, amount);
}
```

## Related Implementations

### _onlyManager()

- **Kind**: internal
- **Source**: 42332:139:548
- **Link**: `test/draft/src/SuperAsset/SuperAsset.sol:SuperAsset:_onlyManager()`

```solidity
function _onlyManager() internal view {
    if (msg.sender != factory.getSuperAssetManager(address(this))) revert UNAUTHORIZED();
}
```

### _burn(address,uint256)

- **Kind**: internal
- **Source**: 7888:206:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_burn(address,uint256)`

```solidity
///  @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
///  Relies on the `_update` mechanism.
///  Emits a {Transfer} event with `to` set to the zero address.
///  NOTE: This function is not virtual, {_update} should be overridden instead
function _burn(address account, uint256 value) internal {
    if (account == address(0)) {
        revert ERC20InvalidSender(address(0));
    }
    _update(account, address(0), value);
}
```

### _update(address,address,uint256)

- **Kind**: internal
- **Source**: 5912:1107:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_update(address,address,uint256)`

```solidity
///  @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
///  (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
///  this function.
///  Emits a {Transfer} event.
function _update(address from, address to, uint256 value) virtual internal {
    if (from == address(0)) {
        _totalSupply += value;
    } else {
        uint256 fromBalance = _balances[from];
        if (fromBalance < value) {
            revert ERC20InsufficientBalance(from, fromBalance, value);
        }
        unchecked {
            _balances[from] = fromBalance - value;
        }
    }
    if (to == address(0)) {
        unchecked {
            _totalSupply -= value;
        }
    } else {
        unchecked {
            _balances[to] += value;
        }
    }
    emit Transfer(from, to, value);
}
```

## State Variable Reads

- **factory** (`contract ISuperAssetFactory`) [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]
- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.burn(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperAsset._onlyManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 2)
      💬 Args: [from, amount]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 3)
        💬 Args: [account, address(0), value]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Burns tokens. Can only be called by accounts with BURNER_ROLE.
 @param from The address whose tokens will be burned
 @param amount The amount of tokens to burn
