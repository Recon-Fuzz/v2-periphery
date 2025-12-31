# Interface: IERC20Permit

## Metadata

- **Name**: IERC20Permit
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol

## Public/External Functions

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 7627:191:440

**Signature:**
```solidity
///  @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
///  given ``owner``'s signed approval.
///  IMPORTANT: The same issues {IERC20-approve} has related to transaction
///  ordering also apply here.
///  Emits an {Approval} event.
///  Requirements:
///  - `spender` cannot be the zero address.
///  - `deadline` must be a timestamp in the future.
///  - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
///  over the EIP712-formatted function arguments.
///  - the signature must use ``owner``'s current nonce (see {nonces}).
///  For more information on the signature format, see the
///  https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
///  section].
///  CAUTION: See Security Considerations above.
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;;
```

### nonces(address)

- **Signature**: `nonces(address)`
- **Visibility**: external
- **Source Range**: 8123:63:440

**Signature:**
```solidity
///  @dev Returns the current nonce for `owner`. This value must be
///  included whenever a signature is generated for {permit}.
///  Every successful call to {permit} increases ``owner``'s nonce by one. This
///  prevents a signature from being used multiple times.
function nonces(address owner) external view returns (uint256);;
```

### DOMAIN_SEPARATOR()

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 8378:60:440

**Signature:**
```solidity
///  @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```
