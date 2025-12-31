# Contract: MarketParamsLib

## Metadata

- **Name**: MarketParamsLib
- **Type**: Contract
- **Path**: lib/v2-core/src/vendor/morpho/MarketParamsLib.sol
- **Documentation**: @title MarketParamsLib
   @author Morpho Labs
   @custom:contact security@morpho.org
   @notice Library to convert a market to its id.

## State Variables

### MARKET_PARAMS_BYTES_LENGTH

```solidity
/// @notice The length of the data used to compute the id of a market.
///  @dev The length is 5 * 32 because `MarketParams` has 5 variables of 32 bytes each.
uint256 internal constant MARKET_PARAMS_BYTES_LENGTH = 5 * 32
```
