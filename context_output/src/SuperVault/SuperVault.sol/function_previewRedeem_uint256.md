# Function: previewRedeem(uint256)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `previewRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 18371:174:510

## Implementation

```solidity
/// @inheritdoc IERC4626
function previewRedeem(uint256) override public pure returns (uint256) {
    revert NOT_IMPLEMENTED();
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.previewRedeem(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IERC4626

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
