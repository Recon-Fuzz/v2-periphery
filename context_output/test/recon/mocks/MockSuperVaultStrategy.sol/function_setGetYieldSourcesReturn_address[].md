# Function: setGetYieldSourcesReturn(address[])

**Contract**: [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]

## Metadata

- **Contract**: MockSuperVaultStrategy
- **Signature**: `setGetYieldSourcesReturn(address[])`
- **Visibility**: public
- **Source Range**: 4755:235:645

## Implementation

```solidity
function setGetYieldSourcesReturn(address[] memory _value0) public {
    delete _getYieldSourcesReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getYieldSourcesReturn_0.push(_value0[i]);
    }
}
```

## State Variable Writes

- **_getYieldSourcesReturn_0** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultStrategy.setGetYieldSourcesReturn(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
