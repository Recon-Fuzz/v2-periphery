# Function: getConfigInfo()

**Contract**: [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]

## Metadata

- **Contract**: MockSuperVaultStrategy
- **Signature**: `getConfigInfo()`
- **Visibility**: public
- **Source Range**: 14418:130:645

## Implementation

```solidity
function getConfigInfo() public view returns (ISuperVaultStrategy_FeeConfig memory) {
    return _getConfigInfoReturn_0;
}
```

## State Variable Reads

- **_getConfigInfoReturn_0** (`struct MockSuperVaultStrategy.ISuperVaultStrategy_FeeConfig`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultStrategy.getConfigInfo() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
