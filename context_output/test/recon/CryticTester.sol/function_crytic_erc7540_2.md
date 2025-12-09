# Function: crytic_erc7540_2()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
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
- **Source**: 1096:159:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:t(bool,string)`

```solidity
function t(bool b, string memory reason) virtual override internal {
    if (!b) {
        emit Log(reason);
        assert(false);
    }
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

## State Variable Reads

- **_actor** (`address`)
- **MAX_ROUNDING_ERROR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.crytic_erc7540_2() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CryticAsserts.t(bool,string) (NodeID: 2)
      💬 Args: [erc7540_2(address(superVault)), "ERC7540-2: convertToShares(totalAssets) == totalSupply failed"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC7540Properties.erc7540_2(address) (NodeID: 3)
        💬 Args: [address(superVault)]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: ERC7540Properties._diff(uint256,uint256) (NodeID: 4)
          💬 Args: [IERC7540Like(erc7540Target).convertToShares(IERC7540Like(erc7540Target).totalAssets()), IShareLike(IERC7540Like(erc7540Target).share()).totalSupply()]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property 7540-2: convertToShares(totalAssets) == totalSupply unless price is 0.0
