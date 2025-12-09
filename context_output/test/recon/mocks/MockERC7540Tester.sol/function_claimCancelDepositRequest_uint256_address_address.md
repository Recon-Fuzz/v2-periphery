# Function: claimCancelDepositRequest(uint256,address,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `claimCancelDepositRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 10237:421:641

## Implementation

```solidity
function claimCancelDepositRequest(uint256 requestId, address receiver, address) external returns (uint256 assets) {
    DepositRequestStruct storage request = depositRequests[requestId];
    assets = request.assets;
    request.canceled = true;
    pendingCancelDeposit[requestId] = false;
    asset.transfer(receiver, assets);
}
```

## External Calls

- **MockERC20::transfer(address,uint256)**

## Native Transfers

- **asset** (computed)

## State Variable Reads

- **depositRequests** (`mapping(uint256 => struct MockERC7540Tester.DepositRequestStruct)`)

## State Variable Writes

- **pendingCancelDeposit** (`mapping(uint256 => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.claimCancelDepositRequest(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
