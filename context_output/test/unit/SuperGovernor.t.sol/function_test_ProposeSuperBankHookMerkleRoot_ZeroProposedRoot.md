# Function: test_ProposeSuperBankHookMerkleRoot_ZeroProposedRoot()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ProposeSuperBankHookMerkleRoot_ZeroProposedRoot()`
- **Visibility**: public
- **Source Range**: 132110:451:659

## Implementation

```solidity
/// @notice Tests proposeSuperBankHookMerkleRoot reverts when proposed root is zero
///  @dev Covers SuperGovernor.sol:603 - if (proposedRoot == bytes32(0)) revert ZERO_PROPOSED_MERKLE_ROOT()
function test_ProposeSuperBankHookMerkleRoot_ZeroProposedRoot() public {
    address testHook = makeAddr("testHook");
    vm.prank(governor);
    superGovernor.registerHook(testHook);
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.ZERO_PROPOSED_MERKLE_ROOT.selector);
    superGovernor.proposeSuperBankHookMerkleRoot(testHook, bytes32(0));
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

- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::proposeSuperBankHookMerkleRoot(address,bytes32)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ProposeSuperBankHookMerkleRoot_ZeroProposedRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
      💬 Args: ["testHook"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
        💬 Args: [name]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests proposeSuperBankHookMerkleRoot reverts when proposed root is zero
 @dev Covers SuperGovernor.sol:603 - if (proposedRoot == bytes32(0)) revert ZERO_PROPOSED_MERKLE_ROOT()
