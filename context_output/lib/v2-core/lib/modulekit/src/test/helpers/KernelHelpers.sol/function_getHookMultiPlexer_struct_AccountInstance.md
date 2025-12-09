# Function: getHookMultiPlexer(struct AccountInstance)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `getHookMultiPlexer(struct AccountInstance)`
- **Visibility**: public
- **Source Range**: 20760:180:236

## Implementation

```solidity
/// @notice Gets the hook multiplexer for an account instance
///  @param instance AccountInstance the account instance to get the hook multiplexer for
///  @return address the address of the hook multiplexer
function getHookMultiPlexer(AccountInstance memory instance) public view returns (address) {
    return address(KernelFactory(instance.accountFactory).hookMultiPlexer());
}
```

## External Calls

- **KernelFactory::hookMultiPlexer()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the hook multiplexer for an account instance
 @param instance AccountInstance the account instance to get the hook multiplexer for
 @return address the address of the hook multiplexer
