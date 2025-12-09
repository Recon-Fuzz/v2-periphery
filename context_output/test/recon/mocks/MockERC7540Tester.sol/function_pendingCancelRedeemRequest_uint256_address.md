# Function: pendingCancelRedeemRequest(uint256,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `pendingCancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9534:267:641

## Implementation

```solidity
function pendingCancelRedeemRequest(uint256 requestId, address controller) external view returns (bool) {
    RedeemRequestStruct storage request = redeemRequests[requestId];
    return (request.controller == controller) && pendingCancelRedeem[requestId];
}
```

## State Variable Reads

- **redeemRequests** (`mapping(uint256 => struct MockERC7540Tester.RedeemRequestStruct)`)
- **pendingCancelRedeem** (`mapping(uint256 => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.pendingCancelRedeemRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
