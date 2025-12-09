# Function: previewMint(uint256)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `previewMint(uint256)`
- **Visibility**: public
- **Source Range**: 4243:123:608

## Implementation

```solidity
function previewMint(uint256 shares) override public view returns (uint256) {
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
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.previewMint(uint256) (NodeID: 0)
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

 @dev Allows an on-chain or off-chain user to simulate the effects of their mint at the current block, given
 current on-chain conditions.
 - MUST return as close to and no fewer than the exact amount of assets that would be deposited in a mint call
   in the same transaction. I.e. mint should return the same or fewer assets as previewMint if called in the
   same transaction.
 - MUST NOT account for mint limits like those returned from maxMint and should always act as though the mint
   would be accepted, regardless if the user has enough tokens approved, etc.
 - MUST be inclusive of deposit fees. Integrators should be aware of the existence of deposit fees.
 - MUST NOT revert.
 NOTE: any unfavorable discrepancy between convertToAssets and previewMint SHOULD be considered slippage in
 share price or some other type of condition, meaning the depositor will lose assets by minting.
