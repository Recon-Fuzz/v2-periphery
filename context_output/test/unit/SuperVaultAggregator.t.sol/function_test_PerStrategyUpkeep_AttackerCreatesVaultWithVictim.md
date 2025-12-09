# Function: test_PerStrategyUpkeep_AttackerCreatesVaultWithVictim()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_PerStrategyUpkeep_AttackerCreatesVaultWithVictim()`
- **Visibility**: public
- **Source Range**: 128645:2853:661

## Implementation

```solidity
/// @notice Test: Attacker creates vault with victim as mainManager → strategy has $0 balance
function test_PerStrategyUpkeep_AttackerCreatesVaultWithVictim() public {
    address victim = _deployAccount(0x99, "Victim");
    address attacker = _deployAccount(0x98, "Attacker");
    vm.prank(attacker);
    (, address attackerStrategy, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Attacker Vault", symbol: "ATK", mainManager: victim, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: attacker})}));
    assertEq(superVaultAggregator.getMainManager(attackerStrategy), victim, "Victim should be mainManager (attack succeeded)");
    assertEq(superVaultAggregator.getUpkeepBalance(attackerStrategy), 0, "Attacker-created strategy should have zero upkeep");
    uint256 victimUpkeep = 1000e18;
    MockUp(upToken).mint(victim, victimUpkeep);
    vm.startPrank(victim);
    IERC20(upToken).approve(address(superVaultAggregator), victimUpkeep);
    (, address victimStrategy, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Victim Vault", symbol: "VIC", mainManager: victim, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: victim})}));
    superVaultAggregator.depositUpkeep(victimStrategy, victimUpkeep);
    vm.stopPrank();
    assertEq(superVaultAggregator.getUpkeepBalance(victimStrategy), victimUpkeep, "Victim's strategy should have upkeep");
    assertEq(superVaultAggregator.getUpkeepBalance(attackerStrategy), 0, "Attacker's strategy should still have zero upkeep");
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

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **MockUp::mint(address,uint256)**
- **Vm::startPrank(address)**
- **IERC20::approve(address,uint256)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **upToken** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_PerStrategyUpkeep_AttackerCreatesVaultWithVictim() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x99, "Victim"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x98, "Attacker"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.getMainManager(attackerStrategy), victim, "Victim should be mainManager (attack succeeded)"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(attackerStrategy), 0, "Attacker-created strategy should have zero upkeep"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(victimStrategy), victimUpkeep, "Victim's strategy should have upkeep"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [superVaultAggregator.getUpkeepBalance(attackerStrategy), 0, "Attacker's strategy should still have zero upkeep"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test: Attacker creates vault with victim as mainManager → strategy has $0 balance
