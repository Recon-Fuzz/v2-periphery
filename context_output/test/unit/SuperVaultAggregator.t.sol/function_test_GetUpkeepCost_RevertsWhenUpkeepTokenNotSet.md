# Function: test_GetUpkeepCost_RevertsWhenUpkeepTokenNotSet()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetUpkeepCost_RevertsWhenUpkeepTokenNotSet()`
- **Visibility**: public
- **Source Range**: 112113:1540:661

## Implementation

```solidity
/// @notice Tests that getUpkeepCostPerSingleUpdate reverts when UPKEEP_TOKEN address is not set
function test_GetUpkeepCost_RevertsWhenUpkeepTokenNotSet() public {
    address freshSGovernor = makeAddr("FreshSuperGovernor");
    address freshGovernor = makeAddr("FreshGovernor");
    address freshTreasury = makeAddr("FreshTreasury");
    address freshOracleManager = makeAddr("FreshOracleManager");
    SuperGovernor freshSuperGovernor = SuperGovernor(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(freshSGovernor, freshGovernor, freshGovernor, freshOracleManager, freshGovernor, freshGovernor, freshTreasury, false))})));
    bytes32 superOracleKey = freshSuperGovernor.SUPER_ORACLE();
    vm.prank(freshSGovernor);
    freshSuperGovernor.setAddress(superOracleKey, superOracle);
    vm.prank(freshGovernor);
    freshSuperGovernor.setGasInfo(address(this), 100_000);
    vm.expectRevert(ISuperGovernor.UPKEEP_TOKEN_NOT_FOUND.selector);
    freshSuperGovernor.getUpkeepCostPerSingleUpdate(address(this));
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

- **VmContractHelper703::deployCode(string,bytes)**
- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::setGasInfo(address,uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::getUpkeepCostPerSingleUpdate(address)**

## State Variable Reads

- **superOracle** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetUpkeepCost_RevertsWhenUpkeepTokenNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["FreshSuperGovernor"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
  │   💬 Args: ["FreshGovernor"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 5)
  │   💬 Args: ["FreshTreasury"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 6)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 7)
      💬 Args: ["FreshOracleManager"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 8)
        💬 Args: [name]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that getUpkeepCostPerSingleUpdate reverts when UPKEEP_TOKEN address is not set
