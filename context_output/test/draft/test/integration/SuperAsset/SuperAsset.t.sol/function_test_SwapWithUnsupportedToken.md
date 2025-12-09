# Function: test_SwapWithUnsupportedToken()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_SwapWithUnsupportedToken()`
- **Visibility**: public
- **Source Range**: 46295:534:565

## Implementation

```solidity
function test_SwapWithUnsupportedToken() public {
    address unsupportedToken = makeAddr("unsupportedToken");
    vm.startPrank(user);
    vm.expectRevert(ISuperAsset.NOT_SUPPORTED_TOKEN.selector);
    ISuperAsset.SwapArgs memory swapArgs = ISuperAsset.SwapArgs({receiver: user, tokenIn: unsupportedToken, amountTokenToDeposit: 100e18, tokenOut: address(tokenOut), minTokenOut: 0});
    superAsset.swap(swapArgs);
    vm.stopPrank();
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

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::swap(struct ISuperAsset.SwapArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **tokenOut** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_SwapWithUnsupportedToken() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
      💬 Args: ["unsupportedToken"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
        💬 Args: [name]
        👁️  Def: internal
```
