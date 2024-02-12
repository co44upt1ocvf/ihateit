// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Control {
    struct User {
        address userAddress;
        uint256 balance;
    }
    
    User[] users;
    
    event NewBalance(address user, uint256 amount);
    
    function accountStatus() public payable {
        require(msg.value > 0, "Value must be greater than 0");
        
        bool userExists = false;
        for (uint i = 0; i < users.length; i++) {
            if (users[i].userAddress == msg.sender) {
                users[i].balance += msg.value;
                userExists = true;
                break;
            }
        }
        
        if (!userExists) {
            users.push(User(msg.sender, msg.value));
        }
        
        emit NewBalance(msg.sender, msg.value);
    }
    
    function getBalance(address user) public view returns(uint256) {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].userAddress == user) {
                return users[i].balance;
            }
        }
        return 0; // User not found
    }
    
    function removal(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        
        for (uint i = 0; i < users.length; i++) {
            if (users[i].userAddress == msg.sender) {
                require(users[i].balance >= amount, "Insufficient balance");
                payable(msg.sender).transfer(amount);
                users[i].balance -= amount;
                break;
            }
        }
    }
}