# Contract: ERC1967Proxy

## Metadata

- **Name**: ERC1967Proxy
- **Type**: Contract
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol
- **Documentation**:  @dev This contract implements an upgradeable proxy. It is upgradeable because calls are delegated to an
   implementation address that can be changed. This address is stored in storage in the location specified by
   https://eips.ethereum.org/EIPS/eip-1967[ERC-1967], so that it doesn't conflict with the storage layout of the
   implementation behind the proxy.

## Public/External Functions

### constructor(address,bytes)

- **Signature**: `constructor(address,bytes)`
- **Visibility**: public
- **Source Range**: 1081:133:263
- **Details**: [function_constructor_address_bytes.md](./function_constructor_address_bytes.md)

**Signature:**
```solidity
///  @dev Initializes the upgradeable proxy with an initial implementation specified by `implementation`.
///  If `_data` is nonempty, it's used as data in a delegate call to `implementation`. This will typically be an
///  encoded function call, and allows initializing the storage of the proxy like a Solidity constructor.
///  Requirements:
///  - If `data` is empty, `msg.value` must be zero.
constructor(address implementation, bytes memory _data) payable;
```

### fallback() (inherited from Proxy)

- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 2603:64:265
- **Details**: [function_fallback.md](./function_fallback.md)

**Signature:**
```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if no other
///  function in the contract matches the call data.
fallback() virtual external payable;
```
