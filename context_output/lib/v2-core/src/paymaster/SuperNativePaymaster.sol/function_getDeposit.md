# Function: getDeposit()

**Contract**: [lib/v2-core/src/paymaster/SuperNativePaymaster.sol/contract_SuperNativePaymaster.md]

## Metadata

- **Contract**: SuperNativePaymaster
- **Signature**: `getDeposit()`
- **Visibility**: public
- **Source Range**: 4413:111:442
- **Inherited From**: BasePaymaster

## Implementation

```solidity
///  Return current paymaster's deposit on the entryPoint.
function getDeposit() public view returns (uint256) {
    return entryPoint.balanceOf(address(this));
}
```

## External Calls

- **IEntryPoint::balanceOf(address)**

## State Variable Reads

- **entryPoint** (`contract IEntryPoint`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IEntryPoint.sol/interface_IEntryPoint.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasePaymaster.getDeposit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 Return current paymaster's deposit on the entryPoint.
