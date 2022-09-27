### 버전

---

- Solidity version : 0.8.11
- Node verison : 16.14.2(using nvm)

<br/><br/>



### 참고할 수 있는 외부 코드

---

**UniswapV2LiquidityMathLibrary.sol**

`getLiquidityValue` : LP 계산하여 반환하는 함수

```solidity
// computes liquidity value given all the parameters of the pair
function computeLiquidityValue(
    uint256 reservesA,
    uint256 reservesB,
    uint256 totalSupply,
    uint256 liquidityAmount,
    bool feeOn,
    uint256 kLast
) internal pure returns (uint256 tokenAAmount, uint256 tokenBAmount) {
    if (feeOn && kLast > 0) {
        uint256 rootK = Babylonian.sqrt(reservesA.mul(reservesB));
        uint256 rootKLast = Babylonian.sqrt(kLast);
        if (rootK > rootKLast) {
            uint256 numerator1 = totalSupply;
            uint256 numerator2 = rootK.sub(rootKLast);
            uint256 denominator = rootK.mul(5).add(rootKLast);
            uint256 feeLiquidity = FullMath.mulDiv(numerator1, numerator2, denominator);
            totalSupply = totalSupply.add(feeLiquidity);
        }
    }
    return (reservesA.mul(liquidityAmount) / totalSupply, reservesB.mul(liquidityAmount) / totalSupply);
}

// get all current parameters from the pair and compute value of a liquidity amount
// **note this is subject to manipulation, e.g. sandwich attacks**. prefer passing a manipulation resistant price to
// #getLiquidityValueAfterArbitrageToPrice
function getLiquidityValue(
    address factory,
    address tokenA,
    address tokenB,
    uint256 liquidityAmount
) internal view returns (uint256 tokenAAmount, uint256 tokenBAmount) {
    (uint256 reservesA, uint256 reservesB) = MBXSwapLibrary.getReserves(factory, tokenA, tokenB);
    IMBXSwapPair pair = IMBXSwapPair(MBXSwapLibrary.pairFor(factory, tokenA, tokenB));
    bool feeOn = IMBXSwapFactory(factory).feeTo() != address(0);
    uint256 kLast = feeOn ? pair.kLast() : 0;
    uint256 totalSupply = pair.totalSupply();
    return computeLiquidityValue(reservesA, reservesB, totalSupply, liquidityAmount, feeOn, kLast);
}
```
