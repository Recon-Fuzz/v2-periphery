# Contract: ECDSA

## Metadata

- **Name**: ECDSA
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol
- **Documentation**:  @dev Elliptic Curve Digital Signature Algorithm (ECDSA) operations.
   These functions can be used to verify that a message was signed by the holder
   of the private keys of a given address.

## Errors

### ECDSAInvalidSignature

```solidity
///  @dev The signature derives the `address(0)`.
error ECDSAInvalidSignature();
```

### ECDSAInvalidSignatureLength

```solidity
///  @dev The signature has an invalid length.
error ECDSAInvalidSignatureLength(uint256 length);
```

### ECDSAInvalidSignatureS

```solidity
///  @dev The signature has an S value that is in the upper half order.
error ECDSAInvalidSignatureS(bytes32 s);
```

## Enums

### RecoverError

```solidity
enum RecoverError {
    NoError,
    InvalidSignature,
    InvalidSignatureLength,
    InvalidSignatureS
}
```
