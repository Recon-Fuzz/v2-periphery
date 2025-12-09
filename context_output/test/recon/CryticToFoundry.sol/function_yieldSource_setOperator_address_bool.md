# Function: yieldSource_setOperator(address,bool)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `yieldSource_setOperator(address,bool)`
- **Visibility**: public
- **Source Range**: 6660:346:655
- **Inherited From**: YieldSourceTargets

## Implementation

```solidity
/// ERC7540-specific functions ///
function yieldSource_setOperator(address operator, bool approved) public asActor() {
    YieldSourceType currentType = _getCurrentYieldSourceType();
    address yieldSource = _getYieldSource();
    if (currentType == YieldSourceType.ERC7540) {
        MockERC7540Tester(yieldSource).setOperator(operator, approved);
    }
}
```

## Related Implementations

### _getCurrentYieldSourceType()

- **Kind**: internal
- **Source**: 1974:126:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_getCurrentYieldSourceType()`

```solidity
/// @notice Returns the current yield source type
function _getCurrentYieldSourceType() internal view returns (YieldSourceType) {
    return __currentYieldSourceType;
}
```

### _getYieldSource()

- **Kind**: internal
- **Source**: 1548:192:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_getYieldSource()`

```solidity
/// @notice Returns the current active yield source
function _getYieldSource() internal view returns (address) {
    if (__yieldSource == address(0)) {
        revert YieldSourceNotSetup();
    }
    return __yieldSource;
}
```

### asActor()

- **Kind**: modifier
- **Source**: 5892:77:631
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

## External Calls

- **MockERC7540Tester::setOperator(address,bool)**

## State Variable Reads

- **__currentYieldSourceType** (`enum YieldSourceType`)
- **__yieldSource** (`address`)
- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: YieldSourceTargets.yieldSource_setOperator(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: YieldManager._getCurrentYieldSourceType() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 3)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 4)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

ERC7540-specific functions ///
