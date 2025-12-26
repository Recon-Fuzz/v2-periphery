# Interface: IERC1271

## Metadata

- **Name**: IERC1271
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/interfaces/IERC1271.sol

## Public/External Functions

### isValidSignature(bytes32,bytes)

- **Signature**: `isValidSignature(bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 673:149:214

**Signature:**
```solidity
///  @dev Should return whether the signature provided is valid for the provided data
///  @param _dataHash Arbitrary length data signed on behalf of address(this)
///  @param _signature Signature byte array associated with _data
///  MUST return the bytes4 magic value 0x1626ba7e when function passes.
///  MUST NOT modify state (using STATICCALL for solc < 0.5, view modifier for solc >
///  0.5)
///  MUST allow external calls
function isValidSignature(bytes32 _dataHash, bytes calldata _signature) external view returns (bytes4);;
```
