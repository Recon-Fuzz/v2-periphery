# Function: getPriceWithCircuitBreakers(struct ISuperAsset.PriceArgs)

**Contract**: [test/draft/src/libraries/SuperAssetPriceLib.sol/contract_SuperAssetPriceLib.md]

## Metadata

- **Contract**: SuperAssetPriceLib
- **Signature**: `getPriceWithCircuitBreakers(struct ISuperAsset.PriceArgs)`
- **Visibility**: external
- **Source Range**: 984:1209:563

## Implementation

```solidity
/// @dev Gets the price of a token with circuit breakers
///  @param args The arguments for the price calculation
///  @return priceUSD The price of the token in USD
///  @return isDepeg Whether the token is depegged
///  @return isDispersion Whether the token has price dispersion
///  @return isOracleOff Whether the oracle is off
function getPriceWithCircuitBreakers(ISuperAsset.PriceArgs memory args) external view returns (uint256 priceUSD, bool isDepeg, bool isDispersion, bool isOracleOff) {
    uint256 stddev;
    uint256 M;
    ISuperOracle superOracle = ISuperOracle(args.superOracle);
    ISuperAsset superAsset = ISuperAsset(args.superAsset);
    uint256 precision = superAsset.getPrecision();
    (priceUSD, stddev, M) = _getPriceInfo(superOracle, superAsset, args.usd, args.token);
    if (M == 0) {
        isOracleOff = true;
    } else {
        address primaryAsset = superAsset.getPrimaryAsset();
        if (primaryAsset == args.usd) {
            return (precision, false, false, false);
        }
        (isDepeg, isDispersion) = _getDepegAndDispersion(args, precision, priceUSD, stddev);
    }
    return (priceUSD, isDepeg, isDispersion, isOracleOff);
}
```

## External Calls

- **ISuperAsset::getPrecision()**
- **ISuperAsset::getPrimaryAsset()**

## Call Tree

```
No call tree available
```

## Documentation

### Function Documentation

@dev Gets the price of a token with circuit breakers
 @param args The arguments for the price calculation
 @return priceUSD The price of the token in USD
 @return isDepeg Whether the token is depegged
 @return isDispersion Whether the token has price dispersion
 @return isOracleOff Whether the oracle is off
