# Function: test_distributeSuperPosition_InvalidProofSourceChain()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_distributeSuperPosition_InvalidProofSourceChain()`
- **Visibility**: public
- **Source Range**: 31985:1380:570

## Implementation

```solidity
function test_distributeSuperPosition_InvalidProofSourceChain() public {
    address account = address(0xaCC1000000000000000000000000000000000001);
    uint256 amount = 100 ether;
    IVaultBank.SourceAssetInfo memory sourceAsset = IVaultBank.SourceAssetInfo({asset: address(token), name: "Test Token", symbol: "TT", decimals: 18, chainId: DST_CHAIN_ID, yieldSourceOracleId: yieldSourceOracleId});
    bytes memory mockTopics = abi.encodePacked(IVaultBankSource.SharesLocked.selector, sourceAsset.yieldSourceOracleId, bytes32(uint256(uint160(account))), keccak256(abi.encodePacked(address(token))));
    uint64 invalidSourceChain = DST_CHAIN_ID + 1;
    bytes memory mockUnindexedData = abi.encode(amount, invalidSourceChain, uint64(block.chainid), uint256(0));
    bytes memory mockProof = abi.encode("mock proof data");
    mockProver.setValidateEventReturn(uint32(DST_CHAIN_ID), address(vaultBank), mockTopics, mockUnindexedData);
    vm.startPrank(governor);
    superRegistry.addRelayer(address(this));
    vm.stopPrank();
    vm.expectRevert(IVaultBank.INVALID_PROOF_SOURCE_CHAIN.selector);
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
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **governor** (`address`)
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_distributeSuperPosition_InvalidProofSourceChain() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
