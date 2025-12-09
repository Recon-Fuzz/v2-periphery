# Function: constructor(contract IERC20,string,string,bool,bool,uint256)

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `constructor(contract IERC20,string,string,bool,bool,uint256)`
- **Visibility**: public
- **Source Range**: 1279:474:609

## Implementation

```solidity
constructor(IERC20 asset_, string memory name_, string memory symbol_, bool rugOnDeposit_, bool rugOnWithdraw_, uint256 rugPercentage_) ERC20(name_,symbol_) {
    _asset = asset_;
    _decimals = IERC20Metadata(address(asset_)).decimals();
    rugOnDeposit = rugOnDeposit_;
    rugOnWithdraw = rugOnWithdraw_;
    rugPercentage = (rugPercentage_ > 10_000) ? 10_000 : rugPercentage_;
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
- **rugOnDeposit** (`bool`)
- **rugOnWithdraw** (`bool`)
- **rugPercentage** (`uint256`)
- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: RuggableVault.constructor(contract IERC20,string,string,bool,bool,uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: RuggableVault
  └─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 1)
      💬 Args: [name_, symbol_]
      🏗️  Contract: ERC20
```
