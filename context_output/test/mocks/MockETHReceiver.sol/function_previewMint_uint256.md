# Function: previewMint(uint256)

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `previewMint(uint256)`
- **Visibility**: external
- **Source Range**: 2579:141:590

## Implementation

```solidity
function previewMint(uint256 shares) override external pure returns (uint256) {
    return shares;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.previewMint(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
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
