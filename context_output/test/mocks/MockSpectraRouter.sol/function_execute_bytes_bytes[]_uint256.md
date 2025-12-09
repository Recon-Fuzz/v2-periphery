# Function: execute(bytes,bytes[],uint256)

**Contract**: [test/mocks/MockSpectraRouter.sol/contract_MockSpectraRouter.md]

## Metadata

- **Contract**: MockSpectraRouter
- **Signature**: `execute(bytes,bytes[],uint256)`
- **Visibility**: external
- **Source Range**: 417:135:601

## Implementation

```solidity
function execute(bytes calldata, bytes[] calldata, uint256) external payable {
    IERC20(ptToken).transfer(msg.sender, 1e6);
}
```

## External Calls

- **IERC20::transfer(address,uint256)**

## Native Transfers

- **unknown** (computed)

## State Variable Reads

- **ptToken** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSpectraRouter.execute(bytes,bytes[],uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
