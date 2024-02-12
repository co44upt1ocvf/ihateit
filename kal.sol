//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract FinanceManager {
    struct User {
        uint256 balance;
    }

    mapping(address => User) public users;

    event BalanceUpdated(address user, uint256 newBalance);

    function deposit() public payable {
        users[msg.sender].balance += msg.value;
        emit BalanceUpdated(msg.sender, users[msg.sender].balance);
    }

    function getBalance(address user) public view returns (uint256) {
        return users[user].balance;
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, unicode"Значение должно быть больше 0");
        require(users[msg.sender].balance >= amount, unicode"Недостаток на балансе");

        users[msg.sender].balance -= amount;
        payable(msg.sender).transfer(amount);
        emit BalanceUpdated(msg.sender, users[msg.sender].balance);
    }
}
