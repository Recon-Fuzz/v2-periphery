# Contract: SharesMathLib

## Metadata

- **Name**: SharesMathLib
- **Type**: Contract
- **Path**: lib/v2-core/src/vendor/morpho/SharesMathLib.sol
- **Documentation**: @title SharesMathLib
   @author Morpho Labs
   @custom:contact security@morpho.org
   @notice Shares management library.
   @dev This implementation mitigates share price manipulations, using OpenZeppelin's method of virtual shares:
   https://docs.openzeppelin.com/contracts/4.x/erc4626#inflation-attack.

## State Variables

### VIRTUAL_SHARES

```solidity
/// @dev The number of virtual shares has been chosen low enough to prevent overflows, and high enough to ensure
///  high precision computations.
///  @dev Virtual shares can never be redeemed for the assets they are entitled to, but it is assumed the share price
///  stays low enough not to inflate these assets to a significant value.
///  @dev Warning: The assets to which virtual borrow shares are entitled behave like unrealizable bad debt.
uint256 internal constant VIRTUAL_SHARES = 1e6
```

### VIRTUAL_ASSETS

```solidity
/// @dev A number of virtual assets of 1 enforces a conversion rate between shares and assets when a market is
///  empty.
uint256 internal constant VIRTUAL_ASSETS = 1
```
