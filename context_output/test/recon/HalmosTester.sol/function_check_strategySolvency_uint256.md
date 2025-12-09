# Function: check_strategySolvency(uint256)

**Contract**: [test/recon/HalmosTester.sol/contract_HalmosTester.md]

## Metadata

- **Contract**: HalmosTester
- **Signature**: `check_strategySolvency(uint256)`
- **Visibility**: public
- **Source Range**: 7533:647:629

## Implementation

```solidity
function check_strategySolvency(uint256 arrayLength) public {
    vm.assume(arrayLength > 0);
    vm.assume(arrayLength <= 10);
    _callSuperVaultStrategy(arrayLength);
    address[] memory actors = _getActors();
    uint256 summedMaxWithdraw;
    for (uint256 i; i < actors.length; i++) {
        summedMaxWithdraw += superVault.maxWithdraw(actors[i]);
    }
    uint256 strategyAssetBalance = MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
    assert(strategyAssetBalance >= summedMaxWithdraw);
}
```

## Related Implementations

### _callSuperVaultStrategy(uint256)

- **Kind**: internal
- **Source**: 5187:2340:629
- **Link**: `test/recon/HalmosTester.sol:HalmosTester:_callSuperVaultStrategy(uint256)`

```solidity
function _callSuperVaultStrategy(uint256 arrayLength) internal {
    address[] memory controllers = new address[](arrayLength);
    address[] memory hooks = new address[](arrayLength);
    bytes[] memory hookCalldata = new bytes[](arrayLength);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](arrayLength);
    bytes32[][] memory globalProofs = new bytes32[][](arrayLength);
    bytes32[][] memory strategyProofs = new bytes32[][](arrayLength);
    for (uint256 i; i < arrayLength; i++) {
        controllers[i] = svm.createAddress("controller");
        hooks[i] = svm.createAddress("hook");
        bytes memory data = new bytes(32);
        bytes32 dataContent = svm.createBytes32("hookData");
        assembly {
            mstore(add(data, 0x20), dataContent)
        }
        hookCalldata[i] = data;
        expectedAssetsOrSharesOut[i] = svm.createUint256("expectedOut");
        globalProofs[i] = new bytes32[](1);
        strategyProofs[i] = new bytes32[](1);
        globalProofs[i][0] = svm.createBytes32("globalProof");
        strategyProofs[i][0] = svm.createBytes32("strategyProof");
    }
    ISuperVaultStrategy.ExecuteArgs memory executeArgs = ISuperVaultStrategy.ExecuteArgs({hooks: hooks, hookCalldata: hookCalldata, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: globalProofs, strategyProofs: strategyProofs});
    bytes memory executeArgsBytes = abi.encode(executeArgs);
    (bool executeSuccess, ) = address(superVaultStrategy).call(abi.encodePacked(superVaultStrategy.executeHooks.selector, executeArgsBytes));
    vm.assume(executeSuccess);
    (bool fulfillSuccess, ) = address(superVaultStrategy).call(abi.encodePacked(superVaultStrategy.fulfillRedeemRequests.selector, controllers));
    vm.assume(fulfillSuccess);
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

## External Calls

- **Vm::assume(bool)**
- **SuperVault::maxWithdraw(address)**
- **MockERC20::balanceOf(address)**
- **SuperVault::asset()**

## State Variable Reads

- **superVault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **superVaultStrategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **_actors** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HalmosTester.check_strategySolvency(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HalmosTester._callSuperVaultStrategy(uint256) (NodeID: 1)
  │   💬 Args: [arrayLength]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 2)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 3)
        💬 Args: [_actors]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 4)
          💬 Args: [set._inner]
          👁️  Def: private
```
