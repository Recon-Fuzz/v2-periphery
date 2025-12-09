# Function: totalAssets()

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 2140:348:608

## Implementation

```solidity
function totalAssets() override public view returns (uint256) {
    uint256 actualAssets = _asset.balanceOf(address(this));
    if (rugEnabled) {
        return (actualAssets * (10_000 + rugPercentage)) / 10_000;
    } else {
        return actualAssets;
    }
}
```

## External Calls

- **IERC20::balanceOf(address)**

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **rugEnabled** (`bool`)
- **rugPercentage** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.totalAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the total amount of the underlying asset that is “managed” by Vault.
 - SHOULD include any compounding that occurs from yield.
 - MUST be inclusive of any fees that are charged against assets in the Vault.
 - MUST NOT revert.
