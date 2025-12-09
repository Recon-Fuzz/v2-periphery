# Function: envOr(string,bool)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `envOr(string,bool)`
- **Visibility**: public
- **Source Range**: 4355:148:500
- **Inherited From**: Helpers

## Implementation

```solidity
function envOr(string memory name, bool defaultValue) public view returns (bool value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

## External Calls

- **Vm::envOr(string,bool)**

## State Variable Reads

- **VM_ADDR** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
