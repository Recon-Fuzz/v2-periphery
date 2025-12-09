# Function: constructor()

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 3147:31:548

## Implementation

```solidity
constructor() ERC20("","") {}
```

## Related Implementations

### (string,string)

- **Kind**: internal
- **Source**: 1582:113:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:constructor(string,string)`

```solidity
///  @dev Sets the values for {name} and {symbol}.
///  Both values are immutable: they can only be set once during construction.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

## State Variable Writes

- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperAsset.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperAsset
  └─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 1)
      💬 Args: ["", ""]
      🏗️  Contract: ERC20
```
