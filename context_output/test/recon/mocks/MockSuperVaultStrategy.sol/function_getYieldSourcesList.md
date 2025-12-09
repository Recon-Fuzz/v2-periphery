# Function: getYieldSourcesList()

**Contract**: [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]

## Metadata

- **Contract**: MockSuperVaultStrategy
- **Signature**: `getYieldSourcesList()`
- **Visibility**: public
- **Source Range**: 15812:150:645

## Implementation

```solidity
function getYieldSourcesList() public view returns (ISuperVaultStrategy_YieldSourceInfo[] memory) {
    return _getYieldSourcesListReturn_0;
}
```

## State Variable Reads

- **_getYieldSourcesListReturn_0** (`struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSourceInfo[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultStrategy.getYieldSourcesList() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
