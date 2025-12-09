# Function: test_ExecuteChangePrimaryManager_Success()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteChangePrimaryManager_Success()`
- **Visibility**: public
- **Source Range**: 41624:1037:661

## Implementation

```solidity
/// @notice Tests that executeChangePrimaryManager succeeds with valid non-zero addresses
///  @dev This test validates the defense-in-depth zero address check in executeChangePrimaryManager
///  @dev The check protects against any future code changes that might bypass proposeChangePrimaryManager validation
function test_ExecuteChangePrimaryManager_Success() public {
    address newManager = _deployAccount(0x25, "NewManager");
    address newFeeRecipient = _deployAccount(0x26, "NewFeeRecipient");
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newManager, newFeeRecipient);
    vm.warp((block.timestamp + 7 days) + 1);
    superVaultAggregator.executeChangePrimaryManager(strategy);
    assertEq(superVaultAggregator.getMainManager(strategy), newManager, "New manager should be set");
    ISuperVaultStrategy.FeeConfig memory feeConfig = ISuperVaultStrategy(strategy).getConfigInfo();
    assertEq(feeConfig.recipient, newFeeRecipient, "Fee recipient should be updated");
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

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeChangePrimaryManager(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **ISuperVaultStrategy::getConfigInfo()**

## State Variable Reads

- **secondaryManager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteChangePrimaryManager_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x25, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x26, "NewFeeRecipient"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.getMainManager(strategy), newManager, "New manager should be set"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
      💬 Args: [feeConfig.recipient, newFeeRecipient, "Fee recipient should be updated"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that executeChangePrimaryManager succeeds with valid non-zero addresses
 @dev This test validates the defense-in-depth zero address check in executeChangePrimaryManager
 @dev The check protects against any future code changes that might bypass proposeChangePrimaryManager validation
