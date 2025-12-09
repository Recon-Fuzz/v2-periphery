# Function: execute(address,bytes)

**Contract**: [test/mocks/MockMultisig.sol/contract_MockMultisig.md]

## Metadata

- **Contract**: MockMultisig
- **Signature**: `execute(address,bytes)`
- **Visibility**: external
- **Source Range**: 1185:237:598

## Implementation

```solidity
/// @notice Execute a single call (for granting roles, etc.)
///  @param target Target contract address
///  @param data Calldata for the call
///  @return result Return data from the call
function execute(address target, bytes calldata data) external returns (bytes memory result) {
    (bool success, bytes memory returnData) = target.call(data);
    require(success, "Call failed");
    return returnData;
}
```

## External Calls

- **address::call(bytes calldata)**

## Native Transfers

- **target** (function parameter)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockMultisig.execute(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Execute a single call (for granting roles, etc.)
 @param target Target contract address
 @param data Calldata for the call
 @return result Return data from the call
