// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Bu şekilde dışarıdan da miras alabiliyoruz.
// NOT : Hata almasının sebebi import edilmemesidir(npm olarak).


import "@openzeppelin/contracts/access/Ownable.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol"; 

contract Wallet is Ownable {
    fallback() payable external {}

    function sendEther(address payable to, uint amount) onlyOwner public {
        to.transfer(amount);
    }

    function showBalance() public view returns(uint) {
        return address(this).balance;
    }
}