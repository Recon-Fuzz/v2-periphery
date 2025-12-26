# Function: constructor(address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 4428:245:510

## Implementation

```solidity
constructor(address superGovernor_) {
    if (superGovernor_ == address(0)) revert ZERO_ADDRESS();
    SUPER_GOVERNOR = ISuperGovernor(superGovernor_);
    emit SuperGovernorSet(superGovernor_);
    _disableInitializers();
}
```

## Related Implementations

### _disableInitializers()

- **Kind**: internal
- **Source**: 7709:422:33
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol:Initializable:_disableInitializers()`

```solidity
///  @dev Locks the contract, preventing any future reinitialization. This cannot be part of an initializer call.
///  Calling this in the constructor of a contract will prevent that contract from being initialized or reinitialized
///  to any version. It is recommended to use this to lock implementation contracts that are designed to be called
///  through proxies.
///  Emits an {Initialized} event the first time it is successfully executed.
function _disableInitializers() virtual internal {
    InitializableStorage storage $ = _getInitializableStorage();
    if ($._initializing) {
        revert InvalidInitialization();
    }
    if ($._initialized != type(uint64).max) {
        $._initialized = type(uint64).max;
        emit Initialized(type(uint64).max);
    }
}
```

### _getInitializableStorage()

- **Kind**: internal
- **Source**: 9071:205:33
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol:Initializable:_getInitializableStorage()`

```solidity
///  @dev Returns a pointer to the storage namespace.
function _getInitializableStorage() private pure returns (InitializableStorage storage $) {
    bytes32 slot = _initializableStorageSlot();
    assembly {
        $.slot := slot
    }
}
```

### _initializableStorageSlot()

- **Kind**: internal
- **Source**: 8819:122:33
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol:Initializable:_initializableStorageSlot()`

```solidity
///  @dev Pointer to storage slot. Allows integrators to override it with a custom storage location.
///  NOTE: Consider following the ERC-7201 formula to derive storage locations.
function _initializableStorageSlot() virtual internal pure returns (bytes32) {
    return INITIALIZABLE_STORAGE;
}
```

## State Variable Reads

- **INITIALIZABLE_STORAGE** (`bytes32`)

## State Variable Writes

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperVault.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperVault
  └─ [1] ⚙️ FUNCTION: Initializable._disableInitializers() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Initializable._getInitializableStorage() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: Initializable._initializableStorageSlot() (NodeID: 3)
          💬 Args: [no args]
          👁️  Def: internal
```
