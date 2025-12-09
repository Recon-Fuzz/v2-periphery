# Function: test_ExecuteChangePriamryManager_UpdatesFeeRecipient()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteChangePriamryManager_UpdatesFeeRecipient()`
- **Visibility**: public
- **Source Range**: 75970:615:661

## Implementation

```solidity
function test_ExecuteChangePriamryManager_UpdatesFeeRecipient() public {
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    address newPrimaryManager = _deployAccount(0x12, "NewManager");
    vm.startPrank(secondaryManagers[0]);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newPrimaryManager, treasury);
    vm.warp(block.timestamp + 1 weeks);
    superVaultAggregator.executeChangePrimaryManager(strategy);
    vm.stopPrank();
    assertEq(ISuperVaultStrategy(strategy).getConfigInfo().recipient, treasury);
}
```

## Related Implementations

### _deployAccount(uint256,string)

- **Kind**: internal
- **Source**: 3858:217:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_deployAccount(uint256,string)`

```solidity
function _deployAccount(uint256 key_, string memory name_) internal returns (address) {
    address _user = vm.addr(key_);
    vm.deal(_user, LARGE);
    vm.label(_user, name_);
    return _user;
}
```

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **SuperVaultAggregator::getSecondaryManagers(address)**
- **Vm::startPrank(address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeChangePrimaryManager(address)**
- **Vm::stopPrank()**
- **ISuperVaultStrategy::getConfigInfo()**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteChangePriamryManager_UpdatesFeeRecipient() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x12, "NewManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
      💬 Args: [ISuperVaultStrategy(strategy).getConfigInfo().recipient, treasury]
      👁️  Def: internal
```
