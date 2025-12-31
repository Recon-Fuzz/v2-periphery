# Interface: IStatelessValidator

## Metadata

- **Name**: IStatelessValidator
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/interfaces/IStatelessValidator.sol

## Public/External Functions

### validateSignatureWithData(bytes32,bytes,bytes)

- **Signature**: `validateSignatureWithData(bytes32,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 111:179:218

**Signature:**
```solidity
function validateSignatureWithData(bytes32 hash, bytes calldata signature, bytes calldata data) external view returns (bool);;
```
