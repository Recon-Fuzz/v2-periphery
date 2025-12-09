# Function: erc7540_4_mint(address,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `erc7540_4_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 5510:725:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
function erc7540_4_mint(address erc7540Target, uint256 amt) virtual public returns (bool) {
    if (amt == 0) {
        return true;
    }
    uint256 maxDep = IERC7540Like(erc7540Target).maxMint(actor);
    uint256 sum = maxDep + amt;
    if (sum == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).mint(maxDep + amt, actor) {
        return false;
    } catch {
        return true;
    }
}
```

## External Calls

- **IERC7540Like::maxMint(address)**
- **IERC7540Like::mint(uint256,address)**

## State Variable Reads

- **actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_4_mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
