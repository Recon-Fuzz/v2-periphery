# Function: initialize(address,struct ISuperVaultStrategy.FeeConfig)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `initialize(address,struct ISuperVaultStrategy.FeeConfig)`
- **Visibility**: external
- **Source Range**: 5502:1468:513

## Implementation

```solidity
function initialize(address vaultAddress, FeeConfig memory feeConfigData) external initializer() {
    if (vaultAddress == address(0)) revert INVALID_VAULT();
    if (((feeConfigData.performanceFeeBps > 0) || (feeConfigData.managementFeeBps > 0)) && (feeConfigData.recipient == address(0))) revert ZERO_ADDRESS();
    if (feeConfigData.performanceFeeBps > MAX_PERFORMANCE_FEE) revert INVALID_PERFORMANCE_FEE_BPS();
    if (feeConfigData.managementFeeBps > BPS_PRECISION) revert INVALID_PERFORMANCE_FEE_BPS();
    __ReentrancyGuard_init();
    _vault = vaultAddress;
    _asset = IERC20(IERC4626(vaultAddress).asset());
    _vaultDecimals = IERC20Metadata(vaultAddress).decimals();
    PRECISION = 10 ** _vaultDecimals;
    feeConfig = feeConfigData;
    ppsExpiration = 1 days;
    (bool success, uint8 assetDecimals) = address(_asset).tryGetAssetDecimals();
    if (!success) revert INVALID_ASSET();
    vaultHwmPps = 10 ** assetDecimals;
    emit Initialized(_vault);
}
```

## Related Implementations

### __ReentrancyGuard_init()

- **Kind**: internal
- **Source**: 2684:111:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:__ReentrancyGuard_init()`

```solidity
function __ReentrancyGuard_init() internal onlyInitializing() {
    __ReentrancyGuard_init_unchained();
}
```

### __ReentrancyGuard_init_unchained()

- **Kind**: internal
- **Source**: 2801:183:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:__ReentrancyGuard_init_unchained()`

```solidity
function __ReentrancyGuard_init_unchained() internal onlyInitializing() {
    ReentrancyGuardStorage storage $ = _getReentrancyGuardStorage();
    $._status = NOT_ENTERED;
}
```

### _getReentrancyGuardStorage()

- **Kind**: internal
- **Source**: 2395:183:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:_getReentrancyGuardStorage()`

```solidity
function _getReentrancyGuardStorage() private pure returns (ReentrancyGuardStorage storage $) {
    assembly {
        $.slot := ReentrancyGuardStorageLocation
    }
}
```

### onlyInitializing()

- **Kind**: modifier
- **Source**: 6891:76:33
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol:Initializable:onlyInitializing()`

```solidity
///  @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
///  {initializer} and {reinitializer} modifiers, directly or indirectly.
modifier onlyInitializing() {
    _checkInitializing();
    _;
}
```

### _checkInitializing()

- **Kind**: internal
- **Source**: 7082:141:33
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol:Initializable:_checkInitializing()`

```solidity
///  @dev Reverts if the contract is not in an initializing state. See {onlyInitializing}.
function _checkInitializing() virtual internal view {
    if (!_isInitializing()) {
        revert NotInitializing();
    }
}
```

### _isInitializing()

- **Kind**: internal
- **Source**: 8485:120:33
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol:Initializable:_isInitializing()`

```solidity
///  @dev Returns `true` if the contract is currently initializing. See {onlyInitializing}.
function _isInitializing() internal view returns (bool) {
    return _getInitializableStorage()._initializing;
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

### initializer()

- **Kind**: modifier
- **Source**: 4069:1102:33
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol:Initializable:initializer()`

```solidity
///  @dev A modifier that defines a protected initializer function that can be invoked at most once. In its scope,
///  `onlyInitializing` functions can be used to initialize parent contracts.
///  Similar to `reinitializer(1)`, except that in the context of a constructor an `initializer` may be invoked any
///  number of times. This behavior in the constructor can be useful during testing and is not expected to be used in
///  production.
///  Emits an {Initialized} event.
modifier initializer() {
    InitializableStorage storage $ = _getInitializableStorage();
    bool isTopLevelCall = !$._initializing;
    uint64 initialized = $._initialized;
    bool initialSetup = (initialized == 0) && isTopLevelCall;
    bool construction = (initialized == 1) && (address(this).code.length == 0);
    if ((!initialSetup) && (!construction)) {
        revert InvalidInitialization();
    }
    $._initialized = 1;
    if (isTopLevelCall) {
        $._initializing = true;
    }
    _;
    if (isTopLevelCall) {
        $._initializing = false;
        emit Initialized(1);
    }
}
```

## External Calls

- **IERC4626::asset()**
- **IERC20Metadata::decimals()**
- **address::tryGetAssetDecimals(address)**

## State Variable Reads

- **MAX_PERFORMANCE_FEE** (`uint256`)
- **BPS_PRECISION** (`uint256`)
- **_vaultDecimals** (`uint8`)
- **_asset** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_vault** (`address`)
- **NOT_ENTERED** (`uint256`)
- **INITIALIZABLE_STORAGE** (`bytes32`)

## State Variable Writes

- **_vault** (`address`)
- **_asset** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_vaultDecimals** (`uint8`)
- **PRECISION** (`uint256`)
- **feeConfig** (`struct ISuperVaultStrategy.FeeConfig`)
- **ppsExpiration** (`uint256`)
- **vaultHwmPps** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.initialize(address,struct ISuperVaultStrategy.FeeConfig) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ReentrancyGuardUpgradeable.__ReentrancyGuard_init() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ReentrancyGuardUpgradeable.__ReentrancyGuard_init_unchained() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._getReentrancyGuardStorage() (NodeID: 3)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: private
  │ │ └─ [3] 🔒 MODIFIER: Initializable.onlyInitializing() (NodeID: 4)
  │ │     💬 Args: [no args]
  │ │   └─ [4] ⚙️ FUNCTION: Initializable._checkInitializing() (NodeID: 5)
  │ │       💬 Args: [no args]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Initializable._isInitializing() (NodeID: 6)
  │ │         💬 Args: [no args]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Initializable._getInitializableStorage() (NodeID: 7)
  │ │           💬 Args: [no args]
  │ │           👁️  Def: private
  │ │         └─ [7] ⚙️ FUNCTION: Initializable._initializableStorageSlot() (NodeID: 8)
  │ │             💬 Args: [no args]
  │ │             👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Initializable.onlyInitializing() (NodeID: 9)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: Initializable._checkInitializing() (NodeID: 10)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Initializable._isInitializing() (NodeID: 11)
  │         💬 Args: [no args]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Initializable._getInitializableStorage() (NodeID: 12)
  │           💬 Args: [no args]
  │           👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: Initializable._initializableStorageSlot() (NodeID: 13)
  │             💬 Args: [no args]
  │             👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Initializable.initializer() (NodeID: 14)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Initializable._getInitializableStorage() (NodeID: 15)
        💬 Args: [no args]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: Initializable._initializableStorageSlot() (NodeID: 16)
          💬 Args: [no args]
          👁️  Def: internal
```

## Documentation

### Interface Documentation

@notice Initializes the strategy with required parameters
 @param vaultAddress Address of the associated SuperVault
 @param feeConfigData Fee configuration
