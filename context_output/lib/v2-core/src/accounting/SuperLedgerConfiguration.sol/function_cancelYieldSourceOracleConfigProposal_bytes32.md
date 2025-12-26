# Function: cancelYieldSourceOracleConfigProposal(bytes32)

**Contract**: [lib/v2-core/src/accounting/SuperLedgerConfiguration.sol/contract_SuperLedgerConfiguration.md]

## Metadata

- **Contract**: SuperLedgerConfiguration
- **Signature**: `cancelYieldSourceOracleConfigProposal(bytes32)`
- **Visibility**: external
- **Source Range**: 7039:1134:353

## Implementation

```solidity
/// @notice Cancels a pending yield source oracle configuration proposal.
///  @param yieldSourceOracleId The identifier of the yield source oracle.
///  @dev Only the current manager can call this function.
function cancelYieldSourceOracleConfigProposal(bytes32 yieldSourceOracleId) virtual external {
    if (yieldSourceOracleConfig[yieldSourceOracleId].manager != msg.sender) {
        revert NOT_MANAGER();
    }
    if (yieldSourceOracleConfigProposalGracePeriod[yieldSourceOracleId] == 0) {
        revert NO_PENDING_PROPOSAL();
    }
    YieldSourceOracleConfig memory proposal = yieldSourceOracleConfigProposals[yieldSourceOracleId];
    delete yieldSourceOracleConfigProposals[yieldSourceOracleId];
    delete yieldSourceOracleConfigProposalGracePeriod[yieldSourceOracleId];
    emit YieldSourceOracleConfigProposalCancelled(yieldSourceOracleId, proposal.yieldSourceOracle, proposal.feePercent, proposal.feeRecipient, proposal.manager, proposal.ledger);
}
```

## State Variable Reads

- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **yieldSourceOracleConfigProposalGracePeriod** (`mapping(bytes32 => uint256)`)
- **yieldSourceOracleConfigProposals** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)

## State Variable Writes

- **yieldSourceOracleConfigProposals** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **yieldSourceOracleConfigProposalGracePeriod** (`mapping(bytes32 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperLedgerConfiguration.cancelYieldSourceOracleConfigProposal(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Cancels a pending yield source oracle configuration proposal.
 @param yieldSourceOracleId The identifier of the yield source oracle.
 @dev Only the current manager can call this function.
