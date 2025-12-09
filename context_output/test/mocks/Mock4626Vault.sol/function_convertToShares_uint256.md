# Function: convertToShares(uint256)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `convertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 2476:117:585

## Implementation

```solidity
function convertToShares(uint256 assets) override public pure returns (uint256 shares) {
    return assets;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.convertToShares(uint256) (NodeID: 0)
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
