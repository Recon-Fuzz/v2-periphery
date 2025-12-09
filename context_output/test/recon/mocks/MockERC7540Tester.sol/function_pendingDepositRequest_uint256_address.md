# Function: pendingDepositRequest(uint256,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `pendingDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 5362:336:641

## Implementation

```solidity
function pendingDepositRequest(uint256 requestId, address controller) external view returns (uint256) {
    DepositRequestStruct storage request = depositRequests[requestId];
    if (((request.controller != controller) || request.fulfilled) || request.canceled) {
        return 0;
    }
    return request.assets;
}
```

## State Variable Reads

- **depositRequests** (`mapping(uint256 => struct MockERC7540Tester.DepositRequestStruct)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.pendingDepositRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
