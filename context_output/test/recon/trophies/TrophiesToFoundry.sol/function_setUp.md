# Function: setUp()

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 363:48:656

## Implementation

```solidity
function setUp() public {
    setup();
}
```

## Related Implementations

### setup()

- **Kind**: internal
- **Source**: 6396:8908:631
- **Link**: `test/recon/Setup.sol:Setup:setup()`

```solidity
/// === Setup === ///
///  This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
function setup() virtual override internal {
    _addActor(address(0x100));
    _addActor(address(0x200));
    _newAsset(DECIMALS);
    _newAsset(DECIMALS);
    _switchAsset(0);
    erc4626YieldSource = _newYieldSource(_getAsset(), YieldSourceType.ERC4626);
    erc5115YieldSource = _newYieldSource(_getAsset(), YieldSourceType.ERC5115);
    erc7540YieldSource = _newYieldSource(_getAsset(), YieldSourceType.ERC7540);
    _switchYieldSource(0);
    superGovernor = SuperGovernor(payable(VmContractHelper652(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(address(this), address(this), address(this), address(this), address(this), address(this), feeRecipient, false))})));
    vaultImpl = SuperVault(payable(VmContractHelper652(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(superGovernor)))})));
    strategyImpl = SuperVaultStrategy(payable(VmContractHelper652(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))})));
    escrowImpl = SuperVaultEscrow(payable(VmContractHelper652(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"})));
    superVaultAggregator = new UnsafeSuperVaultAggregator(address(superGovernor), address(vaultImpl), address(strategyImpl), address(escrowImpl));
    superGovernor.setAddress(superGovernor.SUPER_VAULT_AGGREGATOR(), address(superVaultAggregator));
    address[] memory assets = _getAssets();
    superGovernor.setAddress(superGovernor.UP(), assets[1]);
    superGovernor.setAddress(superGovernor.UPKEEP_TOKEN(), assets[1]);
    superGovernor.setAddress(superGovernor.SUPER_BANK(), address(this));
    erc4626YieldSourceOracle = new MockERC4626YieldSourceOracle();
    erc5115YieldSourceOracle = new MockERC5115YieldSourceOracle();
    ECDSAPPSOracle = new MockECDSAPPSOracle();
    superGovernor.setActivePPSOracle(address(ECDSAPPSOracle));
    ECDSAPPSOracle.setSUPER_GOVERNORReturn(address(superVaultAggregator));
    asset = _getAsset();
    erc4626YieldSourceOracle.setValidAsset(asset, true);
    erc5115YieldSourceOracle.setValidAsset(asset, true);
    ISuperVaultAggregator.VaultCreationParams memory params = ISuperVaultAggregator.VaultCreationParams({asset: _getAsset(), name: "SuperVault", symbol: "SV", mainManager: address(this), secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 100, recipient: feeRecipient})});
    (address vaultAddr, address strategyAddr, address escrowAddr) = superVaultAggregator.createVault(params);
    superVault = SuperVault(vaultAddr);
    superVaultStrategy = SuperVaultStrategy(payable(strategyAddr));
    superVaultEscrow = SuperVaultEscrow(escrowAddr);
    /// 11. Deploy all hook contracts and helper
    merkleHelper = new MerkleTestHelper();
    approveAndDeposit4626Hook = new ApproveAndDeposit4626VaultHook();
    deposit4626Hook = new Deposit4626VaultHook();
    redeem4626Hook = new Redeem4626VaultHook();
    approveAndDeposit5115Hook = new ApproveAndDeposit5115VaultHook();
    deposit5115Hook = new Deposit5115VaultHook();
    redeem5115Hook = new Redeem5115VaultHook();
    deposit7540Hook = new Deposit7540VaultHook();
    redeem7540Hook = new Redeem7540VaultHook();
    requestDeposit7540Hook = new RequestDeposit7540VaultHook();
    requestRedeem7540Hook = new RequestRedeem7540VaultHook();
    approveAndRequestDeposit7540Hook = new ApproveAndRequestDeposit7540VaultHook();
    cancelDepositRequest7540Hook = new CancelDepositRequest7540Hook();
    cancelRedeemRequest7540Hook = new CancelRedeemRequest7540Hook();
    claimCancelDepositRequest7540Hook = new ClaimCancelDepositRequest7540Hook();
    claimCancelRedeemRequest7540Hook = new ClaimCancelRedeemRequest7540Hook();
    withdraw7540Hook = new Withdraw7540VaultHook();
    superGovernor.proposeUpkeepPaymentsChange(false);
    vm.warp(block.timestamp + 2 weeks);
    superGovernor.executeUpkeepPaymentsChange();
    superGovernor.registerHook(address(approveAndDeposit4626Hook));
    superGovernor.registerHook(address(deposit4626Hook));
    superGovernor.registerHook(address(redeem4626Hook));
    superGovernor.registerHook(address(approveAndDeposit5115Hook));
    superGovernor.registerHook(address(deposit5115Hook));
    superGovernor.registerHook(address(redeem5115Hook));
    superGovernor.registerHook(address(deposit7540Hook));
    superGovernor.registerHook(address(redeem7540Hook));
    superGovernor.registerHook(address(requestDeposit7540Hook));
    superGovernor.registerHook(address(requestRedeem7540Hook));
    superGovernor.registerHook(address(approveAndRequestDeposit7540Hook));
    superGovernor.registerHook(address(cancelDepositRequest7540Hook));
    superGovernor.registerHook(address(cancelRedeemRequest7540Hook));
    superGovernor.registerHook(address(claimCancelDepositRequest7540Hook));
    superGovernor.registerHook(address(claimCancelRedeemRequest7540Hook));
    superGovernor.registerHook(address(withdraw7540Hook));
    address[] memory approvalArray = new address[](6);
    approvalArray[0] = address(superVault);
    approvalArray[1] = address(superVaultStrategy);
    approvalArray[2] = address(superVaultAggregator);
    approvalArray[3] = erc4626YieldSource;
    approvalArray[4] = erc5115YieldSource;
    approvalArray[5] = erc7540YieldSource;
    _finalizeAssetDeployment(_getActors(), approvalArray, type(uint88).max);
}
```

### _addActor(address)

- **Kind**: internal
- **Source**: 1411:250:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_addActor(address)`

```solidity
/// @notice Adds an actor to the list of actors
function _addActor(address target) internal {
    if (_actors.contains(target)) {
        revert ActorExists();
    }
    if (target == address(this)) {
        revert DefaultActor();
    }
    _actors.add(target);
}
```

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8860:165:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 4255:127:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._indexes[value] != 0;
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8305:150:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2214:404:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._indexes[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _newAsset(uint8)

- **Kind**: internal
- **Source**: 1438:328:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_newAsset(uint8)`

```solidity
/// @notice Creates a new asset and adds it to the list of assets
///  @param decimals The number of decimals for the asset
///  @return The address of the new asset
function _newAsset(uint8 decimals) internal returns (address) {
    address asset_ = address(new MockERC20("Test Token", "TST", decimals));
    _addAsset(asset_);
    __asset = asset_;
    return asset_;
}
```

### _addAsset(address)

- **Kind**: internal
- **Source**: 1878:160:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_addAsset(address)`

```solidity
/// @notice Adds an asset to the list of assets
///  @param target The address of the asset to add
function _addAsset(address target) internal {
    if (_assets.contains(target)) {
        revert Exists();
    }
    _assets.add(target);
}
```

### _switchAsset(uint256)

- **Kind**: internal
- **Source**: 2588:127:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_switchAsset(uint256)`

```solidity
/// @notice Switches the current asset based on the entropy
///    NOTE: We revert if the entropy is greater than the number of actors, for Halmos compatibility
///  @param entropy The entropy to choose a random asset in the array for switching
function _switchAsset(uint256 entropy) internal {
    address target = _assets.at(entropy);
    __asset = target;
}
```

### at(struct EnumerableSet.AddressSet,uint256)

- **Kind**: internal
- **Source**: 9563:156:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:at(struct EnumerableSet.AddressSet,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function at(AddressSet storage set, uint256 index) internal view returns (address) {
    return address(uint160(uint256(_at(set._inner, index))));
}
```

### _at(struct EnumerableSet.Set,uint256)

- **Kind**: internal
- **Source**: 4912:118:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_at(struct EnumerableSet.Set,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function _at(Set storage set, uint256 index) private view returns (bytes32) {
    return set._values[index];
}
```

### _newYieldSource(address,enum YieldSourceType)

- **Kind**: internal
- **Source**: 2370:808:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_newYieldSource(address,enum YieldSourceType)`

```solidity
/// @notice Creates a new yield source and adds it to the list of yield sources
///  @param asset The asset to create the yield source for
///  @param yieldSourceType The type of yield source to deploy
///  @return The address of the new yield source
function _newYieldSource(address asset, YieldSourceType yieldSourceType) internal returns (address) {
    address yieldSource_;
    if (yieldSourceType == YieldSourceType.ERC4626) {
        yieldSource_ = address(new MockERC4626Tester(asset));
    } else if (yieldSourceType == YieldSourceType.ERC5115) {
        yieldSource_ = address(new MockERC5115Tester(asset));
    } else if (yieldSourceType == YieldSourceType.ERC7540) {
        yieldSource_ = address(new MockERC7540Tester(asset));
    } else {
        revert InvalidYieldSourceType();
    }
    _addYieldSource(yieldSource_);
    __yieldSource = yieldSource_;
    __currentYieldSourceType = yieldSourceType;
    return yieldSource_;
}
```

### _getAsset()

- **Kind**: internal
- **Source**: 938:163:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_getAsset()`

```solidity
/// @notice Returns the current active asset
function _getAsset() internal view returns (address) {
    if (__asset == address(0)) {
        revert NotSetup();
    }
    return __asset;
}
```

### _addYieldSource(address)

- **Kind**: internal
- **Source**: 3976:189:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_addYieldSource(address)`

```solidity
/// @notice Adds a yield source to the list of yield sources
///  @param target The address of the yield source to add
function _addYieldSource(address target) internal {
    if (_yieldSources.contains(target)) {
        revert YieldSourceExists();
    }
    _yieldSources.add(target);
}
```

### _switchYieldSource(uint256)

- **Kind**: internal
- **Source**: 5113:170:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_switchYieldSource(uint256)`

```solidity
/// @notice Switches the current yield source based on the entropy
///  @param entropy The entropy to choose a random yield source in the array for switching
function _switchYieldSource(uint256 entropy) internal {
    address target = _yieldSources.at(entropy % _yieldSources.length());
    __yieldSource = target;
}
```

### length(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 9106:115:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:length(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Returns the number of values in the set. O(1).
function length(AddressSet storage set) internal view returns (uint256) {
    return _length(set._inner);
}
```

### _length(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 4463:107:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_length(struct EnumerableSet.Set)`

```solidity
///  @dev Returns the number of values on the set. O(1).
function _length(Set storage set) private view returns (uint256) {
    return set._values.length;
}
```

### _getAssets()

- **Kind**: internal
- **Source**: 1153:103:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_getAssets()`

```solidity
/// @notice Returns all assets being used
function _getAssets() internal view returns (address[] memory) {
    return _assets.values();
}
```

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 10259:300:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    /// @solidity memory-safe-assembly
    assembly {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5570:109:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function _values(Set storage set) private view returns (bytes32[] memory) {
    return set._values;
}
```

### _finalizeAssetDeployment(address[],address[],uint256)

- **Kind**: internal
- **Source**: 3042:338:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_finalizeAssetDeployment(address[],address[],uint256)`

```solidity
/// @notice Mint initial balance and approve allowances for the active asset
///  @param actorsArray The array of actors to mint the asset to
///  @param approvalArray The array of addresses to approve the asset to
///  @param amount The amount of the asset to mint
function _finalizeAssetDeployment(address[] memory actorsArray, address[] memory approvalArray, uint256 amount) internal {
    _mintAssetToAllActors(actorsArray, amount);
    for (uint256 i; i < approvalArray.length; i++) {
        _approveAssetToAddressForAllActors(actorsArray, approvalArray[i]);
    }
}
```

### _getActors()

- **Kind**: internal
- **Source**: 1250:103:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActors()`

```solidity
/// @notice Returns all actors being used
function _getActors() internal view returns (address[] memory) {
    return _actors.values();
}
```

### _mintAssetToAllActors(address[],uint256)

- **Kind**: internal
- **Source**: 3553:409:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_mintAssetToAllActors(address[],uint256)`

```solidity
/// @notice Mint the asset to all actors
///  @param actorsArray The array of actors to mint the asset to
///  @param amount The amount of the asset to mint
function _mintAssetToAllActors(address[] memory actorsArray, uint256 amount) private {
    address[] memory assets = _getAssets();
    for (uint256 i; i < assets.length; i++) {
        for (uint256 j; j < actorsArray.length; j++) {
            vm.prank(actorsArray[j]);
            MockERC20(assets[i]).mint(actorsArray[j], amount);
        }
    }
}
```

### _approveAssetToAddressForAllActors(address[],address)

- **Kind**: internal
- **Source**: 4157:454:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_approveAssetToAddressForAllActors(address[],address)`

```solidity
/// @notice Approve the asset to all actors
///  @param actorsArray The array of actors to approve the asset from
///  @param addressToApprove The address to approve the asset to
function _approveAssetToAddressForAllActors(address[] memory actorsArray, address addressToApprove) private {
    address[] memory assets = _getAssets();
    for (uint256 i; i < assets.length; i++) {
        for (uint256 j; j < actorsArray.length; j++) {
            vm.prank(actorsArray[j]);
            MockERC20(assets[i]).approve(addressToApprove, type(uint256).max);
        }
    }
}
```

## State Variable Reads

- **DECIMALS** (`uint8`)
- **feeRecipient** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vaultImpl** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **strategyImpl** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **escrowImpl** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **superVaultAggregator** (`contract UnsafeSuperVaultAggregator`) [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]
- **ECDSAPPSOracle** (`contract MockECDSAPPSOracle`) [test/recon/mocks/MockECDSAPPSOracle.sol/contract_MockECDSAPPSOracle.md]
- **erc4626YieldSourceOracle** (`contract MockERC4626YieldSourceOracle`) [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]
- **asset** (`address`)
- **erc5115YieldSourceOracle** (`contract MockERC5115YieldSourceOracle`) [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]
- **approveAndDeposit4626Hook** (`contract ApproveAndDeposit4626VaultHook`) [lib/v2-core/src/hooks/vaults/4626/ApproveAndDeposit4626VaultHook.sol/contract_ApproveAndDeposit4626VaultHook.md]
- **deposit4626Hook** (`contract Deposit4626VaultHook`) [lib/v2-core/src/hooks/vaults/4626/Deposit4626VaultHook.sol/contract_Deposit4626VaultHook.md]
- **redeem4626Hook** (`contract Redeem4626VaultHook`) [lib/v2-core/src/hooks/vaults/4626/Redeem4626VaultHook.sol/contract_Redeem4626VaultHook.md]
- **approveAndDeposit5115Hook** (`contract ApproveAndDeposit5115VaultHook`) [lib/v2-core/src/hooks/vaults/5115/ApproveAndDeposit5115VaultHook.sol/contract_ApproveAndDeposit5115VaultHook.md]
- **deposit5115Hook** (`contract Deposit5115VaultHook`) [lib/v2-core/src/hooks/vaults/5115/Deposit5115VaultHook.sol/contract_Deposit5115VaultHook.md]
- **redeem5115Hook** (`contract Redeem5115VaultHook`) [lib/v2-core/src/hooks/vaults/5115/Redeem5115VaultHook.sol/contract_Redeem5115VaultHook.md]
- **deposit7540Hook** (`contract Deposit7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/Deposit7540VaultHook.sol/contract_Deposit7540VaultHook.md]
- **redeem7540Hook** (`contract Redeem7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/Redeem7540VaultHook.sol/contract_Redeem7540VaultHook.md]
- **requestDeposit7540Hook** (`contract RequestDeposit7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/RequestDeposit7540VaultHook.sol/contract_RequestDeposit7540VaultHook.md]
- **requestRedeem7540Hook** (`contract RequestRedeem7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/RequestRedeem7540VaultHook.sol/contract_RequestRedeem7540VaultHook.md]
- **approveAndRequestDeposit7540Hook** (`contract ApproveAndRequestDeposit7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/ApproveAndRequestDeposit7540VaultHook.sol/contract_ApproveAndRequestDeposit7540VaultHook.md]
- **cancelDepositRequest7540Hook** (`contract CancelDepositRequest7540Hook`) [lib/v2-core/src/hooks/vaults/7540/CancelDepositRequest7540Hook.sol/contract_CancelDepositRequest7540Hook.md]
- **cancelRedeemRequest7540Hook** (`contract CancelRedeemRequest7540Hook`) [lib/v2-core/src/hooks/vaults/7540/CancelRedeemRequest7540Hook.sol/contract_CancelRedeemRequest7540Hook.md]
- **claimCancelDepositRequest7540Hook** (`contract ClaimCancelDepositRequest7540Hook`) [lib/v2-core/src/hooks/vaults/7540/ClaimCancelDepositRequest7540Hook.sol/contract_ClaimCancelDepositRequest7540Hook.md]
- **claimCancelRedeemRequest7540Hook** (`contract ClaimCancelRedeemRequest7540Hook`) [lib/v2-core/src/hooks/vaults/7540/ClaimCancelRedeemRequest7540Hook.sol/contract_ClaimCancelRedeemRequest7540Hook.md]
- **withdraw7540Hook** (`contract Withdraw7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/Withdraw7540VaultHook.sol/contract_Withdraw7540VaultHook.md]
- **superVault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **superVaultStrategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **erc4626YieldSource** (`address`)
- **erc5115YieldSource** (`address`)
- **erc7540YieldSource** (`address`)
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_assets** (`struct EnumerableSet.AddressSet`)
- **__asset** (`address`)
- **_yieldSources** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **erc4626YieldSource** (`address`)
- **erc5115YieldSource** (`address`)
- **erc7540YieldSource** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vaultImpl** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **strategyImpl** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **escrowImpl** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **superVaultAggregator** (`contract UnsafeSuperVaultAggregator`) [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]
- **erc4626YieldSourceOracle** (`contract MockERC4626YieldSourceOracle`) [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]
- **erc5115YieldSourceOracle** (`contract MockERC5115YieldSourceOracle`) [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]
- **ECDSAPPSOracle** (`contract MockECDSAPPSOracle`) [test/recon/mocks/MockECDSAPPSOracle.sol/contract_MockECDSAPPSOracle.md]
- **asset** (`address`)
- **superVault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **superVaultStrategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **superVaultEscrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **merkleHelper** (`contract MerkleTestHelper`) [test/recon/helpers/MerkleTestHelper.sol/contract_MerkleTestHelper.md]
- **approveAndDeposit4626Hook** (`contract ApproveAndDeposit4626VaultHook`) [lib/v2-core/src/hooks/vaults/4626/ApproveAndDeposit4626VaultHook.sol/contract_ApproveAndDeposit4626VaultHook.md]
- **deposit4626Hook** (`contract Deposit4626VaultHook`) [lib/v2-core/src/hooks/vaults/4626/Deposit4626VaultHook.sol/contract_Deposit4626VaultHook.md]
- **redeem4626Hook** (`contract Redeem4626VaultHook`) [lib/v2-core/src/hooks/vaults/4626/Redeem4626VaultHook.sol/contract_Redeem4626VaultHook.md]
- **approveAndDeposit5115Hook** (`contract ApproveAndDeposit5115VaultHook`) [lib/v2-core/src/hooks/vaults/5115/ApproveAndDeposit5115VaultHook.sol/contract_ApproveAndDeposit5115VaultHook.md]
- **deposit5115Hook** (`contract Deposit5115VaultHook`) [lib/v2-core/src/hooks/vaults/5115/Deposit5115VaultHook.sol/contract_Deposit5115VaultHook.md]
- **redeem5115Hook** (`contract Redeem5115VaultHook`) [lib/v2-core/src/hooks/vaults/5115/Redeem5115VaultHook.sol/contract_Redeem5115VaultHook.md]
- **deposit7540Hook** (`contract Deposit7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/Deposit7540VaultHook.sol/contract_Deposit7540VaultHook.md]
- **redeem7540Hook** (`contract Redeem7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/Redeem7540VaultHook.sol/contract_Redeem7540VaultHook.md]
- **requestDeposit7540Hook** (`contract RequestDeposit7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/RequestDeposit7540VaultHook.sol/contract_RequestDeposit7540VaultHook.md]
- **requestRedeem7540Hook** (`contract RequestRedeem7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/RequestRedeem7540VaultHook.sol/contract_RequestRedeem7540VaultHook.md]
- **approveAndRequestDeposit7540Hook** (`contract ApproveAndRequestDeposit7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/ApproveAndRequestDeposit7540VaultHook.sol/contract_ApproveAndRequestDeposit7540VaultHook.md]
- **cancelDepositRequest7540Hook** (`contract CancelDepositRequest7540Hook`) [lib/v2-core/src/hooks/vaults/7540/CancelDepositRequest7540Hook.sol/contract_CancelDepositRequest7540Hook.md]
- **cancelRedeemRequest7540Hook** (`contract CancelRedeemRequest7540Hook`) [lib/v2-core/src/hooks/vaults/7540/CancelRedeemRequest7540Hook.sol/contract_CancelRedeemRequest7540Hook.md]
- **claimCancelDepositRequest7540Hook** (`contract ClaimCancelDepositRequest7540Hook`) [lib/v2-core/src/hooks/vaults/7540/ClaimCancelDepositRequest7540Hook.sol/contract_ClaimCancelDepositRequest7540Hook.md]
- **claimCancelRedeemRequest7540Hook** (`contract ClaimCancelRedeemRequest7540Hook`) [lib/v2-core/src/hooks/vaults/7540/ClaimCancelRedeemRequest7540Hook.sol/contract_ClaimCancelRedeemRequest7540Hook.md]
- **withdraw7540Hook** (`contract Withdraw7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/Withdraw7540VaultHook.sol/contract_Withdraw7540VaultHook.md]
- **_actors** (`struct EnumerableSet.AddressSet`)
- **__asset** (`address`)
- **_assets** (`struct EnumerableSet.AddressSet`)
- **__yieldSource** (`address`)
- **__currentYieldSourceType** (`enum YieldSourceType`)
- **_yieldSources** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TrophiesToFoundry.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Setup.setup() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 2)
    │   💬 Args: [address(0x100)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 3)
    │ │   💬 Args: [_actors, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 4)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 5)
    │     💬 Args: [_actors, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 6)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 7)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 8)
    │   💬 Args: [address(0x200)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 9)
    │ │   💬 Args: [_actors, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 10)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 11)
    │     💬 Args: [_actors, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 12)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 13)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._newAsset(uint8) (NodeID: 14)
    │   💬 Args: [DECIMALS]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 15)
    │     💬 Args: [asset_]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 16)
    │   │   💬 Args: [_assets, target]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 17)
    │   │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │   │     👁️  Def: private
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 18)
    │       💬 Args: [_assets, target]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 19)
    │         💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │         👁️  Def: private
    │       └─ [6] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 20)
    │           💬 Args: [set, value]
    │           👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._newAsset(uint8) (NodeID: 21)
    │   💬 Args: [DECIMALS]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 22)
    │     💬 Args: [asset_]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 23)
    │   │   💬 Args: [_assets, target]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 24)
    │   │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │   │     👁️  Def: private
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 25)
    │       💬 Args: [_assets, target]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 26)
    │         💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │         👁️  Def: private
    │       └─ [6] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 27)
    │           💬 Args: [set, value]
    │           👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._switchAsset(uint256) (NodeID: 28)
    │   💬 Args: [0]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 29)
    │     💬 Args: [_assets, entropy]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 30)
    │       💬 Args: [set._inner, index]
    │       👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: YieldManager._newYieldSource(address,enum YieldSourceType) (NodeID: 31)
    │   💬 Args: [_getAsset(), YieldSourceType.ERC4626]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AssetManager._getAsset() (NodeID: 38)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: YieldManager._addYieldSource(address) (NodeID: 32)
    │     💬 Args: [yieldSource_]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 33)
    │   │   💬 Args: [_yieldSources, target]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 34)
    │   │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │   │     👁️  Def: private
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 35)
    │       💬 Args: [_yieldSources, target]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 36)
    │         💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │         👁️  Def: private
    │       └─ [6] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 37)
    │           💬 Args: [set, value]
    │           👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: YieldManager._newYieldSource(address,enum YieldSourceType) (NodeID: 39)
    │   💬 Args: [_getAsset(), YieldSourceType.ERC5115]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AssetManager._getAsset() (NodeID: 46)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: YieldManager._addYieldSource(address) (NodeID: 40)
    │     💬 Args: [yieldSource_]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 41)
    │   │   💬 Args: [_yieldSources, target]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 42)
    │   │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │   │     👁️  Def: private
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 43)
    │       💬 Args: [_yieldSources, target]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 44)
    │         💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │         👁️  Def: private
    │       └─ [6] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 45)
    │           💬 Args: [set, value]
    │           👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: YieldManager._newYieldSource(address,enum YieldSourceType) (NodeID: 47)
    │   💬 Args: [_getAsset(), YieldSourceType.ERC7540]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AssetManager._getAsset() (NodeID: 54)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: YieldManager._addYieldSource(address) (NodeID: 48)
    │     💬 Args: [yieldSource_]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 49)
    │   │   💬 Args: [_yieldSources, target]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 50)
    │   │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │   │     👁️  Def: private
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 51)
    │       💬 Args: [_yieldSources, target]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 52)
    │         💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │         👁️  Def: private
    │       └─ [6] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 53)
    │           💬 Args: [set, value]
    │           👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: YieldManager._switchYieldSource(uint256) (NodeID: 55)
    │   💬 Args: [0]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 56)
    │     💬 Args: [_yieldSources, entropy % _yieldSources.length()]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: EnumerableSet.length(struct EnumerableSet.AddressSet) (NodeID: 58)
    │   │   💬 Args: [_yieldSources]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 59)
    │   │     💬 Args: [set._inner]
    │   │     👁️  Def: private
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 57)
    │       💬 Args: [set._inner, index]
    │       👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._getAssets() (NodeID: 60)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 61)
    │     💬 Args: [_assets]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 62)
    │       💬 Args: [set._inner]
    │       👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._getAsset() (NodeID: 63)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AssetManager._getAsset() (NodeID: 64)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AssetManager._finalizeAssetDeployment(address[],address[],uint256) (NodeID: 65)
        💬 Args: [_getActors(), approvalArray, type(uint88).max]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 74)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 75)
      │     💬 Args: [_actors]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 76)
      │       💬 Args: [set._inner]
      │       👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: AssetManager._mintAssetToAllActors(address[],uint256) (NodeID: 66)
      │   💬 Args: [actorsArray, amount]
      │   👁️  Def: private
      │ └─ [4] ⚙️ FUNCTION: AssetManager._getAssets() (NodeID: 67)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 68)
      │       💬 Args: [_assets]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 69)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      └─ [3] ⚙️ FUNCTION: AssetManager._approveAssetToAddressForAllActors(address[],address) (NodeID: 70)
          💬 Args: [actorsArray, approvalArray[i]]
          👁️  Def: private
        └─ [4] ⚙️ FUNCTION: AssetManager._getAssets() (NodeID: 71)
            💬 Args: [no args]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 72)
              💬 Args: [_assets]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 73)
                💬 Args: [set._inner]
                👁️  Def: private
```
