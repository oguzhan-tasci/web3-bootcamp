// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Constants {
    
    // constant'ı belirtirsek daha değişmeyeceği anlamını vermiş oluruz.
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint public constant MY_UINT = 123;

    // Bu fonksiyon hata verir ve çalışmaz çünkü constant değişkeni değiştirilemez.
    // function set(uint num) public {
    //     MY_ADDRESS = num;
    // }

}