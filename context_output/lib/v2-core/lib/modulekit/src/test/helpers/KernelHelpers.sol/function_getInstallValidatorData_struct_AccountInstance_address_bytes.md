# Function: getInstallValidatorData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `getInstallValidatorData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 10859:384:236

## Implementation

```solidity
/// @notice Gets the data to install a validator on an account instance
///  @dev
///  https://github.com/zerodevapp/kernel/blob/a807c8ec354a77ebb7cdb73c5be9dd315cda0df2/../../Kernel.sol#L311-L321
///  @param instance AccountInstance the account instance to install the validator on
///  implementation)
///  @param initData the data to pass to the validator
///  @return data the data to install the validator
function getInstallValidatorData(AccountInstance memory instance, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encodePacked(getHookMultiPlexer(instance), abi.encode(initData, hex"00", bytes(hex"00000001")));
}
```

## Related Implementations

### getHookMultiPlexer(struct AccountInstance)

- **Kind**: internal
- **Source**: 20760:180:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getHookMultiPlexer(struct AccountInstance)`

```solidity
/// @notice Gets the hook multiplexer for an account instance
///  @param instance AccountInstance the account instance to get the hook multiplexer for
///  @return address the address of the hook multiplexer
function getHookMultiPlexer(AccountInstance memory instance) public view returns (address) {
    return address(KernelFactory(instance.accountFactory).hookMultiPlexer());
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.getInstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 1)
      💬 Args: [instance]
      👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to install a validator on an account instance
 @dev
 https://github.com/zerodevapp/kernel/blob/a807c8ec354a77ebb7cdb73c5be9dd315cda0df2/../../Kernel.sol#L311-L321
 @param instance AccountInstance the account instance to install the validator on
 implementation)
 @param initData the data to pass to the validator
 @return data the data to install the validator
