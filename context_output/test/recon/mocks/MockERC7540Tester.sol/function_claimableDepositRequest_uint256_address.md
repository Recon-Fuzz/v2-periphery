# Function: claimableDepositRequest(uint256,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `claimableDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 5704:338:641

## Implementation

```solidity
function claimableDepositRequest(uint256 requestId, address controller) external view returns (uint256) {
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
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.claimableDepositRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
