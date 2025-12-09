# Function: inspect(bytes)

**Contract**: [test/mocks/MockMultiTargetHook.sol/contract_MockMultiTargetHook.md]

## Metadata

- **Contract**: MockMultiTargetHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 3512:245:597

## Implementation

```solidity
/// @notice Override inspect to return all external target addresses
///  @dev In the new system, this is used to create the Merkle leaf for validation.
///       The leaf will be: keccak256(bytes.concat(keccak256(abi.encode(hookAddress, encodedArgs))))
///       where encodedArgs = abi.encodePacked(token, recipient1, recipient2, recipient3)
function inspect(bytes calldata) override external view returns (bytes memory) {
    return abi.encodePacked(token, recipient1, recipient2, recipient3);
}
```

## State Variable Reads

- **token** (`address`)
- **recipient1** (`address`)
- **recipient2** (`address`)
- **recipient3** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockMultiTargetHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Override inspect to return all external target addresses
 @dev In the new system, this is used to create the Merkle leaf for validation.
      The leaf will be: keccak256(bytes.concat(keccak256(abi.encode(hookAddress, encodedArgs))))
      where encodedArgs = abi.encodePacked(token, recipient1, recipient2, recipient3)

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
