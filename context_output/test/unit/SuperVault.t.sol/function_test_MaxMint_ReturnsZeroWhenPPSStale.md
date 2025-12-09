# Function: test_MaxMint_ReturnsZeroWhenPPSStale()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_MaxMint_ReturnsZeroWhenPPSStale()`
- **Visibility**: public
- **Source Range**: 15029:903:660

## Implementation

```solidity
/// @notice Tests maxMint returns 0 when PPS is stale (strategy unpaused but PPS not updated)
function test_MaxMint_ReturnsZeroWhenPPSStale() public {
    address testUser = _deployAccount(0xABC, "TestUser");
    vm.prank(manager);
    superVaultAggregator.pauseStrategy(address(strategy));
    vm.prank(manager);
    superVaultAggregator.unpauseStrategy(address(strategy));
    uint256 maxMintAmount = vault.maxMint(testUser);
    assertEq(maxMintAmount, 0, "Should return 0 when PPS is stale");
    assertFalse(superVaultAggregator.isStrategyPaused(address(strategy)), "Strategy should not be paused");
    assertTrue(superVaultAggregator.isPPSStale(address(strategy)), "PPS should be stale");
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::pauseStrategy(address)**
- **SuperVaultAggregator::unpauseStrategy(address)**
- **SuperVault::maxMint(address)**
- **SuperVaultAggregator::isStrategyPaused(address)**
- **SuperVaultAggregator::isPPSStale(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_MaxMint_ReturnsZeroWhenPPSStale() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xABC, "TestUser"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [maxMintAmount, 0, "Should return 0 when PPS is stale"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.isStrategyPaused(address(strategy)), "Strategy should not be paused"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
      💬 Args: [superVaultAggregator.isPPSStale(address(strategy)), "PPS should be stale"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests maxMint returns 0 when PPS is stale (strategy unpaused but PPS not updated)
