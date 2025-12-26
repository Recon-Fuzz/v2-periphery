# Interface: IERC5267

## Metadata

- **Name**: IERC5267
- **Type**: Interface
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol

## Events

### EIP712DomainChanged

```solidity
///  @dev MAY be emitted to signal that the domain could have changed.
event EIP712DomainChanged();
```

## Public/External Functions

### eip712Domain()

- **Signature**: `eip712Domain()`
- **Visibility**: external
- **Source Range**: 427:310:260

**Signature:**
```solidity
///  @dev returns the fields and values that describe the domain separator used by this contract for EIP-712
///  signature.
function eip712Domain() external view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);;
```
