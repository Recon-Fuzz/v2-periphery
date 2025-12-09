# Function: previewDeposit(uint256)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `previewDeposit(uint256)`
- **Visibility**: public
- **Source Range**: 4111:126:608

## Implementation

```solidity
function previewDeposit(uint256 assets) override public view returns (uint256) {
    return convertToShares(assets);
}
```

## Related Implementations

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

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **rugEnabled** (`bool`)
- **rugPercentage** (`uint256`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.previewDeposit(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: RuggableConvertVault.convertToShares(uint256) (NodeID: 1)
      💬 Args: [assets]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Allows an on-chain or off-chain user to simulate the effects of their deposit at the current block, given
 current on-chain conditions.
 - MUST return as close to and no more than the exact amount of Vault shares that would be minted in a deposit
   call in the same transaction. I.e. deposit should return the same or more shares as previewDeposit if called
   in the same transaction.
 - MUST NOT account for deposit limits like those returned from maxDeposit and should always act as though the
   deposit would be accepted, regardless if the user has enough tokens approved, etc.
 - MUST be inclusive of deposit fees. Integrators should be aware of the existence of deposit fees.
 - MUST NOT revert.
 NOTE: any unfavorable discrepancy between convertToShares and previewDeposit SHOULD be considered slippage in
 share price or some other type of condition, meaning the depositor will lose assets by depositing.
