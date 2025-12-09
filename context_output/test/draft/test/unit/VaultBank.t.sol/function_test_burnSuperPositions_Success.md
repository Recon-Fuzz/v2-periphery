# Function: test_burnSuperPositions_Success()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_burnSuperPositions_Success()`
- **Visibility**: public
- **Source Range**: 42532:1500:570

## Implementation

```solidity
function test_burnSuperPositions_Success() public {
    address validSP = address(0x1234);
    address underlyingToken = address(0x5678);
    uint256 userBalance = 10e18;
    uint256 burnAmount = 5e18;
    uint64 forChainId = 1;
    vm.etch(validSP, new bytes(0x1000));
    vaultBank.exposed_markAsSyntheticAsset(validSP);
    vaultBank.exposed_setSuperPositionToToken(validSP, forChainId, underlyingToken, yieldSourceOracleId);
    vaultBank.exposed_setTokenToSuperPosition(forChainId, underlyingToken, validSP, yieldSourceOracleId);
    vm.mockCall(validSP, abi.encodeWithSignature("balanceOf(address)", address(this)), abi.encode(userBalance));
    vm.mockCall(validSP, abi.encodeWithSignature("burn(address,uint256)", address(this), burnAmount), abi.encode());
    bytes32 nonceSlot = keccak256(abi.encode(address(this), uint256(forChainId), uint256(0)));
    vm.store(address(vaultBank), nonceSlot, bytes32(uint256(0)));
    vm.expectEmit(true, true, true, true, address(vaultBank));
    emit IVaultBank.SuperpositionsBurned(address(this), validSP, underlyingToken, burnAmount, forChainId, 0);
    vaultBank.burnSuperPosition(burnAmount, validSP, forChainId, yieldSourceOracleId);
    assertEq(vaultBank.nonces(forChainId), 1, "Nonce should be incremented");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::etch(address,bytes)**
- **TestVaultBank::exposed_markAsSyntheticAsset(address)**
- **TestVaultBank::exposed_setSuperPositionToToken(address,uint64,address,bytes32)**
- **TestVaultBank::exposed_setTokenToSuperPosition(uint64,address,address,bytes32)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::store(address,bytes32,bytes32)**
- **Vm::expectEmit(bool,bool,bool,bool,address)**
- **TestVaultBank::burnSuperPosition(uint256,address,uint64,bytes32)**
- **TestVaultBank::nonces(uint64)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_burnSuperPositions_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [vaultBank.nonces(forChainId), 1, "Nonce should be incremented"]
      👁️  Def: internal
```
