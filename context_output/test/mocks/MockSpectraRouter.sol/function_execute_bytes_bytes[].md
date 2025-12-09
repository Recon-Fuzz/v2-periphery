# Function: execute(bytes,bytes[])

**Contract**: [test/mocks/MockSpectraRouter.sol/contract_MockSpectraRouter.md]

## Metadata

- **Contract**: MockSpectraRouter
- **Signature**: `execute(bytes,bytes[])`
- **Visibility**: external
- **Source Range**: 285:126:601

## Implementation

```solidity
function execute(bytes calldata, bytes[] calldata) external payable {
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
┌─ [0] ⚙️ FUNCTION: MockSpectraRouter.execute(bytes,bytes[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
