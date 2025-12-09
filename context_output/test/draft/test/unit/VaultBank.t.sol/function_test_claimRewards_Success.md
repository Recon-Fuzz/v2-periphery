# Function: test_claimRewards_Success()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_claimRewards_Success()`
- **Visibility**: public
- **Source Range**: 59933:614:570

## Implementation

```solidity
function test_claimRewards_Success() public {
    MockHookTarget mockTarget = new MockHookTarget();
    mockTarget.setShouldFailExecution(false);
    uint256 gasLimit = 100_000;
    uint256 value = 0;
    uint16 maxReturnDataCopy = 256;
    bytes memory data = abi.encodeWithSignature("execute()");
    vm.prank(address(this));
    bytes memory result = vaultBank.exposed_claimRewards(address(mockTarget), gasLimit, value, maxReturnDataCopy, data);
    assertTrue(result.length == 0, "Result should be empty for a successful call that doesn't return data");
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

- **MockHookTarget::setShouldFailExecution(bool)**
- **Vm::prank(address)**
- **TestVaultBank::exposed_claimRewards(address,uint256,uint256,uint16,bytes)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_claimRewards_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [result.length == 0, "Result should be empty for a successful call that doesn't return data"]
      👁️  Def: internal
```
