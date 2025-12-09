# Function: test_IsGuardian()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_IsGuardian()`
- **Visibility**: public
- **Source Range**: 20813:333:659

## Implementation

```solidity
function test_IsGuardian() public view {
    assertTrue(superGovernor.isGuardian(guardian), "Guardian should be a guardian");
    assertFalse(superGovernor.isGuardian(governor), "Governor should not be a guardian");
    assertFalse(superGovernor.isGuardian(address(this)), "This contract should not be a guardian");
}
```

## Related Implementations

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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

## External Calls

- **SuperGovernor::isGuardian(address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **guardian** (`address`)
- **governor** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_IsGuardian() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.isGuardian(guardian), "Guardian should be a guardian"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.isGuardian(governor), "Governor should not be a guardian"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
      💬 Args: [superGovernor.isGuardian(address(this)), "This contract should not be a guardian"]
      👁️  Def: internal
```
