# Interface: IInvestmentManager

## Metadata

- **Name**: IInvestmentManager
- **Type**: Interface
- **Path**: test/mocks/centrifuge/IInvestmentManager.sol

## Implements Interfaces

- **IRecoverable** [test/mocks/centrifuge/IRecoverable.sol/interface_IRecoverable.md]
- **IMessageHandler** [test/mocks/centrifuge/IMessageHandler.sol/interface_IMessageHandler.md]

## Events

### File

```solidity
event File(bytes32 indexed what, address data);
```

### TriggerRedeemRequest

```solidity
event TriggerRedeemRequest(uint64 indexed poolId, bytes16 indexed trancheId, address user, address asset, uint128 shares);
```

## Enums

### Call

```solidity
enum Call {
    Invalid,
    MessageProof,
    InitiateMessageRecovery,
    DisputeMessageRecovery,
    Batch,
    ScheduleUpgrade,
    CancelUpgrade,
    RecoverTokens,
    UpdateCentrifugeGasPrice,
    AddAsset,
    AddPool,
    AddTranche,
    AllowAsset,
    DisallowAsset,
    UpdateTranchePrice,
    UpdateTrancheMetadata,
    UpdateTrancheHook,
    TransferAssets,
    TransferTrancheTokens,
    UpdateRestriction,
    DepositRequest,
    RedeemRequest,
    FulfilledDepositRequest,
    FulfilledRedeemRequest,
    CancelDepositRequest,
    CancelRedeemRequest,
    FulfilledCancelDepositRequest,
    FulfilledCancelRedeemRequest,
    TriggerRedeemRequest
}
```

## Public/External Functions

### investments(address,address)

- **Signature**: `investments(address,address)`
- **Visibility**: external
- **Source Range**: 3940:539:614

**Signature:**
```solidity
/// @notice Returns the investment state
function investments(address vault, address investor) external view returns (uint128 maxMint, uint128 maxWithdraw, uint256 depositPrice, uint256 redeemPrice, uint128 pendingDepositRequest, uint128 pendingRedeemRequest, uint128 claimableCancelDepositRequest, uint128 claimableCancelRedeemRequest, bool pendingCancelDepositRequest, bool pendingCancelRedeemRequest);;
```

### file(bytes32,address)

- **Signature**: `file(bytes32,address)`
- **Visibility**: external
- **Source Range**: 4670:51:614

**Signature:**
```solidity
/// @notice Updates contract parameters of type address.
///  @param what The bytes32 representation of 'gateway' or 'poolManager'.
///  @param data The new contract address.
function file(bytes32 what, address data) external;;
```

### requestDeposit(address,uint256,address,address,address)

- **Signature**: `requestDeposit(address,uint256,address,address,address)`
- **Visibility**: external
- **Source Range**: 5426:190:614

**Signature:**
```solidity
/// @notice Requests assets deposit. Liquidity pools have to request investments from Centrifuge before
///          shares can be minted. The deposit requests are added to the order book
///          on Centrifuge. Once the next epoch is executed on Centrifuge, vaults can
///          proceed with share payouts in case the order got fulfilled.
///  @dev    The assets required to fulfill the deposit request have to be locked and are transferred from the
///          owner to the escrow, even though the share payout can only happen after epoch execution.
///          The receiver becomes the owner of deposit request fulfillment.
function requestDeposit(address vault, uint256 assets, address receiver, address owner, address source) external returns (bool);;
```

### requestRedeem(address,uint256,address,address,address)

- **Signature**: `requestRedeem(address,uint256,address,address,address)`
- **Visibility**: external
- **Source Range**: 6315:195:614

**Signature:**
```solidity
/// @notice Requests share redemption. Liquidity pools have to request redemptions
///          from Centrifuge before actual asset payouts can be done. The redemption
///          requests are added to the order book on Centrifuge. Once the next epoch is
///          executed on Centrifuge, vaults can proceed with asset payouts
///          in case the order got fulfilled.
///  @dev    The shares required to fulfill the redemption request have to be locked and are transferred from the
///          owner to the escrow, even though the asset payout can only happen after epoch execution.
///          The receiver becomes the owner of redeem request fulfillment.
function requestRedeem(address vault, uint256 shares, address receiver, address, address source) external returns (bool);;
```

### cancelDepositRequest(address,address,address)

- **Signature**: `cancelDepositRequest(address,address,address)`
- **Visibility**: external
- **Source Range**: 7192:85:614

**Signature:**
```solidity
/// @notice Requests the cancellation of a pending deposit request. Liquidity pools have to request the
///          cancellation of outstanding requests from Centrifuge before actual assets can be unlocked and
///  transferred
///          to the owner.
///          While users have outstanding cancellation requests no new deposit requests can be submitted.
///          Once the next epoch is executed on Centrifuge, vaults can proceed with asset payouts
///          if orders could be cancelled successfully.
///  @dev    The cancellation request might fail in case the pending deposit order already got fulfilled on
///          Centrifuge.
function cancelDepositRequest(address vault, address owner, address source) external;;
```

### cancelRedeemRequest(address,address,address)

- **Signature**: `cancelRedeemRequest(address,address,address)`
- **Visibility**: external
- **Source Range**: 8009:84:614

**Signature:**
```solidity
/// @notice Requests the cancellation of an pending redeem request. Liquidity pools have to request the
///          cancellation of outstanding requests from Centrifuge before actual shares can be unlocked and
///          transferred to the owner.
///          While users have outstanding cancellation requests no new redeem requests can be submitted (exception:
///          trigger through governance).
///          Once the next epoch is executed on Centrifuge, vaults can proceed with share payouts
///          if the orders could be cancelled successfully.
///  @dev    The cancellation request might fail in case the pending redeem order already got fulfilled on
///          Centrifuge.
function cancelRedeemRequest(address vault, address owner, address source) external;;
```

### handle(bytes)

- **Signature**: `handle(bytes)`
- **Visibility**: external
- **Source Range**: 8291:49:614

**Signature:**
```solidity
/// @notice Handle incoming messages from Centrifuge. Parse the function params and forward to the corresponding
///          handler function.
function handle(bytes calldata message) external;;
```

### fulfillDepositRequest(uint64,bytes16,address,uint128,uint128,uint128)

- **Signature**: `fulfillDepositRequest(uint64,bytes16,address,uint128,uint128,uint128)`
- **Visibility**: external
- **Source Range**: 8813:199:614

**Signature:**
```solidity
/// @notice Fulfills pending deposit requests after successful epoch execution on Centrifuge.
///          The amount of shares that can be claimed by the user is minted and moved to the escrow contract.
///          The MaxMint bookkeeping value is updated.
///          The request fulfillment can be partial.
///  @dev    The shares in the escrow are reserved for the user and are transferred to the user on deposit
///          and mint calls.
function fulfillDepositRequest(uint64 poolId, bytes16 trancheId, address user, uint128 assetId, uint128 assets, uint128 shares) external;;
```

### fulfillRedeemRequest(uint64,bytes16,address,uint128,uint128,uint128)

- **Signature**: `fulfillRedeemRequest(uint64,bytes16,address,uint128,uint128,uint128)`
- **Visibility**: external
- **Source Range**: 9532:198:614

**Signature:**
```solidity
/// @notice Fulfills pending redeem requests after successful epoch execution on Centrifuge.
///          The amount of redeemed shares is burned. The amount of assets that can be claimed by the user in
///          return is locked in the escrow contract. The MaxWithdraw bookkeeping value is updated.
///          The request fulfillment can be partial.
///  @dev    The assets in the escrow are reserved for the user and are transferred to the user on redeem
///          and withdraw calls.
function fulfillRedeemRequest(uint64 poolId, bytes16 trancheId, address user, uint128 assetId, uint128 assets, uint128 shares) external;;
```

### fulfillCancelDepositRequest(uint64,bytes16,address,uint128,uint128,uint128)

- **Signature**: `fulfillCancelDepositRequest(uint64,bytes16,address,uint128,uint128,uint128)`
- **Visibility**: external
- **Source Range**: 13668:210:614

**Signature:**
```solidity
/// @notice Fulfills deposit request cancellation after successful epoch execution on Centrifuge.
///          The amount of assets that can be claimed by the user is locked in the escrow contract.
///          Updates claimableCancelDepositRequest bookkeeping value. The cancellation order execution can be
///          partial.
///  @dev    The assets in the escrow are reserved for the user and are transferred to the user during
///          claimCancelDepositRequest calls.
///          `fulfillment` represents the decrease in `pendingDepositRequest`.
///          This is a separate parameter from `assets` since there can be some precision loss when calculating this,
///          which would lead to having dust in the pendingDepositRequest value and
///          never closing out the request even after it is technically fulfilled.
///          Example:
///          User deposits 100 units of the vaults underlying asset.
///          - At some point they make cancellation request. The order in which is not guaranteed
///          Both requests arrive at CentrifugeChain. If the cancellation is first then all of the
///          deposited amount will be cancelled.
///          - There is the case where the deposit event is first and it gets completely fulfilled then
///          No amount of the deposited asset will be cancelled.
///          - There is the case where partially the deposit request is fulfilled. Let's say 40 units.
///          Then the cancel request arrives.
///          The remaining amount of deposited funds which is 60 units will cancelled.
///          There is a scenario where the deposit funds might different from the pool currency so some
///          swapping might happen. Either during this swapping or some fee collection or rounding there will be
///          difference between the actual amount that will be returned to the user.
///          `fulfillment` in this case will be 60 units but assets will be some lower amount because of the
///          aforementioned reasons
///          Let's assume the `asset` is 59. The user will be able to take back these 59 but
///          in order to not let any dust, we use `fulfillment` in our calculations.
///          `pendingDepositRequest` not necessary gets zeroed during this cancellation event.
///          When CentrifugeChain process the cancel event on its side, part of the deposit might be fulfilled.
///          In such case the chain will send two messages, one `fulfillDepositRequest` and one
///          `fulfillCancelDepositRequest`. In the example above, given the 100 units
///          deposited, 40 units are fulfilled and 60 can be cancelled.
///          The two messages sent from CentrifugeChain are not guaranteed to arrive in order.
///          Assuming first is the `fulfillCancelDepositRequest` the `pendingDepositRequest` here will be reduced to
///          60 units only. Then the `fulfillCancelDepositRequest` arrives with `fulfillment` 60. This amount is
///          removed from `pendingDepositRequests`. Since there are not more pendingDepositRequest` the
///          `pendingCancelDepositRequest` gets deleted.
///          Assuming first the `fulfillCancelDepositRequest` arrives then the `pendingDepositRequest` will be 100.
///          `fulfillment` is 60 so we are left with `pendingDepositRequest` equals to 40 ( 100 - 60 ).
///          Then the second message arrives which is `fulfillDepositRequest`. ( Check `fulfillDepositRequest`
///          implementation for details.)
///          When it arrives the `pendingDepositRequest` is 40 and the assets is 40
///          so there are no more `pendingDepositRequest` and right there the `pendingCancelDepositRequest will be
///          deleted.
function fulfillCancelDepositRequest(uint64 poolId, bytes16 trancheId, address user, uint128 assetId, uint128 assets, uint128 fulfillment) external;;
```

### fulfillCancelRedeemRequest(uint64,bytes16,address,uint128,uint128)

- **Signature**: `fulfillCancelRedeemRequest(uint64,bytes16,address,uint128,uint128)`
- **Visibility**: external
- **Source Range**: 14384:180:614

**Signature:**
```solidity
/// @notice Fulfills redeem request cancellation after successful epoch execution on Centrifuge.
///          The amount of shares that can be claimed by the user is locked in the escrow contract.
///          Updates claimableCancelRedeemRequest bookkeeping value. The cancellation order execution can also be
///          partial.
///  @dev    The shares in the escrow are reserved for the user and are transferred to the user during
///          claimCancelRedeemRequest calls.
function fulfillCancelRedeemRequest(uint64 poolId, bytes16 trancheId, address user, uint128 assetId, uint128 shares) external;;
```

### triggerRedeemRequest(uint64,bytes16,address,uint128,uint128)

- **Signature**: `triggerRedeemRequest(uint64,bytes16,address,uint128,uint128)`
- **Visibility**: external
- **Source Range**: 15144:174:614

**Signature:**
```solidity
/// @notice Triggers a redeem request on behalf of the user through Centrifuge governance.
///          This function is required for legal/compliance reasons and rare scenarios, like share contract
///          migrations.
///          Once the next epoch is executed on Centrifuge, vaults can proceed with asset payouts in case the orders
///          got fulfilled.
///  @dev    The user share amount required to fulfill the redeem request has to be locked in escrow,
///          even though the asset payout can only happen after epoch execution.
function triggerRedeemRequest(uint64 poolId, bytes16 trancheId, address user, uint128 assetId, uint128 shares) external;;
```

### convertToShares(address,uint256)

- **Signature**: `convertToShares(address,uint256)`
- **Visibility**: external
- **Source Range**: 15415:96:614

**Signature:**
```solidity
/// @notice Converts the assets value to share decimals.
function convertToShares(address vault, uint256 _assets) external view returns (uint256 shares);;
```

### convertToAssets(address,uint256)

- **Signature**: `convertToAssets(address,uint256)`
- **Visibility**: external
- **Source Range**: 15579:96:614

**Signature:**
```solidity
/// @notice Converts the shares value to assets decimals.
function convertToAssets(address vault, uint256 _shares) external view returns (uint256 assets);;
```

### maxDeposit(address,address)

- **Signature**: `maxDeposit(address,address)`
- **Visibility**: external
- **Source Range**: 15857:81:614

**Signature:**
```solidity
/// @notice Returns the max amount of assets based on the unclaimed amount of shares after at least one successful
///          deposit order fulfillment on Centrifuge.
function maxDeposit(address vault, address user) external view returns (uint256);;
```

### maxMint(address,address)

- **Signature**: `maxMint(address,address)`
- **Visibility**: external
- **Source Range**: 16097:85:614

**Signature:**
```solidity
/// @notice Returns the max amount of shares a user can claim after at least one successful deposit order
///          fulfillment on Centrifuge.
function maxMint(address vault, address user) external view returns (uint256 shares);;
```

### maxWithdraw(address,address)

- **Signature**: `maxWithdraw(address,address)`
- **Visibility**: external
- **Source Range**: 16340:89:614

**Signature:**
```solidity
/// @notice Returns the max amount of assets a user can claim after at least one successful redeem order fulfillment
///          on Centrifuge.
function maxWithdraw(address vault, address user) external view returns (uint256 assets);;
```

### maxRedeem(address,address)

- **Signature**: `maxRedeem(address,address)`
- **Visibility**: external
- **Source Range**: 16610:87:614

**Signature:**
```solidity
/// @notice Returns the max amount of shares based on the unclaimed number of assets after at least one successful
///          redeem order fulfillment on Centrifuge.
function maxRedeem(address vault, address user) external view returns (uint256 shares);;
```

### pendingDepositRequest(address,address)

- **Signature**: `pendingDepositRequest(address,address)`
- **Visibility**: external
- **Source Range**: 16840:99:614

**Signature:**
```solidity
/// @notice Indicates whether a user has pending deposit requests and returns the total deposit request asset
///  request value.
function pendingDepositRequest(address vault, address user) external view returns (uint256 assets);;
```

### pendingRedeemRequest(address,address)

- **Signature**: `pendingRedeemRequest(address,address)`
- **Visibility**: external
- **Source Range**: 17057:98:614

**Signature:**
```solidity
/// @notice Indicates whether a user has pending redeem requests and returns the total share request value.
function pendingRedeemRequest(address vault, address user) external view returns (uint256 shares);;
```

### pendingCancelDepositRequest(address,address)

- **Signature**: `pendingCancelDepositRequest(address,address)`
- **Visibility**: external
- **Source Range**: 17245:105:614

**Signature:**
```solidity
/// @notice Indicates whether a user has pending deposit request cancellations.
function pendingCancelDepositRequest(address vault, address user) external view returns (bool isPending);;
```

### pendingCancelRedeemRequest(address,address)

- **Signature**: `pendingCancelRedeemRequest(address,address)`
- **Visibility**: external
- **Source Range**: 17439:104:614

**Signature:**
```solidity
/// @notice Indicates whether a user has pending redeem request cancellations.
function pendingCancelRedeemRequest(address vault, address user) external view returns (bool isPending);;
```

### claimableCancelDepositRequest(address,address)

- **Signature**: `claimableCancelDepositRequest(address,address)`
- **Visibility**: external
- **Source Range**: 17694:107:614

**Signature:**
```solidity
/// @notice Indicates whether a user has claimable deposit request cancellation and returns the total claim
///          value in assets.
function claimableCancelDepositRequest(address vault, address user) external view returns (uint256 assets);;
```

### claimableCancelRedeemRequest(address,address)

- **Signature**: `claimableCancelRedeemRequest(address,address)`
- **Visibility**: external
- **Source Range**: 17951:106:614

**Signature:**
```solidity
/// @notice Indicates whether a user has claimable redeem request cancellation and returns the total claim
///          value in shares.
function claimableCancelRedeemRequest(address vault, address user) external view returns (uint256 shares);;
```

### priceLastUpdated(address)

- **Signature**: `priceLastUpdated(address)`
- **Visibility**: external
- **Source Range**: 18145:84:614

**Signature:**
```solidity
/// @notice Returns the timestamp of the last share price update for a vault.
function priceLastUpdated(address vault) external view returns (uint64 lastUpdated);;
```

### deposit(address,uint256,address,address)

- **Signature**: `deposit(address,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 19021:115:614

**Signature:**
```solidity
/// @notice Processes owner's asset deposit after the epoch has been executed on Centrifuge and the deposit order
///          has been successfully processed (partial fulfillment possible).
///          Shares are transferred from the escrow to the receiver. Amount of shares is computed based of the amount
///          of assets and the owner's share price.
///  @dev    The assets required to fulfill the deposit are already locked in escrow upon calling requestDeposit.
///          The shares required to fulfill the deposit have already been minted and transferred to the escrow on
///          fulfillDepositRequest.
///          Receiver has to pass all the share token restrictions in order to receive the shares.
function deposit(address vault, uint256 assets, address receiver, address owner) external returns (uint256 shares);;
```

### mint(address,uint256,address,address)

- **Signature**: `mint(address,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 19882:112:614

**Signature:**
```solidity
/// @notice Processes owner's share mint after the epoch has been executed on Centrifuge and the deposit order has
///          been successfully processed (partial fulfillment possible).
///          Shares are transferred from the escrow to the receiver. Amount of assets is computed based of the amount
///          of shares and the owner's share price.
///  @dev    The assets required to fulfill the mint are already locked in escrow upon calling requestDeposit.
///          The shares required to fulfill the mint have already been minted and transferred to the escrow on
///          fulfillDepositRequest.
///          Receiver has to pass all the share token restrictions in order to receive the shares.
function mint(address vault, uint256 shares, address receiver, address owner) external returns (uint256 assets);;
```

### redeem(address,uint256,address,address)

- **Signature**: `redeem(address,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 20678:114:614

**Signature:**
```solidity
/// @notice Processes owner's share redemption after the epoch has been executed on Centrifuge and the redeem order
///          has been successfully processed (partial fulfillment possible).
///          Assets are transferred from the escrow to the receiver. Amount of assets is computed based of the amount
///          of shares and the owner's share price.
///  @dev    The shares required to fulfill the redemption were already locked in escrow on requestRedeem and burned
///          on fulfillRedeemRequest.
///          The assets required to fulfill the redemption have already been reserved in escrow on
///          fulfillRedeemtRequest.
function redeem(address vault, uint256 shares, address receiver, address owner) external returns (uint256 assets);;
```

### withdraw(address,uint256,address,address)

- **Signature**: `withdraw(address,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 21476:116:614

**Signature:**
```solidity
/// @notice Processes owner's asset withdrawal after the epoch has been executed on Centrifuge and the redeem order
///          has been successfully processed (partial fulfillment possible).
///          Assets are transferred from the escrow to the receiver. Amount of shares is computed based of the amount
///          of shares and the owner's share price.
///  @dev    The shares required to fulfill the withdrawal were already locked in escrow on requestRedeem and burned
///          on fulfillRedeemRequest.
///          The assets required to fulfill the withdrawal have already been reserved in escrow on
///          fulfillRedeemtRequest.
function withdraw(address vault, uint256 assets, address receiver, address owner) external returns (uint256 shares);;
```

### claimCancelDepositRequest(address,address,address)

- **Signature**: `claimCancelDepositRequest(address,address,address)`
- **Visibility**: external
- **Source Range**: 22052:117:614

**Signature:**
```solidity
/// @notice Processes owner's deposit request cancellation after the epoch has been executed on Centrifuge and the
///          deposit order cancellation has been successfully processed (partial fulfillment possible).
///          Assets are transferred from the escrow to the receiver.
///  @dev    The assets required to fulfill the claim have already been reserved for the owner in escrow on
///          fulfillCancelDepositRequest.
function claimCancelDepositRequest(address vault, address receiver, address owner) external returns (uint256 assets);;
```

### claimCancelRedeemRequest(address,address,address)

- **Signature**: `claimCancelRedeemRequest(address,address,address)`
- **Visibility**: external
- **Source Range**: 22728:116:614

**Signature:**
```solidity
/// @notice Processes owner's redeem request cancellation after the epoch has been executed on Centrifuge and the
///          redeem order cancellation has been successfully processed (partial fulfillment possible).
///          Shares are transferred from the escrow to the receiver.
///  @dev    The shares required to fulfill the claim have already been reserved for the owner in escrow on
///          fulfillCancelRedeemRequest.
///          Receiver has to pass all the share token restrictions in order to receive the shares.
function claimCancelRedeemRequest(address vault, address receiver, address owner) external returns (uint256 shares);;
```

### handleMessage(bytes) (inherited from IMessageHandler)

- **Signature**: `handleMessage(bytes)`
- **Visibility**: external
- **Source Range**: 90:54:615

**Signature:**
```solidity
function handleMessage(bytes memory message) external;;
```

### recoverTokens(address,address,uint256) (inherited from IRecoverable)

- **Signature**: `recoverTokens(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 452:75:617

**Signature:**
```solidity
/// @notice Used to recover any ERC-20 token.
///  @dev    This method is called only by authorized entities
///  @param  token It could be 0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
///          to recover locked native ETH or any ERC20 compatible token.
///  @param  to Receiver of the funds
///  @param  amount Amount to send to the receiver.
function recoverTokens(address token, address to, uint256 amount) external;;
```
