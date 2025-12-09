# Function: test_OnlyVaultManagerCanWhitelistTokens()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_OnlyVaultManagerCanWhitelistTokens()`
- **Visibility**: public
- **Source Range**: 19322:611:565

## Implementation

```solidity
function test_OnlyVaultManagerCanWhitelistTokens() public {
    address newToken = makeAddr("newToken");
    vm.startPrank(user);
    vm.expectRevert(ISuperAsset.UNAUTHORIZED.selector);
    superAsset.whitelistERC20(newToken);
    vm.stopPrank();
    vm.startPrank(admin);
    superAsset.whitelistERC20(newToken);
    vm.stopPrank();
    ISuperAsset.TokenData memory tokenData = superAsset.getTokenData(newToken);
    assertTrue(tokenData.isSupportedERC20);
}
```

## Related Implementations

### makeAddr(string)

- **Kind**: internal
- **Source**: 20760:125:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20479:242:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
}
```

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1764:124:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    if (!data) {
        vm.assertTrue(data);
    }
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::whitelistERC20(address)**
- **Vm::stopPrank()**
- **SuperAsset::getTokenData(address)**

## State Variable Reads

- **user** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **admin** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_OnlyVaultManagerCanWhitelistTokens() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["newToken"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 3)
      💬 Args: [tokenData.isSupportedERC20]
      👁️  Def: internal
```
