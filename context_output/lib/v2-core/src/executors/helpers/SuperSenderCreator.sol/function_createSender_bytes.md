# Function: createSender(bytes)

**Contract**: [lib/v2-core/src/executors/helpers/SuperSenderCreator.sol/contract_SuperSenderCreator.md]

## Metadata

- **Contract**: SuperSenderCreator
- **Signature**: `createSender(bytes)`
- **Visibility**: external
- **Source Range**: 611:700:363

## Implementation

```solidity
///  call the "initCode" factory to create and return the sender account address
///  @param initCode the initCode value from a UserOp. contains 20 bytes of factory address, followed by calldata
///  @return sender the returned address of the created account, or zero address on failure.
function createSender(bytes calldata initCode) external returns (address sender) {
    if (initCode.length < 20) {
        return address(0);
    }
    address initAddress = address(bytes20(initCode[0:20]));
    bytes memory initCallData = initCode[20:];
    (bool success, bytes memory returnData) = initAddress.call(initCallData);
    if (!success) {
        return address(0);
    }
    sender = abi.decode(returnData, (address));
}
```

## External Calls

- **address::call(bytes memory)**

## Native Transfers

- **initAddress** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperSenderCreator.createSender(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 call the "initCode" factory to create and return the sender account address
 @param initCode the initCode value from a UserOp. contains 20 bytes of factory address, followed by calldata
 @return sender the returned address of the created account, or zero address on failure.
