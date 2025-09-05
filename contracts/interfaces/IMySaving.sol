// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IMySaving {
    function deposit(uint256 amount) external;
    function withdraw(uint256 amount) external;
    function save(address user) external view returns (uint256);
    function savingBalance(address user) external view returns (uint256);
}
