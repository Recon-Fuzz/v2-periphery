# Function: mockERC5115YieldSourceOracle_setValidAsset(address,bool)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `mockERC5115YieldSourceOracle_setValidAsset(address,bool)`
- **Visibility**: public
- **Source Range**: 954:241:649
- **Inherited From**: OracleTargets

## Implementation

```solidity
function mockERC5115YieldSourceOracle_setValidAsset(address asset, bool isValid) public asActor() {
    MockERC5115YieldSourceOracle(address(erc5115YieldSourceOracle)).setValidAsset(asset, isValid);
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

- **MockERC5115YieldSourceOracle::setValidAsset(address,bool)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OracleTargets.mockERC5115YieldSourceOracle_setValidAsset(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
