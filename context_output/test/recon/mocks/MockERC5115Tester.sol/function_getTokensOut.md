# Function: getTokensOut()

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `getTokensOut()`
- **Visibility**: public
- **Source Range**: 1773:104:639
- **Inherited From**: ERC5115

## Implementation

```solidity
function getTokensOut() virtual public view returns (address[] memory) {
    return tokensOut;
}
```

## State Variable Reads

- **tokensOut** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115.getTokensOut() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
