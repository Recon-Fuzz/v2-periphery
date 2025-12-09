# Function: test_ChangeFeeRecipient_Success()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ChangeFeeRecipient_Success()`
- **Visibility**: public
- **Source Range**: 408210:303:580

## Implementation

```solidity
function test_ChangeFeeRecipient_Success() public {
    vm.prank(address(aggregator));
    strategy.changeFeeRecipient(TREASURY);
    address newFeeRecipient = strategy.getConfigInfo().recipient;
    assertEq(newFeeRecipient, TREASURY, "Fee recipient should be set to TREASURY");
}
```

## Related Implementations

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
- **SuperVaultStrategy::changeFeeRecipient(address)**
- **SuperVaultStrategy::getConfigInfo()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ChangeFeeRecipient_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [newFeeRecipient, TREASURY, "Fee recipient should be set to TREASURY"]
      👁️  Def: internal
```
