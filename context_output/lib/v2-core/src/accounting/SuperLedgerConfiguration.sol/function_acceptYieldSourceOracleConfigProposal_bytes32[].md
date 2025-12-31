# Function: acceptYieldSourceOracleConfigProposal(bytes32[])

**Contract**: [lib/v2-core/src/accounting/SuperLedgerConfiguration.sol/contract_SuperLedgerConfiguration.md]

## Metadata

- **Contract**: SuperLedgerConfiguration
- **Signature**: `acceptYieldSourceOracleConfigProposal(bytes32[])`
- **Visibility**: external
- **Source Range**: 8225:2153:353

## Implementation

```solidity
/// @inheritdoc ISuperLedgerConfiguration
function acceptYieldSourceOracleConfigProposal(bytes32[] calldata yieldSourceOracleIds) virtual external {
    uint256 length = yieldSourceOracleIds.length;
    if (length == 0) revert ZERO_LENGTH();
    for (uint256 i; i < length; ++i) {
        bytes32 yieldSourceOracleId = yieldSourceOracleIds[i];
        YieldSourceOracleConfig memory proposal = yieldSourceOracleConfigProposals[yieldSourceOracleId];
        YieldSourceOracleConfig memory existingConfig = yieldSourceOracleConfig[yieldSourceOracleId];
        if (((proposal.yieldSourceOracle == address(0)) && (proposal.feeRecipient == address(0))) && (proposal.ledger == address(0))) revert CONFIG_NOT_FOUND();
        if (existingConfig.manager != msg.sender) revert NOT_MANAGER();
        proposal.manager = existingConfig.manager;
        if (yieldSourceOracleConfigProposalGracePeriod[yieldSourceOracleId] > block.timestamp) {
            revert CANNOT_ACCEPT_YET();
        }
        yieldSourceOracleConfig[yieldSourceOracleId] = proposal;
        delete yieldSourceOracleConfigProposals[yieldSourceOracleId];
        delete yieldSourceOracleConfigProposalGracePeriod[yieldSourceOracleId];
        emit YieldSourceOracleConfigAccepted(yieldSourceOracleId, proposal.yieldSourceOracle, proposal.feePercent, proposal.feeRecipient, proposal.manager, proposal.ledger);
    }
}
```

## State Variable Reads

- **yieldSourceOracleConfigProposals** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **yieldSourceOracleConfigProposalGracePeriod** (`mapping(bytes32 => uint256)`)

## State Variable Writes

- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **yieldSourceOracleConfigProposals** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **yieldSourceOracleConfigProposalGracePeriod** (`mapping(bytes32 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperLedgerConfiguration.acceptYieldSourceOracleConfigProposal(bytes32[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedgerConfiguration

### Interface Documentation

@notice Accepts previously proposed changes to yield source oracle configurations
 @dev Can only be called by the manager after the time-lock period has passed
      Accepting the proposal replaces the current configuration with the proposed one
 @param yieldSourceOracleIds Array of yield source IDs with pending proposals to accept
