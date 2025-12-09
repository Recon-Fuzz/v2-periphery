# Function: constructor(address,string,string)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `constructor(address,string,string)`
- **Visibility**: public
- **Source Range**: 761:249:585

## Implementation

```solidity
constructor(address asset_, string memory name_, string memory symbol_) ERC4626(IERC20(asset_)) ERC20(name_,symbol_) {
    assetInstance = IERC20(asset_);
    _asset = address(asset_);
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

### (contract IERC20)

- **Kind**: internal
- **Source**: 4283:195:270
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol:ERC4626:constructor(contract IERC20)`

```solidity
///  @dev Set the underlying asset contract. This must be an ERC20-compatible contract (ERC-20 or ERC-777).
constructor(IERC20 asset_) {
    (bool success, uint8 assetDecimals) = _tryGetAssetDecimals(asset_);
    _underlyingDecimals = success ? assetDecimals : 18;
    _asset = asset_;
}
```

### _tryGetAssetDecimals(contract IERC20)

- **Kind**: internal
- **Source**: 4621:550:270
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol:ERC4626:_tryGetAssetDecimals(contract IERC20)`

```solidity
///  @dev Attempts to fetch the asset decimals. A return value of false indicates that the attempt failed in some way.
function _tryGetAssetDecimals(IERC20 asset_) private view returns (bool ok, uint8 assetDecimals) {
    (bool success, bytes memory encodedDecimals) = address(asset_).staticcall(abi.encodeCall(IERC20Metadata.decimals, ()));
    if (success && (encodedDecimals.length >= 32)) {
        uint256 returnedDecimals = abi.decode(encodedDecimals, (uint256));
        if (returnedDecimals <= type(uint8).max) {
            return (true, uint8(returnedDecimals));
        }
    }
    return (false, 0);
}
```

## State Variable Writes

- **assetInstance** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_asset** (`address`)
- **_name** (`string`)
- **_symbol** (`string`)
- **_underlyingDecimals** (`uint8`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: Mock4626Vault.constructor(address,string,string) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: Mock4626Vault
  ├─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 1)
  │   💬 Args: [name_, symbol_]
  │   🏗️  Contract: ERC20
  └─ [1] 🏗️ CONSTRUCTOR: ERC4626.constructor(contract IERC20) (NodeID: 2)
      💬 Args: [IERC20(asset_)]
      🏗️  Contract: ERC4626
    └─ [2] ⚙️ FUNCTION: ERC4626._tryGetAssetDecimals(contract IERC20) (NodeID: 3)
        💬 Args: [asset_]
        👁️  Def: private
```
