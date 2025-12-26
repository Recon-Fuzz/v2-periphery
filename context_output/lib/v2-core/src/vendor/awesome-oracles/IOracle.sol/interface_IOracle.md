# Interface: IOracle

## Metadata

- **Name**: IOracle
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/awesome-oracles/IOracle.sol
- **Documentation**: @title Common interface for price oracles.
   @dev Implements the spec at https://eips.ethereum.org/EIPS/eip-7726

## Errors

### OracleUnsupportedPair

```solidity
/// @notice The oracle does not support the given base/quote pair.
///  @param base The asset that the user needs to know the value or price for.
///  @param quote The asset in which the user needs to value or price the base.
error OracleUnsupportedPair(address base, address quote);
```

### OracleUntrustedData

```solidity
/// @notice The oracle is not capable to provide data within a degree of confidence.
///  @param base The asset that the user needs to know the value or price for.
///  @param quote The asset in which the user needs to value or price the base.
error OracleUntrustedData(address base, address quote);
```

## Public/External Functions

### getQuote(uint256,address,address)

- **Signature**: `getQuote(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 1494:111:444

**Signature:**
```solidity
/// @notice Returns the value of `baseAmount` of `base` in `quote` terms.
///  @dev MUST round down towards 0.
///  MUST revert with `OracleUnsupportedPair` if not capable to provide data for the specified `base` and `quote`
///  pair.
///  MUST revert with `OracleUntrustedData` if not capable to provide data within a degree of confidence publicly
///  specified.
///  @param baseAmount The amount of `base` to convert.
///  @param base The asset that the user needs to know the value for.
///  @param quote The asset in which the user needs to value the base.
///  @return quoteAmount The value of `baseAmount` of `base` in `quote` terms
function getQuote(uint256 baseAmount, address base, address quote) external view returns (uint256 quoteAmount);;
```
