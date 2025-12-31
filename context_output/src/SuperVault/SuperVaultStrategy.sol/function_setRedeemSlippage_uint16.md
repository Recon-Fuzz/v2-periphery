# Function: setRedeemSlippage(uint16)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `setRedeemSlippage(uint16)`
- **Visibility**: external
- **Source Range**: 23680:270:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function setRedeemSlippage(uint16 slippageBps) external {
    if (slippageBps > BPS_PRECISION) revert INVALID_REDEEM_SLIPPAGE_BPS();
    superVaultState[msg.sender].redeemSlippageBps = slippageBps;
    emit RedeemSlippageSet(msg.sender, slippageBps);
}
```

## State Variable Reads

- **BPS_PRECISION** (`uint256`)

## State Variable Writes

- **superVaultState** (`mapping(address => struct ISuperVaultStrategy.SuperVaultState)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.setRedeemSlippage(uint16) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Set the slippage tolerance for all future redeem request fulfillments, until reset using this function
 @param slippageBps Slippage tolerance in basis points (e.g., 50 = 0.5%)
