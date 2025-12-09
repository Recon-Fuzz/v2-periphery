# Function: test_MaxMint()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_MaxMint()`
- **Visibility**: public
- **Source Range**: 51400:376:580

## Implementation

```solidity
function test_MaxMint() public view {
    uint256 result = vault.maxMint(accountEth);
    uint256 maxDeposit = vault.maxDeposit(accountEth);
    uint256 expectedMax = vault.convertToShares(maxDeposit);
    assertEq(result, expectedMax, "maxMint should match shares equivalent of maxDeposit");
}
```

## Related Implementations

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

## External Calls

- **SuperVault::maxMint(address)**
- **SuperVault::maxDeposit(address)**
- **SuperVault::convertToShares(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_MaxMint() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [result, expectedMax, "maxMint should match shares equivalent of maxDeposit"]
      👁️  Def: internal
```
