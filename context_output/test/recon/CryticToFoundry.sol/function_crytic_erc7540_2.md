# Function: crytic_erc7540_2()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `crytic_erc7540_2()`
- **Visibility**: public
- **Source Range**: 14960:179:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property 7540-2: convertToShares(totalAssets) == totalSupply unless price is 0.0
function crytic_erc7540_2() public {
    actor = _getActor();
    t(erc7540_2(address(superVault)), "ERC7540-2: convertToShares(totalAssets) == totalSupply failed");
}
```

## Related Implementations

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

### t(bool,string)

- **Kind**: internal
- **Source**: 822:105:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:t(bool,string)`

```solidity
function t(bool b, string memory reason) virtual override internal {
    assertTrue(b, reason);
}
```

### erc7540_2(address)

- **Kind**: internal
- **Source**: 3278:619:10
- **Link**: `lib/erc7540-reusable-properties/src/ERC7540Properties.sol:ERC7540Properties:erc7540_2(address)`

```solidity
/// @dev 7540-2	convertToShares(totalAssets) == totalSupply unless price is 0.0
function erc7540_2(address erc7540Target) virtual public returns (bool) {
    if (IERC7540Like(erc7540Target).convertToAssets(10 ** IShareLike(IERC7540Like(erc7540Target).share()).decimals()) == 0) return true;
    return _diff(IERC7540Like(erc7540Target).convertToShares(IERC7540Like(erc7540Target).totalAssets()), IShareLike(IERC7540Like(erc7540Target).share()).totalSupply()) <= MAX_ROUNDING_ERROR;
}
```

### _diff(uint256,uint256)

- **Kind**: internal
- **Source**: 3903:114:10
- **Link**: `lib/erc7540-reusable-properties/src/ERC7540Properties.sol:ERC7540Properties:_diff(uint256,uint256)`

```solidity
function _diff(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a > b) ? (a - b) : (b - a);
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## State Variable Reads

- **_actor** (`address`)
- **MAX_ROUNDING_ERROR** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.crytic_erc7540_2() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.t(bool,string) (NodeID: 2)
      💬 Args: [erc7540_2(address(superVault)), "ERC7540-2: convertToShares(totalAssets) == totalSupply failed"]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC7540Properties.erc7540_2(address) (NodeID: 4)
    │   💬 Args: [address(superVault)]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: ERC7540Properties._diff(uint256,uint256) (NodeID: 5)
    │     💬 Args: [IERC7540Like(erc7540Target).convertToShares(IERC7540Like(erc7540Target).totalAssets()), IShareLike(IERC7540Like(erc7540Target).share()).totalSupply()]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
        💬 Args: [b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property 7540-2: convertToShares(totalAssets) == totalSupply unless price is 0.0
