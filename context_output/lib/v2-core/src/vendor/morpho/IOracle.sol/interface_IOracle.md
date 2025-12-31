# Interface: IOracle

## Metadata

- **Name**: IOracle
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/morpho/IOracle.sol
- **Documentation**: @title IOracle
   @author Morpho Labs
   @custom:contact security@morpho.org
   @notice Interface that oracles used by Morpho must implement.
   @dev It is the user's responsibility to select markets with safe oracles.

## Public/External Functions

### price()

- **Signature**: `price()`
- **Visibility**: external
- **Source Range**: 695:49:456

**Signature:**
```solidity
/// @notice Returns the price of 1 asset of collateral token quoted in 1 asset of loan token, scaled by 1e36.
///  @dev It corresponds to the price of 10**(collateral token decimals) assets of collateral token quoted in
///  10**(loan token decimals) assets of loan token with `36 + loan token decimals - collateral token decimals`
///  decimals of precision.
function price() external view returns (uint256);;
```
