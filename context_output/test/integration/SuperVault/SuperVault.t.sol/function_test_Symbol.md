# Function: test_Symbol()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_Symbol()`
- **Visibility**: public
- **Source Range**: 9498:126:580

## Implementation

```solidity
function test_Symbol() public view {
    string memory symbol = vault.symbol();
    assertEq(symbol, "SV_USDC");
}
```

## Related Implementations

### assertEq(string,string)

- **Kind**: internal
- **Source**: 5050:122:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string)`

```solidity
function assertEq(string memory left, string memory right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **SuperVault::symbol()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_Symbol() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 1)
      💬 Args: [symbol, "SV_USDC"]
      👁️  Def: internal
```
