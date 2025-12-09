# Function: constructor(address)

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 1135:97:590

## Implementation

```solidity
constructor(address usdc_) ERC20("MockETHReceiver","mETH") {
    USDC = IERC20(usdc_);
}
```

## Related Implementations

### (string,string)

- **Kind**: internal
- **Source**: 1582:113:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:constructor(string,string)`

```solidity
///  @dev Sets the values for {name} and {symbol}.
///  Both values are immutable: they can only be set once during construction.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

## State Variable Writes

- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockETHReceiver.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockETHReceiver
  └─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 1)
      💬 Args: ["MockETHReceiver", "mETH"]
      🏗️  Contract: ERC20
```
