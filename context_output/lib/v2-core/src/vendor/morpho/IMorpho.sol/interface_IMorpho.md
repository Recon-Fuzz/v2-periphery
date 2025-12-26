# Interface: IMorpho

## Metadata

- **Name**: IMorpho
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/morpho/IMorpho.sol
- **Documentation**: @title IMorpho
   @author Morpho Labs
   @custom:contact security@morpho.org
   @dev Use this interface for Morpho to have access to all the functions with the appropriate function signatures.

## Implements Interfaces

- **IMorphoBase** [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorphoBase.md]

## Public/External Functions

### position(Id,address)

- **Signature**: `position(Id,address)`
- **Visibility**: external
- **Source Range**: 18815:81:455

**Signature:**
```solidity
/// @notice The state of the position of `user` on the market corresponding to `id`.
///  @dev Warning: For `feeRecipient`, `p.supplyShares` does not contain the accrued shares since the last interest
///  accrual.
function position(Id id, address user) external view returns (Position memory p);;
```

### market(Id)

- **Signature**: `market(Id)`
- **Visibility**: external
- **Source Range**: 19334:63:455

**Signature:**
```solidity
/// @notice The state of the market corresponding to `id`.
///  @dev Warning: `m.totalSupplyAssets` does not contain the accrued interest since the last interest accrual.
///  @dev Warning: `m.totalBorrowAssets` does not contain the accrued interest since the last interest accrual.
///  @dev Warning: `m.totalSupplyShares` does not contain the accrued shares by `feeRecipient` since the last
///  interest accrual.
function market(Id id) external view returns (Market memory m);;
```

### idToMarketParams(Id)

- **Signature**: `idToMarketParams(Id)`
- **Visibility**: external
- **Source Range**: 19689:77:455

**Signature:**
```solidity
/// @notice The market params corresponding to `id`.
///  @dev This mapping is not used in Morpho. It is there to enable reducing the cost associated to calldata on layer
///  2s by creating a wrapper contract with functions that take `id` as input instead of `marketParams`.
function idToMarketParams(Id id) external view returns (MarketParams memory);;
```

### DOMAIN_SEPARATOR() (inherited from IMorphoBase)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 1615:60:455

**Signature:**
```solidity
/// @notice The EIP-712 domain separator.
///  @dev Warning: Every EIP-712 signed message based on this domain separator can be reused on chains sharing the
///  same chain id and on forks because the domain separator would be the same.
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```

### owner() (inherited from IMorphoBase)

- **Signature**: `owner()`
- **Visibility**: external
- **Source Range**: 1927:49:455

**Signature:**
```solidity
/// @notice The owner of the contract.
///  @dev It has the power to change the owner.
///  @dev It has the power to set fees on markets and set the fee recipient.
///  @dev It has the power to enable but not disable IRMs and LLTVs.
function owner() external view returns (address);;
```

### feeRecipient() (inherited from IMorphoBase)

- **Signature**: `feeRecipient()`
- **Visibility**: external
- **Source Range**: 2137:56:455

**Signature:**
```solidity
/// @notice The fee recipient of all markets.
///  @dev The recipient receives the fees of a given market through a supply position on that market.
function feeRecipient() external view returns (address);;
```

### isIrmEnabled(address) (inherited from IMorphoBase)

- **Signature**: `isIrmEnabled(address)`
- **Visibility**: external
- **Source Range**: 2245:64:455

**Signature:**
```solidity
/// @notice Whether the `irm` is enabled.
function isIrmEnabled(address irm) external view returns (bool);;
```

### isLltvEnabled(uint256) (inherited from IMorphoBase)

- **Signature**: `isLltvEnabled(uint256)`
- **Visibility**: external
- **Source Range**: 2362:66:455

**Signature:**
```solidity
/// @notice Whether the `lltv` is enabled.
function isLltvEnabled(uint256 lltv) external view returns (bool);;
```

### isAuthorized(address,address) (inherited from IMorphoBase)

- **Signature**: `isAuthorized(address,address)`
- **Visibility**: external
- **Source Range**: 2629:91:455

**Signature:**
```solidity
/// @notice Whether `authorized` is authorized to modify `authorizer`'s position on all markets.
///  @dev Anyone is authorized to modify their own positions, regardless of this variable.
function isAuthorized(address authorizer, address authorized) external view returns (bool);;
```

### nonce(address) (inherited from IMorphoBase)

- **Signature**: `nonce(address)`
- **Visibility**: external
- **Source Range**: 2832:67:455

**Signature:**
```solidity
/// @notice The `authorizer`'s current nonce. Used to prevent replay attacks with EIP-712 signatures.
function nonce(address authorizer) external view returns (uint256);;
```

### setOwner(address) (inherited from IMorphoBase)

- **Signature**: `setOwner(address)`
- **Visibility**: external
- **Source Range**: 3083:45:455

**Signature:**
```solidity
/// @notice Sets `newOwner` as `owner` of the contract.
///  @dev Warning: No two-step transfer ownership.
///  @dev Warning: The owner can be set to the zero address.
function setOwner(address newOwner) external;;
```

### enableIrm(address) (inherited from IMorphoBase)

- **Signature**: `enableIrm(address)`
- **Visibility**: external
- **Source Range**: 3263:41:455

**Signature:**
```solidity
/// @notice Enables `irm` as a possible IRM for market creation.
///  @dev Warning: It is not possible to disable an IRM.
function enableIrm(address irm) external;;
```

### enableLltv(uint256) (inherited from IMorphoBase)

- **Signature**: `enableLltv(uint256)`
- **Visibility**: external
- **Source Range**: 3441:43:455

**Signature:**
```solidity
/// @notice Enables `lltv` as a possible LLTV for market creation.
///  @dev Warning: It is not possible to disable a LLTV.
function enableLltv(uint256 lltv) external;;
```

### setFee(struct MarketParams,uint256) (inherited from IMorphoBase)

- **Signature**: `setFee(struct MarketParams,uint256)`
- **Visibility**: external
- **Source Range**: 3672:75:455

**Signature:**
```solidity
/// @notice Sets the `newFee` for the given market `marketParams`.
///  @param newFee The new fee, scaled by WAD.
///  @dev Warning: The recipient can be the zero address.
function setFee(MarketParams memory marketParams, uint256 newFee) external;;
```

### setFeeRecipient(address) (inherited from IMorphoBase)

- **Signature**: `setFeeRecipient(address)`
- **Visibility**: external
- **Source Range**: 4169:59:455

**Signature:**
```solidity
/// @notice Sets `newFeeRecipient` as `feeRecipient` of the fee.
///  @dev Warning: If the fee recipient is set to the zero address, fees will accrue there and will be lost.
///  @dev Modifying the fee recipient will allow the new recipient to claim any pending fees not yet accrued. To
///  ensure that the current recipient receives all due fees, accrue interest manually prior to making any changes.
function setFeeRecipient(address newFeeRecipient) external;;
```

### createMarket(struct MarketParams) (inherited from IMorphoBase)

- **Signature**: `createMarket(struct MarketParams)`
- **Visibility**: external
- **Source Range**: 6199:65:455

**Signature:**
```solidity
/// @notice Creates the market `marketParams`.
///  @dev Here is the list of assumptions on the market's dependencies (tokens, IRM and oracle) that guarantees
///  Morpho behaves as expected:
///  - The token should be ERC-20 compliant, except that it can omit return values on `transfer` and `transferFrom`.
///  - The token balance of Morpho should only decrease on `transfer` and `transferFrom`. In particular, tokens with
///  burn functions are not supported.
///  - The token should not re-enter Morpho on `transfer` nor `transferFrom`.
///  - The token balance of the sender (resp. receiver) should decrease (resp. increase) by exactly the given amount
///  on `transfer` and `transferFrom`. In particular, tokens with fees on transfer are not supported.
///  - The IRM should not re-enter Morpho.
///  - The oracle should return a price with the correct scaling.
///  @dev Here is a list of assumptions on the market's dependencies which, if broken, could break Morpho's liveness
///  properties (funds could get stuck):
///  - The token should not revert on `transfer` and `transferFrom` if balances and approvals are right.
///  - The amount of assets supplied and borrowed should not go above ~1e35 (otherwise the computation of
///  `toSharesUp` and `toSharesDown` can overflow).
///  - The IRM should not revert on `borrowRate`.
///  - The IRM should not return a very high borrow rate (otherwise the computation of `interest` in
///  `_accrueInterest` can overflow).
///  - The oracle should not revert `price`.
///  - The oracle should not return a very high price (otherwise the computation of `maxBorrow` in `_isHealthy` or of
///  `assetsRepaid` in `liquidate` can overflow).
///  @dev The borrow share price of a market with less than 1e4 assets borrowed can be decreased by manipulations, to
///  the point where `totalBorrowShares` is very large and borrowing overflows.
function createMarket(MarketParams memory marketParams) external;;
```

### supply(struct MarketParams,uint256,uint256,address,bytes) (inherited from IMorphoBase)

- **Signature**: `supply(struct MarketParams,uint256,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 7456:247:455

**Signature:**
```solidity
/// @notice Supplies `assets` or `shares` on behalf of `onBehalf`, optionally calling back the caller's
///  `onMorphoSupply` function with the given `data`.
///  @dev Either `assets` or `shares` should be zero. Most use cases should rely on `assets` as an input so the
///  caller is guaranteed to have `assets` tokens pulled from their balance, but the possibility to mint a specific
///  amount of shares is given for full compatibility and precision.
///  @dev Supplying a large amount can revert for overflow.
///  @dev Supplying an amount of shares may lead to supply more or fewer assets than expected due to slippage.
///  Consider using the `assets` parameter to avoid this.
///  @param marketParams The market to supply assets to.
///  @param assets The amount of assets to supply.
///  @param shares The amount of shares to mint.
///  @param onBehalf The address that will own the increased supply position.
///  @param data Arbitrary data to pass to the `onMorphoSupply` callback. Pass empty data if not needed.
///  @return assetsSupplied The amount of assets supplied.
///  @return sharesSupplied The amount of shares minted.
function supply(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes memory data) external returns (uint256 assetsSupplied, uint256 sharesSupplied);;
```

### withdraw(struct MarketParams,uint256,uint256,address,address) (inherited from IMorphoBase)

- **Signature**: `withdraw(struct MarketParams,uint256,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 8731:250:455

**Signature:**
```solidity
/// @notice Withdraws `assets` or `shares` on behalf of `onBehalf` and sends the assets to `receiver`.
///  @dev Either `assets` or `shares` should be zero. To withdraw max, pass the `shares`'s balance of `onBehalf`.
///  @dev `msg.sender` must be authorized to manage `onBehalf`'s positions.
///  @dev Withdrawing an amount corresponding to more shares than supplied will revert for underflow.
///  @dev It is advised to use the `shares` input when withdrawing the full position to avoid reverts due to
///  conversion roundings between shares and assets.
///  @param marketParams The market to withdraw assets from.
///  @param assets The amount of assets to withdraw.
///  @param shares The amount of shares to burn.
///  @param onBehalf The address of the owner of the supply position.
///  @param receiver The address that will receive the withdrawn assets.
///  @return assetsWithdrawn The amount of assets withdrawn.
///  @return sharesWithdrawn The amount of shares burned.
function withdraw(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) external returns (uint256 assetsWithdrawn, uint256 sharesWithdrawn);;
```

### borrow(struct MarketParams,uint256,uint256,address,address) (inherited from IMorphoBase)

- **Signature**: `borrow(struct MarketParams,uint256,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 10132:246:455

**Signature:**
```solidity
/// @notice Borrows `assets` or `shares` on behalf of `onBehalf` and sends the assets to `receiver`.
///  @dev Either `assets` or `shares` should be zero. Most use cases should rely on `assets` as an input so the
///  caller is guaranteed to borrow `assets` of tokens, but the possibility to mint a specific amount of shares is
///  given for full compatibility and precision.
///  @dev `msg.sender` must be authorized to manage `onBehalf`'s positions.
///  @dev Borrowing a large amount can revert for overflow.
///  @dev Borrowing an amount of shares may lead to borrow fewer assets than expected due to slippage.
///  Consider using the `assets` parameter to avoid this.
///  @param marketParams The market to borrow assets from.
///  @param assets The amount of assets to borrow.
///  @param shares The amount of shares to mint.
///  @param onBehalf The address that will own the increased borrow position.
///  @param receiver The address that will receive the borrowed assets.
///  @return assetsBorrowed The amount of assets borrowed.
///  @return sharesBorrowed The amount of shares minted.
function borrow(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) external returns (uint256 assetsBorrowed, uint256 sharesBorrowed);;
```

### repay(struct MarketParams,uint256,uint256,address,bytes) (inherited from IMorphoBase)

- **Signature**: `repay(struct MarketParams,uint256,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 11496:242:455

**Signature:**
```solidity
/// @notice Repays `assets` or `shares` on behalf of `onBehalf`, optionally calling back the caller's
///  `onMorphoRepay` function with the given `data`.
///  @dev Either `assets` or `shares` should be zero. To repay max, pass the `shares`'s balance of `onBehalf`.
///  @dev Repaying an amount corresponding to more shares than borrowed will revert for underflow.
///  @dev It is advised to use the `shares` input when repaying the full position to avoid reverts due to conversion
///  roundings between shares and assets.
///  @dev An attacker can front-run a repay with a small repay making the transaction revert for underflow.
///  @param marketParams The market to repay assets to.
///  @param assets The amount of assets to repay.
///  @param shares The amount of shares to burn.
///  @param onBehalf The address of the owner of the debt position.
///  @param data Arbitrary data to pass to the `onMorphoRepay` callback. Pass empty data if not needed.
///  @return assetsRepaid The amount of assets repaid.
///  @return sharesRepaid The amount of shares burned.
function repay(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes memory data) external returns (uint256 assetsRepaid, uint256 sharesRepaid);;
```

### supplyCollateral(struct MarketParams,uint256,address,bytes) (inherited from IMorphoBase)

- **Signature**: `supplyCollateral(struct MarketParams,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 12389:168:455

**Signature:**
```solidity
/// @notice Supplies `assets` of collateral on behalf of `onBehalf`, optionally calling back the caller's
///  `onMorphoSupplyCollateral` function with the given `data`.
///  @dev Interest are not accrued since it's not required and it saves gas.
///  @dev Supplying a large amount can revert for overflow.
///  @param marketParams The market to supply collateral to.
///  @param assets The amount of collateral to supply.
///  @param onBehalf The address that will own the increased collateral position.
///  @param data Arbitrary data to pass to the `onMorphoSupplyCollateral` callback. Pass empty data if not needed.
function supplyCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, bytes memory data) external;;
```

### withdrawCollateral(struct MarketParams,uint256,address,address) (inherited from IMorphoBase)

- **Signature**: `withdrawCollateral(struct MarketParams,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 13142:169:455

**Signature:**
```solidity
/// @notice Withdraws `assets` of collateral on behalf of `onBehalf` and sends the assets to `receiver`.
///  @dev `msg.sender` must be authorized to manage `onBehalf`'s positions.
///  @dev Withdrawing an amount corresponding to more collateral than supplied will revert for underflow.
///  @param marketParams The market to withdraw collateral from.
///  @param assets The amount of collateral to withdraw.
///  @param onBehalf The address of the owner of the collateral position.
///  @param receiver The address that will receive the collateral assets.
function withdrawCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, address receiver) external;;
```

### liquidate(struct MarketParams,address,uint256,uint256,bytes) (inherited from IMorphoBase)

- **Signature**: `liquidate(struct MarketParams,address,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 14434:232:455

**Signature:**
```solidity
/// @notice Liquidates the given `repaidShares` of debt asset or seize the given `seizedAssets` of collateral on the
///  given market `marketParams` of the given `borrower`'s position, optionally calling back the caller's
///  `onMorphoLiquidate` function with the given `data`.
///  @dev Either `seizedAssets` or `repaidShares` should be zero.
///  @dev Seizing more than the collateral balance will underflow and revert without any error message.
///  @dev Repaying more than the borrow balance will underflow and revert without any error message.
///  @dev An attacker can front-run a liquidation with a small repay making the transaction revert for underflow.
///  @param marketParams The market of the position.
///  @param borrower The owner of the position.
///  @param seizedAssets The amount of collateral to seize.
///  @param repaidShares The amount of shares to repay.
///  @param data Arbitrary data to pass to the `onMorphoLiquidate` callback. Pass empty data if not needed.
///  @return The amount of assets seized.
///  @return The amount of assets repaid.
function liquidate(MarketParams memory marketParams, address borrower, uint256 seizedAssets, uint256 repaidShares, bytes memory data) external returns (uint256, uint256);;
```

### flashLoan(address,uint256,bytes) (inherited from IMorphoBase)

- **Signature**: `flashLoan(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 15287:80:455

**Signature:**
```solidity
/// @notice Executes a flash loan.
///  @dev Flash loans have access to the whole balance of the contract (the liquidity and deposited collateral of all
///  markets combined, plus donations).
///  @dev Warning: Not ERC-3156 compliant but compatibility is easily reached:
///  - `flashFee` is zero.
///  - `maxFlashLoan` is the token's balance of this contract.
///  - The receiver of `assets` is the caller.
///  @param token The token to flash loan.
///  @param assets The amount of assets to flash loan.
///  @param data Arbitrary data to pass to the `onMorphoFlashLoan` callback.
function flashLoan(address token, uint256 assets, bytes calldata data) external;;
```

### setAuthorization(address,bool) (inherited from IMorphoBase)

- **Signature**: `setAuthorization(address,bool)`
- **Visibility**: external
- **Source Range**: 15576:77:455

**Signature:**
```solidity
/// @notice Sets the authorization for `authorized` to manage `msg.sender`'s positions.
///  @param authorized The authorized address.
///  @param newIsAuthorized The new authorization status.
function setAuthorization(address authorized, bool newIsAuthorized) external;;
```

### setAuthorizationWithSig(struct Authorization,struct Signature) (inherited from IMorphoBase)

- **Signature**: `setAuthorizationWithSig(struct Authorization,struct Signature)`
- **Visibility**: external
- **Source Range**: 16133:110:455

**Signature:**
```solidity
/// @notice Sets the authorization for `authorization.authorized` to manage `authorization.authorizer`'s positions.
///  @dev Warning: Reverts if the signature has already been submitted.
///  @dev The signature is malleable, but it has no impact on the security here.
///  @dev The nonce is passed as argument to be able to revert with a different error message.
///  @param authorization The `Authorization` struct.
///  @param signature The signature.
function setAuthorizationWithSig(Authorization calldata authorization, Signature calldata signature) external;;
```

### accrueInterest(struct MarketParams) (inherited from IMorphoBase)

- **Signature**: `accrueInterest(struct MarketParams)`
- **Visibility**: external
- **Source Range**: 16319:67:455

**Signature:**
```solidity
/// @notice Accrues interest for the given market `marketParams`.
function accrueInterest(MarketParams memory marketParams) external;;
```

### extSloads(bytes32[]) (inherited from IMorphoBase)

- **Signature**: `extSloads(bytes32[])`
- **Visibility**: external
- **Source Range**: 16458:84:455

**Signature:**
```solidity
/// @notice Returns the data stored on the different `slots`.
function extSloads(bytes32[] memory slots) external view returns (bytes32[] memory);;
```
