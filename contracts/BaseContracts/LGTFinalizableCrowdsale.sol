/// @file LGT Finalizable Crowdsale Contract
/// @notice LGT Finalizable Crowdsale Contract is based on Open Zeppelin
//// and extend LGT Base Crowdsale
pragma solidity 0.4.19;

import '../../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol';
import '../../node_modules/zeppelin-solidity/contracts/ownership/Claimable.sol';
import './LGTBaseCrowdsale.sol';

contract LGTFinalizableCrowdsale is LGTBaseCrowdsale, Claimable {
    using SafeMath for uint256;

    bool public isFinalized = false;

    event Closed();
    event Finalized();

    function LGTFinalizableCrowdsale() {
    }

    function finalize() onlyOwner public {
        require(!isFinalized);
        require(hasEnded());

        finalization();
        Finalized();

        isFinalized = true;
    }

    function close() onlyOwner internal {
        Closed();
        wallet.transfer(this.balance);
    }

    function finalization() internal {
        close();
    }
}
