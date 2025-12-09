# Interface: ICrossL2ProverV2

## Metadata

- **Name**: ICrossL2ProverV2
- **Type**: Interface
- **Path**: test/draft/vendor/polymer/ICrossL2ProverV2.sol
- **Documentation**:  @title ICrossL2Prover
   @author Polymer Labs
   @notice A contract that can prove peptides state. Since peptide is an aggregator of many chains' states, this
   contract can in turn be used to prove any arbitrary events and/or storage on counterparty chains.

## Public/External Functions

### validateEvent(bytes)

- **Signature**: `validateEvent(bytes)`
- **Visibility**: external
- **Source Range**: 1738:187:574

**Signature:**
```solidity
///  @notice A a log at a given raw rlp encoded receipt at a given logIndex within the receipt.
///  @notice the receiptRLP should first be validated by calling validateReceipt.
///  @param proof: The proof of a given rlp bytes for the receipt, returned from the receipt MMPT of a block.
///  @return chainId The chainID that the proof proves the log for
///  @return emittingContract The address of the contract that emitted the log on the source chain
///  @return topics The topics of the event. First topic is the event signature that can be calculated by
///  Event.selector. The remaining elements in this array are the indexed parameters of the event.
///  @return unindexedData // The abi encoded non-indexed parameters of the event.
function validateEvent(bytes calldata proof) external view returns (uint32 chainId, address emittingContract, bytes calldata topics, bytes calldata unindexedData);;
```

### inspectLogIdentifier(bytes)

- **Signature**: `inspectLogIdentifier(bytes)`
- **Visibility**: external
- **Source Range**: 2038:173:574

**Signature:**
```solidity
///  Return srcChain, Block Number, Receipt Index, and Local Index for a requested proof
function inspectLogIdentifier(bytes calldata proof) external pure returns (uint32 srcChain, uint64 blockNumber, uint16 receiptIndex, uint8 logIndex);;
```

### inspectPolymerState(bytes)

- **Signature**: `inspectPolymerState(bytes)`
- **Visibility**: external
- **Source Range**: 2398:156:574

**Signature:**
```solidity
///  Return polymer state root, height , and signature over height and root which can be verified by
///  crypto.pubkey(keccak(peptideStateRoot, peptideHeight))
function inspectPolymerState(bytes calldata proof) external pure returns (bytes32 stateRoot, uint64 height, bytes memory signature);;
```
