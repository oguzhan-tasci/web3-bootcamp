//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VaultFactory {
    mapping(address => Vault[]) public userVaults;

    // ücret almadan cüzdan yaratan fonksiyon.
    function createVault() external {
        // constructor parametresi olmasaydı :
        // "Vault vault = new Vault();" yeterli olurdu fakat parantez içine constructor dönmemiz gerekiyor.
        Vault vault = new Vault(msg.sender);
        userVaults[msg.sender].push(vault);
    }

    // ücret alarak cüzdan yaratan fonksiyon.
    function createVaultWithPayment() external payable {
        Vault vault = (new Vault){value: msg.value}(msg.sender);
        userVaults[msg.sender].push(vault);
    }
}

contract Vault {
    address public owner; 
    uint256 private balance;

    constructor(address _owner) payable {
        owner = _owner;
        balance += msg.value;
    }

    // fallback ve receive, deposit fonksiyonunu kullanmadan kontrata bir değer içeren mesaj gelirse ne yapmamız gerektiğini gösteriyor:

    // eğer revert koysaydık otomatikman reddilecekti. Kontrat sadece deposit ile para yatırmaya açık olacaktı.
    //  fallback() external payable {
    //      revert();
    //  } 
    fallback() external payable {
        balance += msg.value;
    }

    receive() external payable {
        balance += msg.value;
    }

    function getBalance() external view returns (uint256) {
        // return address(this).balance; --> bu şekilde de olur.
        return balance;
    }

    function deposit() external payable {
        balance += msg.value;
    }   

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "You are not authorized.");
        balance -= _amount;
        payable(owner).transfer(_amount);
    }
}