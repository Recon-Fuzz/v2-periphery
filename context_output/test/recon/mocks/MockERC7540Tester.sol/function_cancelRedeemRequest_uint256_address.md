# Function: cancelRedeemRequest(uint256,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `cancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 10664:169:641

## Implementation

```solidity
function cancelRedeemRequest(uint256 requestId, address) external {
    pendingCancelRedeem[requestId] = true;
}
```

## State Variable Writes

- **pendingCancelRedeem** (`mapping(uint256 => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.cancelRedeemRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
