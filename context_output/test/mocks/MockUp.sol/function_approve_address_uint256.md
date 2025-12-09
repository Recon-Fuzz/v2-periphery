# Function: approve(address,uint256)

**Contract**: [test/mocks/MockUp.sol/contract_MockUp.md]

## Metadata

- **Contract**: MockUp
- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3902:186:267
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev See {IERC20-approve}.
///  NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
///  `transferFrom`. This is semantically equivalent to an infinite approval.
///  Requirements:
///  - `spender` cannot be the zero address.
function approve(address spender, uint256 value) virtual public returns (bool) {
    address owner = _msgSender();
    _approve(owner, spender, value);
    return true;
}
```

## Related Implementations

### _msgSender()

- **Kind**: internal
- **Source**: 656:96:277
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 8630:128:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_approve(address,address,uint256)`

```solidity
///  @dev Sets `value` as the allowance of `spender` over the `owner`'s tokens.
///  This internal function is equivalent to `approve`, and can be used to
///  e.g. set automatic allowances for certain subsystems, etc.
///  Emits an {Approval} event.
///  Requirements:
///  - `owner` cannot be the zero address.
///  - `spender` cannot be the zero address.
///  Overrides to this logic should be done to the variant with an additional `bool emitEvent` argument.
function _approve(address owner, address spender, uint256 value) internal {
    _approve(owner, spender, value, true);
}
```

### _approve(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 9605:432:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_approve(address,address,uint256,bool)`

```solidity
///  @dev Variant of {_approve} with an optional flag to enable or disable the {Approval} event.
///  By default (when calling {_approve}) the flag is set to true. On the other hand, approval changes made by
///  `_spendAllowance` during the `transferFrom` operation set the flag to false. This saves gas by not emitting any
///  `Approval` event during `transferFrom` operations.
///  Anyone who wishes to continue emitting `Approval` events on the`transferFrom` operation can force the flag to
///  true using the following override:
///  ```solidity
///  function _approve(address owner, address spender, uint256 value, bool) internal virtual override {
///      super._approve(owner, spender, value, true);
///  }
///  ```
///  Requirements are the same as {_approve}.
function _approve(address owner, address spender, uint256 value, bool emitEvent) virtual internal {
    if (owner == address(0)) {
        revert ERC20InvalidApprover(address(0));
    }
    if (spender == address(0)) {
        revert ERC20InvalidSpender(address(0));
    }
    _allowances[owner][spender] = value;
    if (emitEvent) {
        emit Approval(owner, spender, value);
    }
}
```

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.approve(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Context._msgSender() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._approve(address,address,uint256) (NodeID: 2)
      💬 Args: [owner, spender, value]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._approve(address,address,uint256,bool) (NodeID: 3)
        💬 Args: [owner, spender, value, true]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev See {IERC20-approve}.
 NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
 `transferFrom`. This is semantically equivalent to an infinite approval.
 Requirements:
 - `spender` cannot be the zero address.

### Interface Documentation

 @dev Sets a `value` amount of tokens as the allowance of `spender` over the
 caller's tokens.
 Returns a boolean value indicating whether the operation succeeded.
 IMPORTANT: Beware that changing an allowance with this method brings the risk
 that someone may use both the old and the new allowance by unfortunate
 transaction ordering. One possible solution to mitigate this race
 condition is to first reduce the spender's allowance to 0 and set the
 desired value afterwards:
 https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
 Emits an {Approval} event.
