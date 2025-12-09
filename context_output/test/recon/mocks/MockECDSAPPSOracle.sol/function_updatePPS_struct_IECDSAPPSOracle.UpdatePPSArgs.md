# Function: updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)

**Contract**: [test/recon/mocks/MockECDSAPPSOracle.sol/contract_MockECDSAPPSOracle.md]

## Metadata

- **Contract**: MockECDSAPPSOracle
- **Signature**: `updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)`
- **Visibility**: public
- **Source Range**: 669:389:636

## Implementation

```solidity
function updatePPS(IECDSAPPSOracle.UpdatePPSArgs memory args) public {
    ISuperVaultAggregator.ForwardPPSArgs memory forwardArgs = ISuperVaultAggregator.ForwardPPSArgs({strategies: args.strategies, ppss: args.ppss, timestamps: args.timestamps, updateAuthority: msg.sender});
    ISuperVaultAggregator(_SUPER_GOVERNORReturn_0).forwardPPS(forwardArgs);
}
```

## External Calls

- **ISuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**

## State Variable Reads

- **_SUPER_GOVERNORReturn_0** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockECDSAPPSOracle.updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
