# Function: test_DefaultRedeemSlippageBps()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_DefaultRedeemSlippageBps()`
- **Visibility**: public
- **Source Range**: 9630:223:580

## Implementation

```solidity
function test_DefaultRedeemSlippageBps() public view {
    uint16 defaultSlippage = strategy.DEFAULT_REDEEM_SLIPPAGE_BPS();
    assertEq(defaultSlippage, 50, "DEFAULT_REDEEM_SLIPPAGE_BPS should be 50 (0.5%)");
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

- **SuperVaultStrategy::DEFAULT_REDEEM_SLIPPAGE_BPS()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_DefaultRedeemSlippageBps() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [defaultSlippage, 50, "DEFAULT_REDEEM_SLIPPAGE_BPS should be 50 (0.5%)"]
      👁️  Def: internal
```
