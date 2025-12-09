# Function: cancelDepositRequest(uint256,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `cancelDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9832:399:641

## Implementation

```solidity
function cancelDepositRequest(uint256 requestId, address controller) external {
    require((msg.sender == controller) || operators[controller][msg.sender], "Not authorized");
    DepositRequestStruct storage request = depositRequests[requestId];
    require((request.controller == controller) && (!request.fulfilled), "Invalid request");
    pendingCancelDeposit[requestId] = true;
}
```

## State Variable Reads

- **operators** (`mapping(address => mapping(address => bool))`)
- **depositRequests** (`mapping(uint256 => struct MockERC7540Tester.DepositRequestStruct)`)

## State Variable Writes

- **pendingCancelDeposit** (`mapping(uint256 => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.cancelDepositRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
