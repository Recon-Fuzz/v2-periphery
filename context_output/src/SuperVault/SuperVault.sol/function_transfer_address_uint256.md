# Function: transfer(address,uint256)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 4401:178:34
- **Inherited From**: ERC20Upgradeable

## Implementation

```solidity
///  @dev See {IERC20-transfer}.
///  Requirements:
///  - `to` cannot be the zero address.
///  - the caller must have a balance of at least `value`.
function transfer(address to, uint256 value) virtual public returns (bool) {
    address owner = _msgSender();
    _transfer(owner, to, value);
    return true;
}
```

## Related Implementations

### _msgSender()

- **Kind**: internal
- **Source**: 887:96:35
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol:ContextUpgradeable:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### _transfer(address,address,uint256)

- **Kind**: internal
- **Source**: 6509:300:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_transfer(address,address,uint256)`

```solidity
///  @dev Moves a `value` amount of tokens from `from` to `to`.
///  This internal function is equivalent to {transfer}, and can be used to
///  e.g. implement automatic token fees, slashing mechanisms, etc.
///  Emits a {Transfer} event.
///  NOTE: This function is not virtual, {_update} should be overridden instead.
function _transfer(address from, address to, uint256 value) internal {
    if (from == address(0)) {
        revert ERC20InvalidSender(address(0));
    }
    if (to == address(0)) {
        revert ERC20InvalidReceiver(address(0));
    }
    _update(from, to, value);
}
```

### _update(address,address,uint256)

- **Kind**: internal
- **Source**: 7124:1170:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_update(address,address,uint256)`

```solidity
///  @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
///  (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
///  this function.
///  Emits a {Transfer} event.
function _update(address from, address to, uint256 value) virtual internal {
    ERC20Storage storage $ = _getERC20Storage();
    if (from == address(0)) {
        $._totalSupply += value;
    } else {
        uint256 fromBalance = $._balances[from];
        if (fromBalance < value) {
            revert ERC20InsufficientBalance(from, fromBalance, value);
        }
        unchecked {
            $._balances[from] = fromBalance - value;
        }
    }
    if (to == address(0)) {
        unchecked {
            $._totalSupply -= value;
        }
    } else {
        unchecked {
            $._balances[to] += value;
        }
    }
    emit Transfer(from, to, value);
}
```

### _getERC20Storage()

- **Kind**: internal
- **Source**: 1947:153:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_getERC20Storage()`

```solidity
function _getERC20Storage() private pure returns (ERC20Storage storage $) {
    assembly {
        $.slot := ERC20StorageLocation
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Upgradeable.transfer(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ContextUpgradeable._msgSender() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20Upgradeable._transfer(address,address,uint256) (NodeID: 2)
      💬 Args: [owner, to, value]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20Upgradeable._update(address,address,uint256) (NodeID: 3)
        💬 Args: [from, to, value]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ERC20Upgradeable._getERC20Storage() (NodeID: 4)
          💬 Args: [no args]
          👁️  Def: private
```

## Documentation

### Function Documentation

 @dev See {IERC20-transfer}.
 Requirements:
 - `to` cannot be the zero address.
 - the caller must have a balance of at least `value`.

### Interface Documentation

 @dev Moves a `value` amount of tokens from the caller's account to `to`.
 Returns a boolean value indicating whether the operation succeeded.
 Emits a {Transfer} event.
