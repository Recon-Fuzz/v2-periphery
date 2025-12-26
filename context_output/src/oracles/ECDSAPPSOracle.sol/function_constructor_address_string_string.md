# Function: constructor(address,string,string)

**Contract**: [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Metadata

- **Contract**: ECDSAPPSOracle
- **Signature**: `constructor(address,string,string)`
- **Visibility**: public
- **Source Range**: 3093:240:532

## Implementation

```solidity
/// @notice Initializes the ECDSAPPSOracle contract
///  @param superGovernor_ Address of the SuperGovernor contract
///  @param name_ EIP-712 domain name (e.g., "SuperformOraclePPS"). Used for domain separation.
///  @param version_ EIP-712 domain version (e.g., "1"). Must match off-chain signing version.
///  @dev The name_ and version_ parameters define the EIP-712 domain separator and cannot be changed
///       after deployment. All validator signatures must be signed with matching domain parameters.
constructor(address superGovernor_, string memory name_, string memory version_) EIP712(name_,version_) {
    if (superGovernor_ == address(0)) revert INVALID_VALIDATOR();
    SUPER_GOVERNOR = ISuperGovernor(superGovernor_);
}
```

## Related Implementations

### (string,string)

- **Kind**: internal
- **Source**: 3428:431:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:constructor(string,string)`

```solidity
///  @dev Initializes the domain separator and parameter caches.
///  The meaning of `name` and `version` is specified in
///  https://eips.ethereum.org/EIPS/eip-712#definition-of-domainseparator[EIP-712]:
///  - `name`: the user readable name of the signing domain, i.e. the name of the DApp or the protocol.
///  - `version`: the current major version of the signing domain.
///  NOTE: These parameters cannot be changed except through a xref:learn::upgrading-smart-contracts.adoc[smart
///  contract upgrade].
constructor(string memory name, string memory version) {
    _name = name.toShortStringWithFallback(_nameFallback);
    _version = version.toShortStringWithFallback(_versionFallback);
    _hashedName = keccak256(bytes(name));
    _hashedVersion = keccak256(bytes(version));
    _cachedChainId = block.chainid;
    _cachedDomainSeparator = _buildDomainSeparator();
    _cachedThis = address(this);
}
```

### toShortStringWithFallback(string,string)

- **Kind**: internal
- **Source**: 2887:340:283
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toShortStringWithFallback(string,string)`

```solidity
///  @dev Encode a string into a `ShortString`, or write it to storage if it is too long.
function toShortStringWithFallback(string memory value, string storage store) internal returns (ShortString) {
    if (bytes(value).length < 32) {
        return toShortString(value);
    } else {
        StorageSlot.getStringSlot(store).value = value;
        return ShortString.wrap(FALLBACK_SENTINEL);
    }
}
```

### toShortString(string)

- **Kind**: internal
- **Source**: 1708:286:283
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toShortString(string)`

```solidity
///  @dev Encode a string of at most 31 chars into a `ShortString`.
///  This will trigger a `StringTooLong` error is the input string is too long.
function toShortString(string memory str) internal pure returns (ShortString) {
    bytes memory bstr = bytes(str);
    if (bstr.length > 31) {
        revert StringTooLong(str);
    }
    return ShortString.wrap(bytes32(uint256(bytes32(bstr)) | bstr.length));
}
```

### getStringSlot(string)

- **Kind**: internal
- **Source**: 3468:175:285
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol:StorageSlot:getStringSlot(string)`

```solidity
///  @dev Returns an `StringSlot` representation of the string storage pointer `store`.
function getStringSlot(string storage store) internal pure returns (StringSlot storage r) {
    assembly ("memory-safe") {
        r.slot := store.slot
    }
}
```

### _buildDomainSeparator()

- **Kind**: internal
- **Source**: 4213:179:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_buildDomainSeparator()`

```solidity
function _buildDomainSeparator() private view returns (bytes32) {
    return keccak256(abi.encode(TYPE_HASH, _hashedName, _hashedVersion, block.chainid, address(this)));
}
```

## State Variable Reads

- **_nameFallback** (`string`)
- **_versionFallback** (`string`)
- **FALLBACK_SENTINEL** (`bytes32`)
- **TYPE_HASH** (`bytes32`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)

## State Variable Writes

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_name** (`ShortString`)
- **_version** (`ShortString`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)
- **_cachedChainId** (`uint256`)
- **_cachedDomainSeparator** (`bytes32`)
- **_cachedThis** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: ECDSAPPSOracle.constructor(address,string,string) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: ECDSAPPSOracle
  └─ [1] 🏗️ CONSTRUCTOR: EIP712.constructor(string,string) (NodeID: 1)
      💬 Args: [name_, version_]
      🏗️  Contract: EIP712
    ├─ [2] ⚙️ FUNCTION: ShortStrings.toShortStringWithFallback(string,string) (NodeID: 2)
    │   💬 Args: [name, _nameFallback]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ShortStrings.toShortString(string) (NodeID: 3)
    │ │   💬 Args: [value]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StorageSlot.getStringSlot(string) (NodeID: 4)
    │     💬 Args: [store]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ShortStrings.toShortStringWithFallback(string,string) (NodeID: 5)
    │   💬 Args: [version, _versionFallback]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ShortStrings.toShortString(string) (NodeID: 6)
    │ │   💬 Args: [value]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StorageSlot.getStringSlot(string) (NodeID: 7)
    │     💬 Args: [store]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EIP712._buildDomainSeparator() (NodeID: 8)
        💬 Args: [no args]
        👁️  Def: private
```

## Documentation

### Function Documentation

@notice Initializes the ECDSAPPSOracle contract
 @param superGovernor_ Address of the SuperGovernor contract
 @param name_ EIP-712 domain name (e.g., "SuperformOraclePPS"). Used for domain separation.
 @param version_ EIP-712 domain version (e.g., "1"). Must match off-chain signing version.
 @dev The name_ and version_ parameters define the EIP-712 domain separator and cannot be changed
      after deployment. All validator signatures must be signed with matching domain parameters.
