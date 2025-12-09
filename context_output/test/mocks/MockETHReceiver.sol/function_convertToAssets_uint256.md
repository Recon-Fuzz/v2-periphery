# Function: convertToAssets(uint256)

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `convertToAssets(uint256)`
- **Visibility**: external
- **Source Range**: 1803:145:590

## Implementation

```solidity
function convertToAssets(uint256 shares) override external pure returns (uint256) {
    return shares;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.convertToAssets(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
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
