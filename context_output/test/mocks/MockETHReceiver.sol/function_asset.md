# Function: asset()

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `asset()`
- **Visibility**: external
- **Source Range**: 1428:95:590

## Implementation

```solidity
function asset() override external view returns (address) {
    return address(USDC);
}
```

## State Variable Reads

- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.asset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns the address of the underlying token used for the Vault for accounting, depositing, and withdrawing.
 - MUST be an ERC-20 token contract.
 - MUST NOT revert.
