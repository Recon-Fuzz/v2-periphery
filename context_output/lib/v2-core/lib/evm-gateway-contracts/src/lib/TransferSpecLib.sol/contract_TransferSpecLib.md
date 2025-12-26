# Contract: TransferSpecLib

## Metadata

- **Name**: TransferSpecLib
- **Type**: Contract
- **Path**: lib/v2-core/lib/evm-gateway-contracts/src/lib/TransferSpecLib.sol
- **Documentation**: @title TransferSpecLib
   @notice Library for encoding, validating, hashing, and providing field accessors for `TransferSpec` structs
   @dev Provides low-level access and manipulation functions for byte-encoded `TransferSpec` data, using `TypedMemView`
        for efficient memory operations
   @dev The term "transfer payload" within this library refers to encoded `BurnIntent`s and `Attestation`s, which both
        contain a `TransferSpec`

## Errors

### TransferSpecDataTooShort

```solidity
/// Thrown when casting data as a `TransferSpec` and the input is shorter than the expected magic length
///  @param expectedMinimumLength   The expected minimum length of the data
///  @param actualLength            The actual length of the data
error TransferSpecDataTooShort(uint256 expectedMinimumLength, uint256 actualLength);
```

### InvalidTransferSpecMagic

```solidity
/// Thrown when casting data as a `TransferSpec` and the magic value is not the expected value
///  @param actualMagic   The magic value found in the data
error InvalidTransferSpecMagic(bytes4 actualMagic);
```

### TransferSpecHeaderTooShort

```solidity
/// Thrown when validating an encoded `TransferSpec` and the header is shorter than expected
///  @param expectedMinimumLength   The expected minimum length of the header
///  @param actualLength            The actual length of the header
error TransferSpecHeaderTooShort(uint256 expectedMinimumLength, uint256 actualLength);
```

### InvalidTransferSpecVersion

```solidity
/// Thrown when validating an encoded `TransferSpec` and the version is not the expected value
///  @param actualVersion   The version found in the data
error InvalidTransferSpecVersion(uint32 actualVersion);
```

### TransferSpecOverallLengthMismatch

```solidity
/// Thrown when validating an encoded `TransferSpec` and the length of the data is different than what is implied by
///  the hook data length
///  @param expectedTotalLength   The expected length of the data
///  @param actualTotalLength     The actual length of the data
error TransferSpecOverallLengthMismatch(uint256 expectedTotalLength, uint256 actualTotalLength);
```

### TransferSpecHookDataFieldTooLarge

```solidity
/// Thrown when encoding a `TransferSpec` and the hook data length exceeds the maximum encodable length
///  @param actualLength   The actual length of the hook data
///  @param maxLength      The maximum encodable length of the hook data
error TransferSpecHookDataFieldTooLarge(uint256 actualLength, uint256 maxLength);
```

### TransferSpecInvalidHookData

```solidity
/// Thrown when the declared hook data length in the `TransferSpec` does not match the actual length of the hook
///  data
///  @param expectedHookDataLength   The expected hook data length declared in the hook data length field
///  @param transferSpecLength       The length of the transfer spec
error TransferSpecInvalidHookData(uint256 expectedHookDataLength, uint256 transferSpecLength);
```

### IdentityPrecompileCallFailed

```solidity
/// Thrown when the identity precompile call fails during typed data hash computation
error IdentityPrecompileCallFailed();
```

### TransferPayloadDataTooShort

```solidity
/// Thrown when casting data as a transfer payload or transfer payload set and the input is shorter than the
///  expected magic length
///  @param expectedMinimumLength   The expected minimum length of the data
///  @param actualLength            The actual length of the data
error TransferPayloadDataTooShort(uint256 expectedMinimumLength, uint256 actualLength);
```

### InvalidTransferPayloadMagic

```solidity
/// Thrown when casting data as a transfer payload or transfer payload set and the magic value is not an expected
///  value
///  @param actualMagic   The magic value found in the data
error InvalidTransferPayloadMagic(bytes4 actualMagic);
```

### TransferPayloadHeaderTooShort

```solidity
/// Thrown when validating an encoded transfer payload and the header is shorter than expected
///  @param expectedMinimumLength   The expected minimum length of the header
///  @param actualLength            The actual length of the header
error TransferPayloadHeaderTooShort(uint256 expectedMinimumLength, uint256 actualLength);
```

### TransferPayloadOverallLengthMismatch

```solidity
/// Thrown when validating an encoded transfer payload and the length of the data is different than what is implied
///  by the embedded `TransferSpec`
///  @param expectedTotalLength   The expected length of the data
///  @param actualTotalLength     The actual length of the data
error TransferPayloadOverallLengthMismatch(uint256 expectedTotalLength, uint256 actualTotalLength);
```

### TransferPayloadSetHeaderTooShort

```solidity
/// Thrown when validating an encoded transfer payload set and the set header is shorter than expected
///  @param expectedMinimumLength   The expected minimum length of the header
///  @param actualLength            The actual length of the header
error TransferPayloadSetHeaderTooShort(uint256 expectedMinimumLength, uint256 actualLength);
```

### TransferPayloadSetElementHeaderTooShort

```solidity
/// Thrown when validating an encoded transfer payload set and one of the elements' header is shorter than expected
///  @param index             The index of the element with the issue
///  @param actualSetLength   The actual length of the encoded set
///  @param requiredOffset    The expected offset of the element header
error TransferPayloadSetElementHeaderTooShort(uint32 index, uint256 actualSetLength, uint256 requiredOffset);
```

### TransferPayloadSetElementTooShort

```solidity
/// Thrown when validating an encoded transfer payload set and one of the elements is shorter than expected
///  @param index             The index of the element with the issue
///  @param actualSetLength   The actual length of the encoded set
///  @param requiredOffset    The expected offset of the element header
error TransferPayloadSetElementTooShort(uint32 index, uint256 actualSetLength, uint256 requiredOffset);
```

### TransferPayloadSetInvalidElementMagic

```solidity
/// Thrown when validating an encoded transfer payload set and one of the elements has an unexpected magic value
///  @param index         The index of the element with the issue
///  @param actualMagic   The magic value found in the element
error TransferPayloadSetInvalidElementMagic(uint32 index, bytes4 actualMagic);
```

### TransferPayloadSetOverallLengthMismatch

```solidity
/// Thrown when validating an encoded transfer payload set and the length of the data is different than what is
///  implied by the transfer payloads themselves
///  @param expectedTotalLength   The expected length of the data
///  @param actualTotalLength     The actual length of the data
error TransferPayloadSetOverallLengthMismatch(uint256 expectedTotalLength, uint256 actualTotalLength);
```

### TransferPayloadSetTooManyElements

```solidity
/// Thrown when encoding a transfer payload set and the number of elements exceeds the maximum encodable value
///  @param maxElements   The maximum number of elements that is possible to encode
error TransferPayloadSetTooManyElements(uint32 maxElements);
```

### CursorOutOfBounds

```solidity
/// Thrown when iterating over a transfer payload or transfer payload set and `next()` is called on a cursor that is
///  already `done`
error CursorOutOfBounds();
```
