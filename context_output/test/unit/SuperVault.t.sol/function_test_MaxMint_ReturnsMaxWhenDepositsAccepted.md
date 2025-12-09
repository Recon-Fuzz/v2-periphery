# Function: test_MaxMint_ReturnsMaxWhenDepositsAccepted()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_MaxMint_ReturnsMaxWhenDepositsAccepted()`
- **Visibility**: public
- **Source Range**: 13353:665:660

## Implementation

```solidity
/// @notice Tests maxMint returns type(uint256).max when deposits can be accepted (initial state)
function test_MaxMint_ReturnsMaxWhenDepositsAccepted() public {
    address testUser = _deployAccount(0xABC, "TestUser");
    uint256 maxMintAmount = vault.maxMint(testUser);
    assertEq(maxMintAmount, type(uint256).max, "Should return type(uint256).max when deposits are accepted");
    assertFalse(superVaultAggregator.isStrategyPaused(address(strategy)), "Strategy should not be paused");
    assertFalse(superVaultAggregator.isPPSStale(address(strategy)), "PPS should not be stale");
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

## External Calls

- **SuperVault::maxMint(address)**
- **SuperVaultAggregator::isStrategyPaused(address)**
- **SuperVaultAggregator::isPPSStale(address)**

## State Variable Reads

- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_MaxMint_ReturnsMaxWhenDepositsAccepted() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xABC, "TestUser"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [maxMintAmount, type(uint256).max, "Should return type(uint256).max when deposits are accepted"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.isStrategyPaused(address(strategy)), "Strategy should not be paused"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 4)
      💬 Args: [superVaultAggregator.isPPSStale(address(strategy)), "PPS should not be stale"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests maxMint returns type(uint256).max when deposits can be accepted (initial state)
