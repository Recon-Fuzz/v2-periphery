# Function: previewWithdraw(uint256)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 4372:556:608

## Implementation

```solidity
function previewWithdraw(uint256 assets) override public view returns (uint256) {
    uint256 supply = totalSupply();
    if (supply == 0) {
        return 0;
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
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.previewWithdraw(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Allows an on-chain or off-chain user to simulate the effects of their withdrawal at the current block,
 given current on-chain conditions.
 - MUST return as close to and no fewer than the exact amount of Vault shares that would be burned in a withdraw
   call in the same transaction. I.e. withdraw should return the same or fewer shares as previewWithdraw if
   called
   in the same transaction.
 - MUST NOT account for withdrawal limits like those returned from maxWithdraw and should always act as though
   the withdrawal would be accepted, regardless if the user has enough shares, etc.
 - MUST be inclusive of withdrawal fees. Integrators should be aware of the existence of withdrawal fees.
 - MUST NOT revert.
 NOTE: any unfavorable discrepancy between convertToShares and previewWithdraw SHOULD be considered slippage in
 share price or some other type of condition, meaning the depositor will lose assets by depositing.
