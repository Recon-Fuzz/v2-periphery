# Function: constructor(address,address[])

**Contract**: [lib/v2-core/test/mocks/ERC5115Ledger.sol/contract_ERC5115Ledger.md]

## Metadata

- **Contract**: ERC5115Ledger
- **Signature**: `constructor(address,address[])`
- **Visibility**: public
- **Source Range**: 885:167:481

## Implementation

```solidity
/// @notice Initializes the ERC5115Ledger with configuration and executor permissions
///  @param ledgerConfiguration_ Address of the SuperLedgerConfiguration contract
///  @param allowedExecutors_ Array of addresses authorized to execute accounting operations
constructor(address ledgerConfiguration_, address[] memory allowedExecutors_) BaseLedger(ledgerConfiguration_,allowedExecutors_) {}
```

## Related Implementations

### (address,address[])

- **Kind**: internal
- **Source**: 2475:426:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:constructor(address,address[])`

```solidity
/// @notice Constructs the BaseLedger with configuration and authorized executors
///  @dev Initializes the ledger with configuration and a list of allowed executors
///  @param superLedgerConfiguration_ Address of the ledger configuration contract
///  @param allowedExecutors_ Array of addresses authorized to execute accounting updates
constructor(address superLedgerConfiguration_, address[] memory allowedExecutors_) {
    if (superLedgerConfiguration_ == address(0)) revert ZERO_ADDRESS_NOT_ALLOWED();
    SUPER_LEDGER_CONFIGURATION = ISuperLedgerConfiguration(superLedgerConfiguration_);
    uint256 len = allowedExecutors_.length;
    for (uint256 i; i < len; ++i) {
        allowedExecutors[allowedExecutors_[i]] = true;
    }
}
```

## State Variable Writes

- **SUPER_LEDGER_CONFIGURATION** (`contract ISuperLedgerConfiguration`) [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]
- **allowedExecutors** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: ERC5115Ledger.constructor(address,address[]) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: ERC5115Ledger
  └─ [1] 🏗️ CONSTRUCTOR: BaseLedger.constructor(address,address[]) (NodeID: 1)
      💬 Args: [ledgerConfiguration_, allowedExecutors_]
      🏗️  Contract: BaseLedger
```

## Documentation

### Function Documentation

@notice Initializes the ERC5115Ledger with configuration and executor permissions
 @param ledgerConfiguration_ Address of the SuperLedgerConfiguration contract
 @param allowedExecutors_ Array of addresses authorized to execute accounting operations
