# Function: setRevertBehavior(enum RevertType)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `setRevertBehavior(enum RevertType)`
- **Visibility**: public
- **Source Range**: 4963:86:639

## Implementation

```solidity
function setRevertBehavior(RevertType rt) public {
    revertBehaviour = rt;
}
```

## State Variable Writes

- **revertBehaviour** (`enum RevertType`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115Tester.setRevertBehavior(enum RevertType) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
