// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

library Events {
    event Transfer(address indexed sender, address indexed recipient, uint256 amount);
    event Approve(address indexed owner, address indexed spender, uint256 amount);
    event TransferFrom(address indexed owner, address indexed spender, uint256 amount);
}
