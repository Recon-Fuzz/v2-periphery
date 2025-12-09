# Function: test_MerkleRoot_Revert_NotApproved()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MerkleRoot_Revert_NotApproved()`
- **Visibility**: public
- **Source Range**: 89893:399:659

## Implementation

```solidity
function test_MerkleRoot_Revert_NotApproved() public {
    address unapprovedHook = makeAddr("unapprovedHook");
    vm.expectRevert(ISuperGovernor.HOOK_NOT_APPROVED.selector);
    superGovernor.getSuperBankHookMerkleRoot(unapprovedHook);
    vm.expectRevert(ISuperGovernor.HOOK_NOT_APPROVED.selector);
    superGovernor.getProposedSuperBankHookMerkleRoot(unapprovedHook);
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

- **Vm::expectRevert(bytes4)**
- **SuperGovernor::getSuperBankHookMerkleRoot(address)**
- **SuperGovernor::getProposedSuperBankHookMerkleRoot(address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MerkleRoot_Revert_NotApproved() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
      💬 Args: ["unapprovedHook"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
        💬 Args: [name]
        👁️  Def: internal
```
