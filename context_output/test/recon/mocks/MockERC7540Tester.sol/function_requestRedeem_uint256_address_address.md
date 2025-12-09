# Function: requestRedeem(uint256,address,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `requestRedeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 8443:405:641

## Implementation

```solidity
function requestRedeem(uint256 shares, address controller, address owner) external returns (uint256 requestId) {
    requestId = _nextRequestId++;
    redeemRequests[requestId] = RedeemRequestStruct({shares: shares, controller: controller, owner: owner, fulfilled: false, canceled: false});
    emit RedeemRequest(controller, owner, requestId, msg.sender, shares);
}
```

## State Variable Writes

- **_nextRequestId** (`uint256`)
- **redeemRequests** (`mapping(uint256 => struct MockERC7540Tester.RedeemRequestStruct)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.requestRedeem(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
