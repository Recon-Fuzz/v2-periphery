# Function: yieldSource_redeem5115(address,uint256,address,uint256,bool)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `yieldSource_redeem5115(address,uint256,address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 6048:567:655
- **Inherited From**: YieldSourceTargets

## Implementation

```solidity
function yieldSource_redeem5115(address receiver, uint256 amountSharesToRedeem, address tokenOut, uint256 minTokenOut, bool burnFromInternalBalance) public asActor() {
    YieldSourceType currentType = _getCurrentYieldSourceType();
    address yieldSource = _getYieldSource();
    if (currentType == YieldSourceType.ERC5115) {
        MockERC5115Tester(yieldSource).redeem(receiver, amountSharesToRedeem, tokenOut, minTokenOut, burnFromInternalBalance);
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

- **MockERC5115Tester::redeem(address,uint256,address,uint256,bool)**

## State Variable Reads

- **__currentYieldSourceType** (`enum YieldSourceType`)
- **__yieldSource** (`address`)
- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: YieldSourceTargets.yieldSource_redeem5115(address,uint256,address,uint256,bool) (NodeID: 0)
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
