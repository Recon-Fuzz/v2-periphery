# Function: deposit(uint256,address)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `deposit(uint256,address)`
- **Visibility**: public
- **Source Range**: 5065:439:608

## Implementation

```solidity
function deposit(uint256 assets, address receiver) override public returns (uint256) {
    rugEnabled = false;
    uint256 shares = previewDeposit(assets);
    rugEnabled = true;
    _asset.safeTransferFrom(msg.sender, address(this), assets);
    _mint(receiver, shares);
    emit RugPull("deposit", receiver, shares, shares);
    return shares;
}
```

## Related Implementations

### previewDeposit(uint256)

- **Kind**: internal
- **Source**: 4111:126:608
- **Link**: `test/mocks/RuggableConvertVault.sol:RuggableConvertVault:previewDeposit(uint256)`

```solidity
function previewDeposit(uint256 assets) override public view returns (uint256) {
    return convertToShares(assets);
}
```

### convertToShares(uint256)

- **Kind**: internal
- **Source**: 2494:561:608
- **Link**: `test/mocks/RuggableConvertVault.sol:RuggableConvertVault:convertToShares(uint256)`

```solidity
function convertToShares(uint256 assets) override public view returns (uint256) {
    uint256 supply = totalSupply();
    if (supply == 0) {
        return assets;
    }
    uint256 actualAssets = _asset.balanceOf(address(this));
    if (rugEnabled) {
        uint256 inflatedAssets = (actualAssets * (10_000 + rugPercentage)) / 10_000;
        return (assets * supply) / inflatedAssets;
    } else {
        return (assets * supply) / actualAssets;
    }
}
```

### totalSupply()

- **Kind**: internal
- **Source**: 2803:97:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:totalSupply()`

```solidity
/// @inheritdoc IERC20
function totalSupply() virtual public view returns (uint256) {
    return _totalSupply;
}
```

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 7362:208:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_mint(address,uint256)`

```solidity
///  @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
///  Relies on the `_update` mechanism
///  Emits a {Transfer} event with `from` set to the zero address.
///  NOTE: This function is not virtual, {_update} should be overridden instead.
function _mint(address account, uint256 value) internal {
    if (account == address(0)) {
        revert ERC20InvalidReceiver(address(0));
    }
    _update(address(0), account, value);
}
```

### _update(address,address,uint256)

- **Kind**: internal
- **Source**: 5912:1107:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_update(address,address,uint256)`

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

## External Calls

- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **rugEnabled** (`bool`)
- **rugPercentage** (`uint256`)
- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **rugEnabled** (`bool`)
- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.deposit(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: RuggableConvertVault.previewDeposit(uint256) (NodeID: 1)
  │   💬 Args: [assets]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: RuggableConvertVault.convertToShares(uint256) (NodeID: 2)
  │     💬 Args: [assets]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 4)
      💬 Args: [receiver, shares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 5)
        💬 Args: [address(0), account, value]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Mints shares Vault shares to receiver by depositing exactly amount of underlying tokens.
 - MUST emit the Deposit event.
 - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
   deposit execution, and are accounted for during deposit.
 - MUST revert if all of assets cannot be deposited (due to deposit limit being reached, slippage, the user not
   approving enough underlying tokens to the Vault contract, etc).
 NOTE: most implementations will require pre-approval of the Vault with the Vault’s underlying asset token.
