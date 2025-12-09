# Function: previewDeposit(uint256)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `previewDeposit(uint256)`
- **Visibility**: public
- **Source Range**: 1478:116:585

## Implementation

```solidity
function previewDeposit(uint256 assets) override public pure returns (uint256 shares) {
    return assets;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.previewDeposit(uint256) (NodeID: 0)
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
