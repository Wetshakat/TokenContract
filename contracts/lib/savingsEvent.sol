// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

library savingsEvents {
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function emitDeposit(address user, uint256 amount) internal {
        emit Deposited(user, amount);
    }

    function emitWithdraw(address user, uint256 amount) internal {
        emit Withdrawn(user, amount);
    }
}
