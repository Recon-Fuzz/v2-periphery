# Interface: IERC1271

## Metadata

- **Name**: IERC1271
- **Type**: Interface
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC1271.sol
- **Documentation**:  @dev Interface of the ERC-1271 standard signature validation method for
   contracts as defined in https://eips.ethereum.org/EIPS/eip-1271[ERC-1271].

## Public/External Functions

### isValidSignature(bytes32,bytes)

- **Signature**: `isValidSignature(bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 545:108:253

**Signature:**
```solidity
///  @dev Should return whether the signature provided is valid for the provided data
///  @param hash      Hash of the data to be signed
///  @param signature Signature byte array associated with `hash`
function isValidSignature(bytes32 hash, bytes calldata signature) external view returns (bytes4 magicValue);;
```
