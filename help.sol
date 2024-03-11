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
        require(msg.value > 0, unicode"Введите значение больше 0");
        
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
        return user.balance;
    }
    
    function removal(uint256 amount) public {
        require(amount > 0, unicode"Введите значение больше 0");
        
        for (uint i = 0; i < users.length; i++) {
            if (users[i].userAddress == msg.sender) {
                require(users[i].balance >= amount, unicode"Вы бомж :)");
                payable(msg.sender).transfer(amount);
                users[i].balance -= amount;
                break;
            }
        }
    }
}
