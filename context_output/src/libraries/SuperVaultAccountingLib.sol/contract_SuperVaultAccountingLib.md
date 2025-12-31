# Contract: SuperVaultAccountingLib

## Metadata

- **Name**: SuperVaultAccountingLib
- **Type**: Contract
- **Path**: src/libraries/SuperVaultAccountingLib.sol
- **Documentation**: @title SuperVaultAccountingLib
   @author Superform Labs
   @notice Stateless library for SuperVault accounting calculations
   @dev All functions are pure for easy auditing and testing

## State Variables

### BPS_PRECISION

```solidity
uint256 private constant BPS_PRECISION = 10_000
```

## Errors

### INSUFFICIENT_LIQUIDITY

```solidity
error INSUFFICIENT_LIQUIDITY();
```
