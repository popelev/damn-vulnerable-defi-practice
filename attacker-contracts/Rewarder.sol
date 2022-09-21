// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../side-entrance/SideEntranceLenderPool.sol";

contract RewarderAttack {
    using Address for address payable;
    address pool;

    constructor(address _pool) {
        pool = _pool;
    }

    function attack() external {}

    function withdraw() external {}

    receive() external payable {}
}
