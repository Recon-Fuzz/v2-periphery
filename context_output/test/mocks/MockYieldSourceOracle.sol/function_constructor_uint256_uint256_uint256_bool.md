# Function: constructor(uint256,uint256,uint256,bool)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `constructor(uint256,uint256,uint256,bool)`
- **Visibility**: public
- **Source Range**: 451:218:607

## Implementation

```solidity
constructor(uint256 _pricePerShare, uint256 _tvl, uint256 _tvlByOwner, bool _validity) {
    pricePerShare = _pricePerShare;
    tvl = _tvl;
    tvlByOwner = _tvlByOwner;
    validity = _validity;
}
```

## State Variable Writes

- **pricePerShare** (`uint256`)
- **tvl** (`uint256`)
- **tvlByOwner** (`uint256`)
- **validity** (`bool`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockYieldSourceOracle.constructor(uint256,uint256,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockYieldSourceOracle
```
