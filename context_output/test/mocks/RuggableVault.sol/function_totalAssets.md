# Function: totalAssets()

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 2524:117:609

## Implementation

```solidity
function totalAssets() override public view returns (uint256) {
    return _asset.balanceOf(address(this));
}
```

## External Calls

- **IERC20::balanceOf(address)**

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableVault.totalAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the total amount of the underlying asset that is “managed” by Vault.
 - SHOULD include any compounding that occurs from yield.
 - MUST be inclusive of any fees that are charged against assets in the Vault.
 - MUST NOT revert.
