# Function: constructor(contract IERC20,string,string,uint256,bool)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `constructor(contract IERC20,string,string,uint256,bool)`
- **Visibility**: public
- **Source Range**: 1235:398:608

## Implementation

```solidity
constructor(IERC20 asset_, string memory name_, string memory symbol_, uint256 rugPercentage_, bool rugEnabled_) ERC20(name_,symbol_) {
    _asset = asset_;
    _decimals = IERC20Metadata(address(asset_)).decimals();
    rugPercentage = (rugPercentage_ > 10_000) ? 10_000 : rugPercentage_;
    rugEnabled = rugEnabled_;
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

## External Calls

- **IERC20Metadata::decimals()**

## State Variable Writes

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_decimals** (`uint8`)
- **rugPercentage** (`uint256`)
- **rugEnabled** (`bool`)
- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: RuggableConvertVault.constructor(contract IERC20,string,string,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: RuggableConvertVault
  └─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 1)
      💬 Args: [name_, symbol_]
      🏗️  Contract: ERC20
```
