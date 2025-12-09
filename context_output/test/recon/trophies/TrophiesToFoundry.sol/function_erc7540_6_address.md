# Function: erc7540_6(address)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `erc7540_6(address)`
- **Visibility**: public
- **Source Range**: 8627:553:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
/// @dev 7540-6	preview* always reverts
function erc7540_6(address erc7540Target) virtual public returns (bool) {
    try IERC7540Like(erc7540Target).previewDeposit(0) {
        return false;
    } catch {}
    try IERC7540Like(erc7540Target).previewMint(0) {
        return false;
    } catch {}
    try IERC7540Like(erc7540Target).previewRedeem(0) {
        return false;
    } catch {}
    try IERC7540Like(erc7540Target).previewWithdraw(0) {
        return false;
    } catch {}
    return true;
}
```

## External Calls

- **IERC7540Like::previewDeposit(uint256)**
- **IERC7540Like::previewMint(uint256)**
- **IERC7540Like::previewRedeem(uint256)**
- **IERC7540Like::previewWithdraw(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_6(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev 7540-6	preview* always reverts
