# Function: test_RevertWhen_ExecuteHooks_WithoutPayable()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_RevertWhen_ExecuteHooks_WithoutPayable()`
- **Visibility**: public
- **Source Range**: 412358:733:580

## Implementation

```solidity
function test_RevertWhen_ExecuteHooks_WithoutPayable() public {
    SimpleNonPayableContract nonPayable = new SimpleNonPayableContract();
    uint256 ethAmount = 1 ether;
    vm.deal(address(this), ethAmount);
    (bool success, ) = address(nonPayable).call{value: ethAmount}(abi.encodeWithSignature("nonPayableFunction()"));
    assertFalse(success, "Should fail when sending ETH to non-payable function");
}
```

## Related Implementations

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

- **Vm::deal(address,uint256)**
- **unknown::unknown**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_RevertWhen_ExecuteHooks_WithoutPayable() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
      💬 Args: [success, "Should fail when sending ETH to non-payable function"]
      👁️  Def: internal
```
