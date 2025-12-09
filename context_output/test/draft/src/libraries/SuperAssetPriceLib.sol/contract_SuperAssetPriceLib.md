# Contract: SuperAssetPriceLib

## Metadata

- **Name**: SuperAssetPriceLib
- **Type**: Contract
- **Path**: test/draft/src/libraries/SuperAssetPriceLib.sol

## Public/External Functions

### getPriceWithCircuitBreakers(struct ISuperAsset.PriceArgs)

- **Signature**: `getPriceWithCircuitBreakers(struct ISuperAsset.PriceArgs)`
- **Visibility**: external
- **Source Range**: 984:1209:563
- **Details**: [function_getPriceWithCircuitBreakers_struct_ISuperAsset.PriceArgs.md](./function_getPriceWithCircuitBreakers_struct_ISuperAsset.PriceArgs.md)

**Signature:**
```solidity
/// @dev Gets the price of a token with circuit breakers
///  @param args The arguments for the price calculation
///  @return priceUSD The price of the token in USD
///  @return isDepeg Whether the token is depegged
///  @return isDispersion Whether the token has price dispersion
///  @return isOracleOff Whether the oracle is off
function getPriceWithCircuitBreakers(ISuperAsset.PriceArgs memory args) external view returns (uint256 priceUSD, bool isDepeg, bool isDispersion, bool isOracleOff);
```
