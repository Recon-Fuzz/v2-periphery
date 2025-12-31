# Interface: IDlnDestination

## Metadata

- **Name**: IDlnDestination
- **Type**: Interface
- **Path**: lib/v2-core/lib/pigeon/src/debridge/interfaces/IDlnDestination.sol

## Public/External Functions

### fulfillOrder(struct Order,uint256,bytes32,bytes,address,address)

- **Signature**: `fulfillOrder(struct Order,uint256,bytes32,bytes,address,address)`
- **Visibility**: external
- **Source Range**: 2328:254:312

**Signature:**
```solidity
function fulfillOrder(Order memory _order, uint256 _fulFillAmount, bytes32 _orderId, bytes calldata _permitEnvelope, address _unlockAuthority, address _externalCallRewardBeneficiary) external payable;;
```
