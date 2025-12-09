# Function: convertToAssets(uint256)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `convertToAssets(uint256)`
- **Visibility**: public
- **Source Range**: 1966:504:585

## Implementation

```solidity
function convertToAssets(uint256 shares) override public view returns (uint256 assets) {
    if (((yield > 0) && (msg.sender != address(0))) && (depositTimestamps[msg.sender] > 0)) {
        uint256 timeElapsed = block.timestamp - depositTimestamps[msg.sender];
        uint256 yieldFactor = (yield * timeElapsed) / (365 days);
        return shares + ((shares * yieldFactor) / yield_precision);
    }
    return shares;
}
```

## State Variable Reads

- **yield** (`uint256`)
- **depositTimestamps** (`mapping(address => uint256)`)
- **yield_precision** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.convertToAssets(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the amount of assets that the Vault would exchange for the amount of shares provided, in an ideal
 scenario where all the conditions are met.
 - MUST NOT be inclusive of any fees that are charged against assets in the Vault.
 - MUST NOT show any variations depending on the caller.
 - MUST NOT reflect slippage or other on-chain conditions, when performing the actual exchange.
 - MUST NOT revert.
 NOTE: This calculation MAY NOT reflect the “per-user” price-per-share, and instead should reflect the
 “average-user’s” price-per-share, meaning what the average user should expect to see when exchanging to and
 from.
