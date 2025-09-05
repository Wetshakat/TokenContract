// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import { IERC20 } from "./interfaces/IERC20.sol";
import { Events } from "./lib/events.sol";

contract TokenContract is IERC20 {
    string private _name = "MyTokenContract";
    string private _symbol = "MTC";
    uint8 private constant _decimals = 18;
    uint256 private _totalSupply;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    function name() external view override returns (string memory) {
        return _name;
    }

    function symbol() external view override returns (string memory) {
        return _symbol;
    }

    function decimals() external pure returns (uint8) {
        return _decimals;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        address owner = msg.sender;

        require(recipient != address(0), "ERC20:address cannot be Zero");
        require(balances[owner] >= amount, "ERC20: insufficient balance");

        balances[owner] -= amount;
        balances[recipient] += amount;

        emit Events.Transfer(owner, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        address owner = msg.sender;

        require(spender != address(0), "ERC20: You cannot approve to the zero address");

        allowances[owner][spender] = amount; 
        emit Events.Approve(owner, spender, amount);
        return true;
    }

    function transferFrom(address owner, address recipient, uint256 amount) external override returns (bool) {
        address spender = msg.sender;

        require(owner != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20:You cannot transfer to the zero address");
        require(balances[owner] >= amount, "ERC20: insufficient balance");
        require(allowances[owner][spender] >= amount, "ERC20: insufficient allowance");

        allowances[owner][spender] -= amount;
        balances[owner] -= amount;
        balances[recipient] += amount;

        emit Events.TransferFrom(owner, recipient, amount);
        return true;
    }

    function mint(address receiver, uint256 amount) external override {
        require(receiver != address(0), "ERC20:you cannot mint to the zero address");

        balances[receiver] += amount;
        _totalSupply += amount;

        emit Events.Transfer(address(0), receiver, amount);
    }
}

