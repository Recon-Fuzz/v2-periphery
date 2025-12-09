# Interface: IERC7741

## Metadata

- **Name**: IERC7741
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/standards/ERC7741/IERC7741.sol

## Public/External Functions

### authorizeOperator(address,address,bool,bytes32,uint256,bytes)

- **Signature**: `authorizeOperator(address,address,bool,bytes32,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 272:231:470

**Signature:**
```solidity
///  @dev Grants or revokes permissions for `operator` to manage Requests on behalf of the
///       `msg.sender`, using an [EIP-712](./eip-712.md) signature.
function authorizeOperator(address controller, address operator, bool approved, bytes32 nonce, uint256 deadline, bytes memory signature) external returns (bool);;
```

### invalidateNonce(bytes32)

- **Signature**: `invalidateNonce(bytes32)`
- **Visibility**: external
- **Source Range**: 596:49:470

**Signature:**
```solidity
///  @dev Revokes the given `nonce` for `msg.sender` as the `owner`.
function invalidateNonce(bytes32 nonce) external;;
```

### authorizations(address,bytes32)

- **Signature**: `authorizations(address,bytes32)`
- **Visibility**: external
- **Source Range**: 749:93:470

**Signature:**
```solidity
///  @dev Returns whether the given `nonce` has been used for the `controller`.
function authorizations(address controller, bytes32 nonce) external view returns (bool used);;
```

### DOMAIN_SEPARATOR()

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 1148:60:470

**Signature:**
```solidity
///  @dev Returns the `DOMAIN_SEPARATOR` as defined according to EIP-712. The `DOMAIN_SEPARATOR
///       should be unique to the contract and chain to prevent replay attacks from other domains,
///       and satisfy the requirements of EIP-712, but is otherwise unconstrained.
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```
