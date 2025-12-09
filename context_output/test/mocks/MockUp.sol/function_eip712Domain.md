# Function: eip712Domain()

**Contract**: [test/mocks/MockUp.sol/contract_MockUp.md]

## Metadata

- **Contract**: MockUp
- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 5228:557:288
- **Inherited From**: EIP712

## Implementation

```solidity
/// @inheritdoc IERC5267
function eip712Domain() virtual public view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions) {
    return (hex"0f", _EIP712Name(), _EIP712Version(), block.chainid, address(this), bytes32(0), new uint256[](0));
}
```

## Related Implementations

### _EIP712Name()

- **Kind**: internal
- **Source**: 6105:126:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_EIP712Name()`

```solidity
///  @dev The name parameter for the EIP712 domain.
///  NOTE: By default this function reads _name which is an immutable value.
///  It only reads from storage if necessary (in case the value is too large to fit in a ShortString).
function _EIP712Name() internal view returns (string memory) {
    return _name.toStringWithFallback(_nameFallback);
}
```

### toStringWithFallback(ShortString,string)

- **Kind**: internal
- **Source**: 3368:267:283
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toStringWithFallback(ShortString,string)`

```solidity
///  @dev Decode a string that was encoded to `ShortString` or written to storage using {toShortStringWithFallback}.
function toStringWithFallback(ShortString value, string storage store) internal pure returns (string memory) {
    if (ShortString.unwrap(value) != FALLBACK_SENTINEL) {
        return toString(value);
    } else {
        return store;
    }
}
```

### toString(ShortString)

- **Kind**: internal
- **Source**: 2078:378:283
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toString(ShortString)`

```solidity
///  @dev Decode a `ShortString` back to a "normal" string.
function toString(ShortString sstr) internal pure returns (string memory) {
    uint256 len = byteLength(sstr);
    string memory str = new string(32);
    assembly ("memory-safe") {
        mstore(str, len)
        mstore(add(str, 0x20), sstr)
    }
    return str;
}
```

### byteLength(ShortString)

- **Kind**: internal
- **Source**: 2528:245:283
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:byteLength(ShortString)`

```solidity
///  @dev Return the length of a `ShortString`.
function byteLength(ShortString sstr) internal pure returns (uint256) {
    uint256 result = uint256(ShortString.unwrap(sstr)) & 0xFF;
    if (result > 31) {
        revert InvalidShortString();
    }
    return result;
}
```

### _EIP712Version()

- **Kind**: internal
- **Source**: 6557:135:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_EIP712Version()`

```solidity
///  @dev The version parameter for the EIP712 domain.
///  NOTE: By default this function reads _version which is an immutable value.
///  It only reads from storage if necessary (in case the value is too large to fit in a ShortString).
function _EIP712Version() internal view returns (string memory) {
    return _version.toStringWithFallback(_versionFallback);
}
```

## State Variable Reads

- **_name** (`ShortString`)
- **_nameFallback** (`string`)
- **FALLBACK_SENTINEL** (`bytes32`)
- **_version** (`ShortString`)
- **_versionFallback** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EIP712.eip712Domain() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: EIP712._EIP712Name() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ShortStrings.toStringWithFallback(ShortString,string) (NodeID: 2)
  │     💬 Args: [_name, _nameFallback]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: ShortStrings.toString(ShortString) (NodeID: 3)
  │       💬 Args: [value]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: ShortStrings.byteLength(ShortString) (NodeID: 4)
  │         💬 Args: [sstr]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: EIP712._EIP712Version() (NodeID: 5)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ShortStrings.toStringWithFallback(ShortString,string) (NodeID: 6)
        💬 Args: [_version, _versionFallback]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ShortStrings.toString(ShortString) (NodeID: 7)
          💬 Args: [value]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: ShortStrings.byteLength(ShortString) (NodeID: 8)
            💬 Args: [sstr]
            👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC5267

### Interface Documentation

 @dev returns the fields and values that describe the domain separator used by this contract for EIP-712
 signature.
