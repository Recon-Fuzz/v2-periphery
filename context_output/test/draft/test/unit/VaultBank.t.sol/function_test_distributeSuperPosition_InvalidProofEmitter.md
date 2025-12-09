# Function: test_distributeSuperPosition_InvalidProofEmitter()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_distributeSuperPosition_InvalidProofEmitter()`
- **Visibility**: public
- **Source Range**: 24410:1356:570

## Implementation

```solidity
function test_distributeSuperPosition_InvalidProofEmitter() public {
    address account = address(0xaCC1000000000000000000000000000000000001);
    uint256 amount = 100 ether;
    IVaultBank.SourceAssetInfo memory sourceAsset = IVaultBank.SourceAssetInfo({asset: address(token), name: "Test Token", symbol: "TT", decimals: 18, chainId: DST_CHAIN_ID, yieldSourceOracleId: yieldSourceOracleId});
    bytes memory mockTopics = abi.encodePacked(IVaultBankSource.SharesLocked.selector, sourceAsset.yieldSourceOracleId, bytes32(uint256(uint160(account))), keccak256(abi.encodePacked(address(token))));
    bytes memory mockUnindexedData = abi.encode(amount, DST_CHAIN_ID, uint64(block.chainid), uint256(0));
    bytes memory mockProof = abi.encode("mock proof data");
    address invalidEmitter = address(0x123);
    mockProver.setValidateEventReturn(uint32(DST_CHAIN_ID), invalidEmitter, mockTopics, mockUnindexedData);
    vm.startPrank(governor);
    superRegistry.addRelayer(address(this));
    vm.stopPrank();
    vm.expectRevert(IVaultBank.INVALID_PROOF_EMITTER.selector);
    vaultBank.distributeSuperPosition(account, amount, sourceAsset, mockProof);
}
```

## External Calls

- **MockCrossL2ProverV2::setValidateEventReturn(uint32,address,bytes,bytes)**
- **Vm::startPrank(address)**
- **SuperRegistry::addRelayer(address)**
- **Vm::stopPrank()**
- **Vm::expectRevert(bytes4)**
- **TestVaultBank::distributeSuperPosition(address,uint256,struct IVaultBank.SourceAssetInfo,bytes)**

## State Variable Reads

- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **DST_CHAIN_ID** (`uint64`)
- **yieldSourceOracleId** (`bytes32`)
- **mockProver** (`contract MockCrossL2ProverV2`) [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]
- **governor** (`address`)
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_distributeSuperPosition_InvalidProofEmitter() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
