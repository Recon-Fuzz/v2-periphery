# Function: superVaultStrategy_handleOperations4626Mint(address,uint256,uint256,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `superVaultStrategy_handleOperations4626Mint(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1102:350:653
- **Inherited From**: SuperVaultStrategyTargets

## Implementation

```solidity
function superVaultStrategy_handleOperations4626Mint(address controller, uint256 sharesNet, uint256 assetsGross, uint256 assetsNet) public asActor() {
    superVaultStrategy.handleOperations4626Mint(controller, sharesNet, assetsGross, assetsNet);
}
```

## Related Implementations

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

- **SuperVaultStrategy::handleOperations4626Mint(address,uint256,uint256,uint256)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategyTargets.superVaultStrategy_handleOperations4626Mint(address,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
