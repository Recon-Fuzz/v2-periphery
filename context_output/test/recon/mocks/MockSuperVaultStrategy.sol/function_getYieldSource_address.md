# Function: getYieldSource(address)

**Contract**: [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]

## Metadata

- **Contract**: MockSuperVaultStrategy
- **Signature**: `getYieldSource(address)`
- **Visibility**: public
- **Source Range**: 15224:194:645

## Implementation

```solidity
function getYieldSource(address) public view returns (ISuperVaultStrategy_YieldSource memory) {
    return _getYieldSourceReturn_0;
}
```

## State Variable Reads

- **_getYieldSourceReturn_0** (`struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSource`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultStrategy.getYieldSource(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
