# Function: requestDeposit(uint256,address,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `requestDeposit(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 4884:472:641

## Implementation

```solidity
function requestDeposit(uint256 assets, address controller, address owner) external returns (uint256 requestId) {
    requestId = _nextRequestId++;
    depositRequests[requestId] = DepositRequestStruct({assets: assets, controller: controller, owner: owner, fulfilled: false, canceled: false});
    asset.transferFrom(msg.sender, address(this), assets);
    emit DepositRequest(controller, owner, requestId, msg.sender, assets);
}
```

## External Calls

- **MockERC20::transferFrom(address,address,uint256)**

## State Variable Writes

- **_nextRequestId** (`uint256`)
- **depositRequests** (`mapping(uint256 => struct MockERC7540Tester.DepositRequestStruct)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.requestDeposit(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
