# Function: test_PendingCancelRedeemRequest_InitialState()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_PendingCancelRedeemRequest_InitialState()`
- **Visibility**: public
- **Source Range**: 5874:586:660

## Implementation

```solidity
/// @notice Tests pendingCancelRedeemRequest returns false when no cancel request is pending
function test_PendingCancelRedeemRequest_InitialState() public {
    address testUser = _deployAccount(0xABC, "TestUser");
    bool isPending = vault.pendingCancelRedeemRequest(0, testUser);
    assertFalse(isPending, "Should return false when no cancel request is pending");
    bool strategyPending = strategy.pendingCancelRedeemRequest(testUser);
    assertEq(isPending, strategyPending, "Vault should return same value as strategy");
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

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2487:171:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperVault::pendingCancelRedeemRequest(uint256,address)**
- **SuperVaultStrategy::pendingCancelRedeemRequest(address)**

## State Variable Reads

- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_PendingCancelRedeemRequest_InitialState() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xABC, "TestUser"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
  │   💬 Args: [isPending, "Should return false when no cancel request is pending"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 3)
      💬 Args: [isPending, strategyPending, "Vault should return same value as strategy"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests pendingCancelRedeemRequest returns false when no cancel request is pending
