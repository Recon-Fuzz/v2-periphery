# Function: setGetYieldSourcesListReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSourceInfo[])

**Contract**: [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]

## Metadata

- **Contract**: MockSuperVaultStrategy
- **Signature**: `setGetYieldSourcesListReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSourceInfo[])`
- **Visibility**: public
- **Source Range**: 5244:275:645

## Implementation

```solidity
function setGetYieldSourcesListReturn(ISuperVaultStrategy_YieldSourceInfo[] memory _value0) public {
    delete _getYieldSourcesListReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getYieldSourcesListReturn_0.push(_value0[i]);
    }
}
```

## State Variable Writes

- **_getYieldSourcesListReturn_0** (`struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSourceInfo[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultStrategy.setGetYieldSourcesListReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSourceInfo[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
