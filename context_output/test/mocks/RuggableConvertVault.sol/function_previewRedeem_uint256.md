# Function: previewRedeem(uint256)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `previewRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 4934:125:608

## Implementation

```solidity
function previewRedeem(uint256 shares) override public view returns (uint256) {
    return convertToAssets(shares);
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
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.previewRedeem(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: RuggableConvertVault.convertToAssets(uint256) (NodeID: 1)
      💬 Args: [shares]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Allows an on-chain or off-chain user to simulate the effects of their redemption at the current block,
 given current on-chain conditions.
 - MUST return as close to and no more than the exact amount of assets that would be withdrawn in a redeem call
   in the same transaction. I.e. redeem should return the same or more assets as previewRedeem if called in the
   same transaction.
 - MUST NOT account for redemption limits like those returned from maxRedeem and should always act as though the
   redemption would be accepted, regardless if the user has enough shares, etc.
 - MUST be inclusive of withdrawal fees. Integrators should be aware of the existence of withdrawal fees.
 - MUST NOT revert.
 NOTE: any unfavorable discrepancy between convertToAssets and previewRedeem SHOULD be considered slippage in
 share price or some other type of condition, meaning the depositor will lose assets by redeeming.
