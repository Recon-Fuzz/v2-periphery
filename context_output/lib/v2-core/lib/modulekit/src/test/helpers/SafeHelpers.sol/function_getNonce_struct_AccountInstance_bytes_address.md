# Function: getNonce(struct AccountInstance,bytes,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getNonce(struct AccountInstance,bytes,address)`
- **Visibility**: public
- **Source Range**: 23309:343:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice Get the nonce for an account instance
///  @param instance AccountInstance the account instance to get the nonce for
///  @param txValidator address the address of the validator
///  @return nonce uint256 the nonce
function getNonce(AccountInstance memory instance, bytes memory, address txValidator) virtual public returns (uint256 nonce) {
    uint192 key = uint192(bytes24(bytes20(address(txValidator))));
    nonce = instance.aux.entrypoint.getNonce(address(instance.account), key);
}
```

## External Calls

- **IEntryPoint::getNonce(address,uint192)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getNonce(struct AccountInstance,bytes,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Get the nonce for an account instance
 @param instance AccountInstance the account instance to get the nonce for
 @param txValidator address the address of the validator
 @return nonce uint256 the nonce
