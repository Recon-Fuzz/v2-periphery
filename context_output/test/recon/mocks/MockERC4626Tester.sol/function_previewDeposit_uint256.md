# Function: previewDeposit(uint256)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `previewDeposit(uint256)`
- **Visibility**: public
- **Source Range**: 6363:204:637

## Implementation

```solidity
/// @dev Preview deposit, reverts as specified
function previewDeposit(uint256 assets) override public view returns (uint256) {
    _performRevertBehaviour(revertBehaviours[FunctionType.DEPOSIT]);
    return super.previewDeposit(assets);
}
```

## Related Implementations

### _performRevertBehaviour(enum RevertType)

- **Kind**: internal
- **Source**: 7411:758:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:MockERC4626Tester:_performRevertBehaviour(enum RevertType)`

```solidity
/// @dev Revert in different ways to test the revert behaviour
function _performRevertBehaviour(RevertType action) internal pure {
    if (action == RevertType.THROW) {
        revert("A normal Revert");
    }
    if (action == RevertType.OOG) {
        uint256 i;
        while (true) {
            ++i;
        }
    }
    if (action == RevertType.RETURN_BOMB) {
        uint256 _bytes = 2_000_000;
        assembly {
            return(0, _bytes)
        }
    }
    if (action == RevertType.REVERT_BOMB) {
        uint256 _bytes = 2_000_000;
        assembly {
            revert(0, _bytes)
        }
    }
    return;
}
```

### previewDeposit(uint256)

- **Kind**: internal
- **Source**: 2147:125:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:previewDeposit(uint256)`

```solidity
function previewDeposit(uint256 assets) virtual public view returns (uint256) {
    return convertToShares(assets);
}
```

### convertToShares(uint256)

- **Kind**: internal
- **Source**: 1741:197:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:convertToShares(uint256)`

```solidity
function convertToShares(uint256 assets) virtual public view returns (uint256) {
    uint256 supply = totalSupply;
    return (supply == 0) ? assets : ((assets * supply) / totalAssets());
}
```

### totalAssets()

- **Kind**: internal
- **Source**: 1620:115:637
- **Link**: `test/recon/mocks/MockERC4626Tester.sol:ERC4626:totalAssets()`

```solidity
function totalAssets() virtual public view returns (uint256) {
    return asset.balanceOf(address(this));
}
```

## State Variable Reads

- **revertBehaviours** (`mapping(enum FunctionType => enum RevertType)`)
- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626Tester.previewDeposit(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MockERC4626Tester._performRevertBehaviour(enum RevertType) (NodeID: 1)
  │   💬 Args: [revertBehaviours[FunctionType.DEPOSIT]]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC4626.previewDeposit(uint256) (NodeID: 2)
      💬 Args: [assets]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC4626.convertToShares(uint256) (NodeID: 3)
        💬 Args: [assets]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: ERC4626.totalAssets() (NodeID: 4)
          💬 Args: [no args]
          👁️  Def: public
```

## Documentation

### Function Documentation

@dev Preview deposit, reverts as specified
