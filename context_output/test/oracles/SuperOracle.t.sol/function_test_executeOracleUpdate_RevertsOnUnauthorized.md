# Function: test_executeOracleUpdate_RevertsOnUnauthorized()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_executeOracleUpdate_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 38986:921:624

## Implementation

```solidity
function test_executeOracleUpdate_RevertsOnUnauthorized() public {
    address[] memory bases = new address[](1);
    bases[0] = address(mockBTC);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = PROVIDER_1;
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed4);
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp((block.timestamp + 1 weeks) + 1 seconds);
    mockFeed4.setUpdatedAt(block.timestamp);
    vm.prank(makeAddr("nonGovernor"));
    vm.expectRevert(ISuperOracle.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superOracle.executeOracleUpdate();
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

- **SuperOracle::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperOracle::executeOracleUpdate()**

## State Variable Reads

- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_executeOracleUpdate_RevertsOnUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
      💬 Args: ["nonGovernor"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
        💬 Args: [name]
        👁️  Def: internal
```
