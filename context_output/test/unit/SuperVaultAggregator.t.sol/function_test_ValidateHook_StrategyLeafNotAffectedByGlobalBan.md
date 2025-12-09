# Function: test_ValidateHook_StrategyLeafNotAffectedByGlobalBan()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ValidateHook_StrategyLeafNotAffectedByGlobalBan()`
- **Visibility**: public
- **Source Range**: 166294:1516:661

## Implementation

```solidity
/// @notice Tests that strategy leaves are not affected by global leaf banning
function test_ValidateHook_StrategyLeafNotAffectedByGlobalBan() public {
    address hookAddress = address(0x123);
    bytes memory hookArgs = "test_args";
    bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(hookAddress, hookArgs))));
    vm.prank(manager);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, leaf);
    vm.warp((block.timestamp + superVaultAggregator.getHooksRootUpdateTimelock()) + 1);
    superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
    bytes32[] memory leaves = new bytes32[](1);
    leaves[0] = leaf;
    bool[] memory statuses = new bool[](1);
    statuses[0] = true;
    vm.prank(manager);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, strategy);
    bytes32[] memory globalProof = new bytes32[](0);
    bytes32[] memory strategyProof = new bytes32[](0);
    bool isValid = superVaultAggregator.validateHook(strategy, ISuperVaultAggregator.ValidateHookArgs({hookAddress: hookAddress, hookArgs: hookArgs, globalProof: globalProof, strategyProof: strategyProof}));
    assertTrue(isValid, "Hook should be valid via strategy root despite global ban");
}
```

## Related Implementations

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
- **SuperVaultAggregator::proposeStrategyHooksRoot(address,bytes32)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**
- **SuperVaultAggregator::executeStrategyHooksRootUpdate(address)**
- **SuperVaultAggregator::changeGlobalLeavesStatus(bytes32[],bool[],address)**
- **SuperVaultAggregator::validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ValidateHook_StrategyLeafNotAffectedByGlobalBan() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [isValid, "Hook should be valid via strategy root despite global ban"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that strategy leaves are not affected by global leaf banning
