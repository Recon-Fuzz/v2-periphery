# Function: pendingCancelDepositRequest(uint256,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `pendingCancelDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 6048:271:641

## Implementation

```solidity
function pendingCancelDepositRequest(uint256 requestId, address controller) external view returns (bool) {
    DepositRequestStruct storage request = depositRequests[requestId];
    return (request.controller == controller) && pendingCancelDeposit[requestId];
}
```

## State Variable Reads

- **depositRequests** (`mapping(uint256 => struct MockERC7540Tester.DepositRequestStruct)`)
- **pendingCancelDeposit** (`mapping(uint256 => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.pendingCancelDepositRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
