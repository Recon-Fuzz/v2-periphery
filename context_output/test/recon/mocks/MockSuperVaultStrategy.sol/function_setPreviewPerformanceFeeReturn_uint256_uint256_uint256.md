# Function: setPreviewPerformanceFeeReturn(uint256,uint256,uint256)

**Contract**: [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]

## Metadata

- **Contract**: MockSuperVaultStrategy
- **Signature**: `setPreviewPerformanceFeeReturn(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5983:255:645

## Implementation

```solidity
function setPreviewPerformanceFeeReturn(uint256 _value0, uint256 _value1, uint256 _value2) public {
    _previewPerformanceFeeReturn_0 = _value0;
    _previewPerformanceFeeReturn_1 = _value1;
    _previewPerformanceFeeReturn_2 = _value2;
}
```

## State Variable Writes

- **_previewPerformanceFeeReturn_0** (`uint256`)
- **_previewPerformanceFeeReturn_1** (`uint256`)
- **_previewPerformanceFeeReturn_2** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultStrategy.setPreviewPerformanceFeeReturn(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
