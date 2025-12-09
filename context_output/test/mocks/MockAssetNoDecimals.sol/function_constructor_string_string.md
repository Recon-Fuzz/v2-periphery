# Function: constructor(string,string)

**Contract**: [test/mocks/MockAssetNoDecimals.sol/contract_MockAssetNoDecimals.md]

## Metadata

- **Contract**: MockAssetNoDecimals
- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 150:111:587

## Implementation

```solidity
constructor(string memory name_, string memory symbol_) {
    name = name_;
    symbol = symbol_;
}
```

## State Variable Writes

- **name** (`string`)
- **symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockAssetNoDecimals.constructor(string,string) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockAssetNoDecimals
```
