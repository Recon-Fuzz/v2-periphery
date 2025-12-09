# Function: claimableRedeemRequest(uint256,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `claimableRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9193:335:641

## Implementation

```solidity
function claimableRedeemRequest(uint256 requestId, address controller) external view returns (uint256) {
    RedeemRequestStruct storage request = redeemRequests[requestId];
    if (((request.controller != controller) || request.fulfilled) || request.canceled) {
        return 0;
    }
    return request.shares;
}
```

## State Variable Reads

- **redeemRequests** (`mapping(uint256 => struct MockERC7540Tester.RedeemRequestStruct)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.claimableRedeemRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
