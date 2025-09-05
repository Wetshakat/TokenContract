// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import { IERC20 } from "./interfaces/IERC20.sol";
import { IMySaving } from "./interfaces/IMySaving.sol";
import { savingsEvents } from "./lib/savingsEvent.sol";

contract savingsContract is IMySaving {
    IERC20 public immutable token;

    mapping(address => uint256) private balances;
    uint256 public totalDeposits;

    constructor(address tokenAddress) {
        require(tokenAddress != address(0), "token=0");
        token = IERC20(tokenAddress);
    }

    function deposit(uint256 amount) external override {
        address owner = msg.sender;
        require(amount > 0, "amount=0");
        require(token.allowance(owner, address(this)) >= amount, "allowance low");

        bool success = token.transferFrom(owner, address(this), amount);
        require(success, "transferFrom failed");

        balances[owner] += amount;
        totalDeposits += amount;

        savingsEvents.emitDeposit(owner, amount);
    }

    function withdraw(uint256 amount) external override {
        address owner = msg.sender;
        require(amount > 0, "amount=0");
        uint256 bal = balances[owner];
        require(bal >= amount, "insufficient balance");

        balances[owner] = bal - amount;
        totalDeposits -= amount;

        bool success = token.transfer(owner, amount);
        require(success, "transfer failed");

        savingsEvents.emitWithdraw(owner, amount);
    }

    function save(address user) external view override returns (uint256) {
        return balances[user];
    }

    function savingBalance(address user) external view override returns (uint256) {
        return balances[user];
    }
}
