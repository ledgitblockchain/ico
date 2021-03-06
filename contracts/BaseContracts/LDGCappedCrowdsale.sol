pragma solidity 0.4.19;

import '../../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol';
import './LDGBaseCrowdsale.sol';

contract LDGCappedCrowdsale is LDGBaseCrowdsale {
    using SafeMath for uint256;

    uint256 public cap;

    function LDGCappedCrowdsale(uint256 _cap) public {
        require(_cap > 0);
        cap = _cap;
    }

    // Override LDGBaseCrowdsale#validPurchase to add cap logic
    // @return true if investors can buy at the moment
    function validPurchase(uint256 tokenPurchased, uint256 tierCap) internal view returns (bool) {
        bool withinTierCap = tokenRaised.add(tokenPurchased) <= tierCap;
        return super.validPurchase(tokenPurchased) && withinTierCap;
    }


    // Override LDGBaseCrowdsale#hasEnded to add cap logic
    // @return true if crowdsale event has ended
    function hasEnded() public view returns (bool) {
        bool capReached = tokenRaised >= cap;
        return super.hasEnded() || capReached;
    }
}
