# Function: test_Initialize_Success()

**Contract**: [test/unit/SuperVaultEscrow.t.sol/contract_SuperVaultEscrowTest.md]

## Metadata

- **Contract**: SuperVaultEscrowTest
- **Signature**: `test_Initialize_Success()`
- **Visibility**: public
- **Source Range**: 1813:587:662

## Implementation

```solidity
/// @notice Tests successful initialization
function test_Initialize_Success() public {
    assertFalse(escrow.initialized(), "Should not be initialized initially");
    assertEq(escrow.vault(), address(0), "Vault should be zero initially");
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultEscrow.Initialized(vault);
    escrow.initialize(vault);
    assertTrue(escrow.initialized(), "Should be initialized");
    assertEq(escrow.vault(), vault, "Vault should be set");
}
```

## Related Implementations

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

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
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

## External Calls

- **SuperVaultEscrow::initialized()**
- **SuperVaultEscrow::vault()**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultEscrow::initialize(address)**

## State Variable Reads

- **escrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **vault** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTest.test_Initialize_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [escrow.initialized(), "Should not be initialized initially"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
  │   💬 Args: [escrow.vault(), address(0), "Vault should be zero initially"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [escrow.initialized(), "Should be initialized"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
      💬 Args: [escrow.vault(), vault, "Vault should be set"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests successful initialization
