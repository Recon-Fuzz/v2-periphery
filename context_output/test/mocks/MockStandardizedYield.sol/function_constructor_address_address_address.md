# Function: constructor(address,address,address)

**Contract**: [test/mocks/MockStandardizedYield.sol/contract_MockStandardizedYield.md]

## Metadata

- **Contract**: MockStandardizedYield
- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 510:427:603

## Implementation

```solidity
constructor(address syToken_, address ptToken_, address ytToken_) {
    ptToken = ptToken_;
    syToken = syToken_;
    ytToken = ytToken_;
    assetToken = syToken;
    assetTokenType = AssetType.TOKEN;
    tokensIn.push(syToken);
    tokensIn.push(ptToken);
    tokensIn.push(ytToken);
    tokensOut.push(syToken);
    tokensOut.push(ptToken);
    tokensOut.push(ytToken);
}
```

## State Variable Reads

- **syToken** (`address`)
- **ptToken** (`address`)
- **ytToken** (`address`)

## State Variable Writes

- **ptToken** (`address`)
- **syToken** (`address`)
- **ytToken** (`address`)
- **assetToken** (`address`)
- **assetTokenType** (`enum MockStandardizedYield.AssetType`)
- **tokensIn** (`address[]`)
- **tokensOut** (`address[]`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockStandardizedYield.constructor(address,address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockStandardizedYield
```
