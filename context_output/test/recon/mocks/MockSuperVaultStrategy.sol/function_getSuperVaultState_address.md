# Function: getSuperVaultState(address)

**Contract**: [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]

## Metadata

- **Contract**: MockSuperVaultStrategy
- **Signature**: `getSuperVaultState(address)`
- **Visibility**: public
- **Source Range**: 14751:210:645

## Implementation

```solidity
function getSuperVaultState(address) public view returns (ISuperVaultStrategy_SuperVaultState memory) {
    return _getSuperVaultStateReturn_0;
}
```

## State Variable Reads

- **_getSuperVaultStateReturn_0** (`struct MockSuperVaultStrategy.ISuperVaultStrategy_SuperVaultState`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultStrategy.getSuperVaultState(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
