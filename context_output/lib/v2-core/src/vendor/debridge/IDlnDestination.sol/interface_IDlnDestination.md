# Interface: IDlnDestination

## Metadata

- **Name**: IDlnDestination
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/debridge/IDlnDestination.sol

## Public/External Functions

### fulfillOrder(struct Order,uint256,bytes32,bytes,address,address)

- **Signature**: `fulfillOrder(struct Order,uint256,bytes32,bytes,address,address)`
- **Visibility**: external
- **Source Range**: 2352:270:449

**Signature:**
```solidity
function fulfillOrder(Order memory _order, uint256 _fulFillAmount, bytes32 _orderId, bytes calldata _permitEnvelope, address _unlockAuthority, address _externalCallRewardBeneficiary) external payable;;
```

### externalCallAdapter()

- **Signature**: `externalCallAdapter()`
- **Visibility**: external
- **Source Range**: 2628:63:449

**Signature:**
```solidity
function externalCallAdapter() external view returns (address);;
```

### sendEvmOrderCancel(struct Order,address,uint256)

- **Signature**: `sendEvmOrderCancel(struct Order,address,uint256)`
- **Visibility**: external
- **Source Range**: 3474:163:449

**Signature:**
```solidity
/// @dev Send cancel order in [`Order::give::chain_id`]
///  If the order was not filled or canceled earlier, [`Order::order_authority_address_dst`] can cancel it and get
///  back the give part in [`Order::give::chain_id`] chain
///  In the receive chain, the [`dln::source::claim_order_cancel`] will be called
///  @param _order Full order for patch
///  @param _cancelBeneficiary address that will receive refund in give chain chain
///      * If [`Order::allowed_cancel_beneficiary`] is None then any [`Address`]
///      * If [`Order::allowed_cancel_beneficiary`] is Some then only itself
///  @param _executionFee execution fee for auto claim by keepers
///  # Allowed
///  By [`Order::order_authority_address_dst`] only
function sendEvmOrderCancel(Order memory _order, address _cancelBeneficiary, uint256 _executionFee) external payable;;
```
