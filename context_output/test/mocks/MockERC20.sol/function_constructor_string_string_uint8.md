# Function: constructor(string,string,uint8)

**Contract**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `constructor(string,string,uint8)`
- **Visibility**: public
- **Source Range**: 372:133:589

## Implementation

```solidity
constructor(string memory name_, string memory symbol_, uint8 decimals_) ERC20(name_,symbol_) {
    _decimals = decimals_;
}
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

- **_decimals** (`uint8`)
- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockERC20.constructor(string,string,uint8) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockERC20
  └─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 1)
      💬 Args: [name_, symbol_]
      🏗️  Contract: ERC20
```
