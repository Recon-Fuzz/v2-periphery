# Function: validateUserOp(struct PackedUserOperation,bytes32)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHybridValidator.sol/contract_MockHybridValidator.md]

## Metadata

- **Contract**: MockHybridValidator
- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 429:318:223

## Implementation

```solidity
function validateUserOp(PackedUserOperation calldata, bytes32) virtual override external returns (ValidationData) {
    return _packValidationData({sigFailed: false, validUntil: type(uint48).max, validAfter: 0});
}
```

## Related Implementations

### _packValidationData(bool,uint48,uint48)

- **Kind**: internal
- **Source**: 992:283:211
- **Link**: `lib/v2-core/lib/modulekit/src/module-bases/ERC7579ValidatorBase.sol:ERC7579ValidatorBase:_packValidationData(bool,uint48,uint48)`

```solidity
///  Helper to pack the return value for validateUserOp, when not using an aggregator.
///  @param sigFailed  - True for signature failure, false for success.
///  @param validUntil - Last timestamp this UserOperation is valid (or zero for
///  infinite).
///  @param validAfter - First timestamp this UserOperation is valid.
function _packValidationData(bool sigFailed, uint48 validUntil, uint48 validAfter) internal pure returns (ValidationData) {
    return ValidationData.wrap(_packValidationData4337(sigFailed, validUntil, validAfter));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHybridValidator.validateUserOp(struct PackedUserOperation,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC7579ValidatorBase._packValidationData(bool,uint48,uint48) (NodeID: 1)
      💬 Args: [false, type(uint48).max, 0]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC7579ValidatorBase._packValidationData(bool,uint48,uint48) (NodeID: 2)
        💬 Args: [sigFailed, validUntil, validAfter]
        👁️  Def: internal
```
