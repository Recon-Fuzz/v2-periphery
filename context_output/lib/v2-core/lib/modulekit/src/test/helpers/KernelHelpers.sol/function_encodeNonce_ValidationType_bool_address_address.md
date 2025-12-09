# Function: encodeNonce(ValidationType,bool,address,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `encodeNonce(ValidationType,bool,address,address)`
- **Visibility**: public
- **Source Range**: 5375:882:236

## Implementation

```solidity
/// @notice Encodes the nonce for an account instance in the Kernel format
///  @param vType ValidationType the validation type
///  @param enable bool whether to enable the validator
///  @param account address the address of the account
///  @param validator address the address of the validator
///  @return nonce uint256 the encoded nonce
function encodeNonce(ValidationType vType, bool enable, address account, address validator) public view returns (uint256 nonce) {
    uint192 nonceKey = 0;
    if (vType == VALIDATION_TYPE_ROOT) {
        nonceKey = 0;
    } else if (vType == VALIDATION_TYPE_VALIDATOR) {
        ValidationMode mode = VALIDATION_MODE_DEFAULT;
        if (enable) {
            mode = VALIDATION_MODE_ENABLE;
        }
        nonceKey = ValidatorLib.encodeAsNonceKey(ValidationMode.unwrap(mode), ValidationType.unwrap(vType), bytes20(validator), 0);
    } else {
        revert("Invalid validation type");
    }
    return IEntryPoint(ENTRYPOINT_ADDR).getNonce(account, nonceKey);
}
```

## Related Implementations

### encodeAsNonceKey(bytes1,bytes1,bytes20,uint16)

- **Kind**: internal
- **Source**: 3021:392:164
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/kernel/lib/ValidationTypeLib.sol:ValidatorLib:encodeAsNonceKey(bytes1,bytes1,bytes20,uint16)`

```solidity
function encodeAsNonceKey(bytes1 mode, bytes1 vType, bytes20 ValidationIdWithoutType, uint16 nonceKey) internal pure returns (uint192 res) {
    assembly {
        res := or(nonceKey, shr(80, ValidationIdWithoutType))
        res := or(res, shr(72, vType))
        res := or(res, shr(64, mode))
    }
}
```

## External Calls

- **IEntryPoint::getNonce(address,uint192)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.encodeNonce(ValidationType,bool,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ValidatorLib.encodeAsNonceKey(bytes1,bytes1,bytes20,uint16) (NodeID: 1)
      💬 Args: [ValidationMode.unwrap(mode), ValidationType.unwrap(vType), bytes20(validator), 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Encodes the nonce for an account instance in the Kernel format
 @param vType ValidationType the validation type
 @param enable bool whether to enable the validator
 @param account address the address of the account
 @param validator address the address of the validator
 @return nonce uint256 the encoded nonce
