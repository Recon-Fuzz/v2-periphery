# Function: isValidUnderlyingAssets(address[],address[])

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `isValidUnderlyingAssets(address[],address[])`
- **Visibility**: external
- **Source Range**: 3254:225:607

## Implementation

```solidity
function isValidUnderlyingAssets(address[] memory, address[] memory) external view returns (bool[] memory) {
    bool[] memory validities = new bool[](1);
    validities[0] = validity;
    return validities;
}
```

## State Variable Reads

- **validity** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.isValidUnderlyingAssets(address[],address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
