# Function: test_distributeSuperPosition_Success_ExistingTokenToSuperposition()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_distributeSuperPosition_Success_ExistingTokenToSuperposition()`
- **Visibility**: public
- **Source Range**: 39073:2075:570

## Implementation

```solidity
function test_distributeSuperPosition_Success_ExistingTokenToSuperposition() public {
    address account = address(0xAcc3);
    uint256 amount = 75 ether;
    IVaultBank.SourceAssetInfo memory sourceAsset = IVaultBank.SourceAssetInfo({asset: address(token), name: "Test Token", symbol: "TT", decimals: 18, chainId: DST_CHAIN_ID, yieldSourceOracleId: yieldSourceOracleId});
    bytes memory mockTopics = abi.encodePacked(IVaultBankSource.SharesLocked.selector, sourceAsset.yieldSourceOracleId, bytes32(uint256(uint160(account))), keccak256(abi.encodePacked(address(token))));
    bytes memory mockUnindexedData = abi.encode(amount, DST_CHAIN_ID, uint64(block.chainid), uint256(0));
    bytes memory mockProof = abi.encode("mock proof data");
    mockProver.setValidateEventReturn(uint32(DST_CHAIN_ID), address(vaultBank), mockTopics, mockUnindexedData);
    address existingSPAddress = address(0xe5000000000000000000000000000000000000e5);
    vm.mockCall(address(vaultBank), abi.encodeWithSignature("_retrieveSuperPosition(uint64,address,string,string,uint8)", DST_CHAIN_ID, address(token), "Test Token", "TT", 18), abi.encode(existingSPAddress));
    vm.mockCall(address(vaultBank), abi.encodeWithSignature("_mintSP(address,address,uint256)", account, existingSPAddress, amount), abi.encode());
    vm.startPrank(governor);
    superRegistry.addRelayer(address(this));
    vm.stopPrank();
    vaultBank.distributeSuperPosition(account, amount, sourceAsset, mockProof);
    assertEq(vaultBank.nonces(uint64(block.chainid)), 1, "Nonce should be incremented");
    assertTrue(vaultBank.noncesUsed(DST_CHAIN_ID, 0), "Proof nonce should be marked as used");
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

- **MockCrossL2ProverV2::setValidateEventReturn(uint32,address,bytes,bytes)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::startPrank(address)**
- **SuperRegistry::addRelayer(address)**
- **Vm::stopPrank()**
- **TestVaultBank::distributeSuperPosition(address,uint256,struct IVaultBank.SourceAssetInfo,bytes)**
- **TestVaultBank::nonces(uint64)**
- **TestVaultBank::noncesUsed(uint64,int_const 0)**

## State Variable Reads

- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **DST_CHAIN_ID** (`uint64`)
- **yieldSourceOracleId** (`bytes32`)
- **mockProver** (`contract MockCrossL2ProverV2`) [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **governor** (`address`)
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_distributeSuperPosition_Success_ExistingTokenToSuperposition() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [vaultBank.nonces(uint64(block.chainid)), 1, "Nonce should be incremented"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [vaultBank.noncesUsed(DST_CHAIN_ID, 0), "Proof nonce should be marked as used"]
      👁️  Def: internal
```
