# Function: maxWithdraw(address)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 3854:132:608

## Implementation

```solidity
function maxWithdraw(address owner) override public view returns (uint256) {
    return convertToAssets(balanceOf(owner));
}
```

## Related Implementations

### convertToAssets(uint256)

- **Kind**: internal
- **Source**: 3061:560:608
- **Link**: `test/mocks/RuggableConvertVault.sol:RuggableConvertVault:convertToAssets(uint256)`

```solidity
function convertToAssets(uint256 shares) override public view returns (uint256) {
    uint256 supply = totalSupply();
    if (supply == 0) {
        return shares;
    }
    uint256 actualAssets = _asset.balanceOf(address(this));
    if (rugEnabled) {
        uint256 inflatedAssets = (actualAssets * (10_000 + rugPercentage)) / 10_000;
        return (shares * inflatedAssets) / supply;
    } else {
        return (shares * actualAssets) / supply;
    }
}
```

### balanceOf(address)

- **Kind**: internal
- **Source**: 2933:116:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:balanceOf(address)`

```solidity
/// @inheritdoc IERC20
function balanceOf(address account) virtual public view returns (uint256) {
    return _balances[account];
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

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **rugEnabled** (`bool`)
- **rugPercentage** (`uint256`)
- **_balances** (`mapping(address => uint256)`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.maxWithdraw(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: RuggableConvertVault.convertToAssets(uint256) (NodeID: 1)
      💬 Args: [balanceOf(owner)]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ERC20.balanceOf(address) (NodeID: 3)
    │   💬 Args: [owner]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the maximum amount of the underlying asset that can be withdrawn from the owner balance in the
 Vault, through a withdraw call.
 - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
 - MUST NOT revert.
