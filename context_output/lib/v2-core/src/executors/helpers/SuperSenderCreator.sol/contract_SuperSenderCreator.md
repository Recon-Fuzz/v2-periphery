# Contract: SuperSenderCreator

## Metadata

- **Name**: SuperSenderCreator
- **Type**: Contract
- **Path**: lib/v2-core/src/executors/helpers/SuperSenderCreator.sol
- **Documentation**: @title SuperSenderCreator
   @author Superform Labs
   @notice Contract to create sender accounts from initCode
   @dev This contract is used by SuperDestinationExecutor to create sender accounts

## Public/External Functions

### createSender(bytes)

- **Signature**: `createSender(bytes)`
- **Visibility**: external
- **Source Range**: 611:700:363
- **Details**: [function_createSender_bytes.md](./function_createSender_bytes.md)

**Signature:**
```solidity
///  call the "initCode" factory to create and return the sender account address
///  @param initCode the initCode value from a UserOp. contains 20 bytes of factory address, followed by calldata
///  @return sender the returned address of the created account, or zero address on failure.
function createSender(bytes calldata initCode) external returns (address sender);
```
