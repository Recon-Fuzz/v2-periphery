# Function: totalAssets()

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 5278:171:585

## Implementation

```solidity
function totalAssets() override public view returns (uint256) {
    return _totalAssets;
}
```

## State Variable Reads

- **_totalAssets** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.totalAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the total amount of the underlying asset that is “managed” by Vault.
 - SHOULD include any compounding that occurs from yield.
 - MUST be inclusive of any fees that are charged against assets in the Vault.
 - MUST NOT revert.
