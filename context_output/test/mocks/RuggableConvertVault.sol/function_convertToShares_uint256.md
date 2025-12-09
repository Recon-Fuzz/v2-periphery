# Function: convertToShares(uint256)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `convertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 2494:561:608

## Implementation

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

## Related Implementations

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

## External Calls

- **IERC20::balanceOf(address)**

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **rugEnabled** (`bool`)
- **rugPercentage** (`uint256`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.convertToShares(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the amount of shares that the Vault would exchange for the amount of assets provided, in an ideal
 scenario where all the conditions are met.
 - MUST NOT be inclusive of any fees that are charged against assets in the Vault.
 - MUST NOT show any variations depending on the caller.
 - MUST NOT reflect slippage or other on-chain conditions, when performing the actual exchange.
 - MUST NOT revert.
 NOTE: This calculation MAY NOT reflect the “per-user” price-per-share, and instead should reflect the
 “average-user’s” price-per-share, meaning what the average user should expect to see when exchanging to and
 from.
