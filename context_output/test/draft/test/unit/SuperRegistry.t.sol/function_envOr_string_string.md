# Function: envOr(string,string)

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `envOr(string,string)`
- **Visibility**: public
- **Source Range**: 4081:166:500
- **Inherited From**: Helpers

## Implementation

```solidity
function envOr(string memory name, string memory defaultValue) public view returns (string memory value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

## External Calls

- **Vm::envOr(string,string)**

## State Variable Reads

- **VM_ADDR** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Helpers.envOr(string,string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
