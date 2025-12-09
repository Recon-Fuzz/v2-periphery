# Function: getTokensIn()

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `getTokensIn()`
- **Visibility**: public
- **Source Range**: 1665:102:639
- **Inherited From**: ERC5115

## Implementation

```solidity
function getTokensIn() virtual public view returns (address[] memory) {
    return tokensIn;
}
```

## State Variable Reads

- **tokensIn** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115.getTokensIn() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
