# Function: previewRedeem(uint256)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `previewRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 1845:115:585

## Implementation

```solidity
function previewRedeem(uint256 shares) override public pure returns (uint256 assets) {
    return shares;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.previewRedeem(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Allows an on-chain or off-chain user to simulate the effects of their redemption at the current block,
 given current on-chain conditions.
 - MUST return as close to and no more than the exact amount of assets that would be withdrawn in a redeem call
   in the same transaction. I.e. redeem should return the same or more assets as previewRedeem if called in the
   same transaction.
 - MUST NOT account for redemption limits like those returned from maxRedeem and should always act as though the
   redemption would be accepted, regardless if the user has enough shares, etc.
 - MUST be inclusive of withdrawal fees. Integrators should be aware of the existence of withdrawal fees.
 - MUST NOT revert.
 NOTE: any unfavorable discrepancy between convertToAssets and previewRedeem SHOULD be considered slippage in
 share price or some other type of condition, meaning the depositor will lose assets by redeeming.
