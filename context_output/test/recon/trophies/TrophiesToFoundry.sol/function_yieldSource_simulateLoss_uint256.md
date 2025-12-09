# Function: yieldSource_simulateLoss(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `yieldSource_simulateLoss(uint256)`
- **Visibility**: public
- **Source Range**: 10766:579:655
- **Inherited From**: YieldSourceTargets

## Implementation

```solidity
/// Common yield manipulation functions ///
function yieldSource_simulateLoss(uint256 lossAmount) public {
    YieldSourceType currentType = _getCurrentYieldSourceType();
    address yieldSource = _getYieldSource();
    if (currentType == YieldSourceType.ERC4626) {
        MockERC4626Tester(yieldSource).simulateLoss(lossAmount);
    } else if (currentType == YieldSourceType.ERC5115) {
        MockERC5115Tester(yieldSource).simulateLoss(lossAmount);
    } else if (currentType == YieldSourceType.ERC7540) {
        MockERC7540Tester(yieldSource).simulateLoss(lossAmount);
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

## External Calls

- **MockERC4626Tester::simulateLoss(uint256)**
- **MockERC5115Tester::simulateLoss(uint256)**
- **MockERC7540Tester::simulateLoss(uint256)**

## State Variable Reads

- **__currentYieldSourceType** (`enum YieldSourceType`)
- **__yieldSource** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: YieldSourceTargets.yieldSource_simulateLoss(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: YieldManager._getCurrentYieldSourceType() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 2)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

Common yield manipulation functions ///
