# Function: domainSeparator()

**Contract**: [test/recon/mocks/MockECDSAPPSOracle.sol/contract_MockECDSAPPSOracle.md]

## Metadata

- **Contract**: MockECDSAPPSOracle
- **Signature**: `domainSeparator()`
- **Visibility**: public
- **Source Range**: 5426:105:636

## Implementation

```solidity
function domainSeparator() public view returns (bytes32) {
    return _domainSeparatorReturn_0;
}
```

## State Variable Reads

- **_domainSeparatorReturn_0** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockECDSAPPSOracle.domainSeparator() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
