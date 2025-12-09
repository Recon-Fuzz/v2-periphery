# Function: test_ChangePrimaryManager_UpdatesFeeRecipient()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_UpdatesFeeRecipient()`
- **Visibility**: public
- **Source Range**: 75257:707:661

## Implementation

```solidity
function test_ChangePrimaryManager_UpdatesFeeRecipient() public {
    address newManager = _deployAccount(0x11, "NewManager");
    address feeRecipient = _deployAccount(0x29, "FeeRecipient");
    ISuperVaultStrategy.FeeConfig memory feeConfig = ISuperVaultStrategy(strategy).getConfigInfo();
    address oldFeeRecipient = feeConfig.recipient;
    vm.prank(address(superGovernor));
    superVaultAggregator.changePrimaryManager(strategy, newManager, feeRecipient);
    feeConfig = ISuperVaultStrategy(strategy).getConfigInfo();
    assertEq(feeConfig.recipient, feeRecipient, "Fee recipient should be updated");
    assert(feeConfig.recipient != oldFeeRecipient);
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

- **ISuperVaultStrategy::getConfigInfo()**
- **Vm::prank(address)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**

## State Variable Reads

- **strategy** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_UpdatesFeeRecipient() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x11, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x29, "FeeRecipient"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
      💬 Args: [feeConfig.recipient, feeRecipient, "Fee recipient should be updated"]
      👁️  Def: internal
```
