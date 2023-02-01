// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Immutable {
    
    // Immutable'da constant gibi değişmez değerlerdir.
    // Aralarındaki en büyük fark , contant'ı en basta belirmen gerekiyor fakat immutable değerleri constructor içinde atama yapabilirsin.
    address public immutable MY_ADDRESS;
    uint public immutable MY_LUCKYNUMBER;

    constructor(uint _myNumber) {
        MY_ADDRESS = msg.sender;
        MY_LUCKYNUMBER = _myNumber;
    }
}