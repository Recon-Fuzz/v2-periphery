# Function: test_RevertWhen_ReclaimingInsufficientBalance()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_RevertWhen_ReclaimingInsufficientBalance()`
- **Visibility**: public
- **Source Range**: 5512:262:569

## Implementation

```solidity
function test_RevertWhen_ReclaimingInsufficientBalance() public {
    uint256 balance = UpToken.balanceOf(address(distributor));
    vm.expectRevert(abi.encodeWithSignature("NO_TOKENS_TO_RECLAIM()"));
    distributor.reclaimTokens(balance + 1);
}
```

## External Calls

- **Up::balanceOf(address)**
- **Vm::expectRevert(bytes)**
- **UpDistributor::reclaimTokens(uint256)**

## State Variable Reads

- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_RevertWhen_ReclaimingInsufficientBalance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
