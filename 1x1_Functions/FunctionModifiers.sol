// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Functions {
    
    //View
    // number'da bir değişiklik yapmak istemez isek , sadece bir değişiklik yapmak istersek 'view' ile görüntüleme işlemi yaparız.
    uint public number = 3;

    // dışardaki sayıyı değiştirmiyoruz , dışardaki sayiyla gönderdiğimiz sayiyi topluyoruz!
    function addToX(uint y) public view returns(uint){
        return number + y;
    }

    // Burada 'global'den bir değer okuyoruz (block.timestamp) ve bunun içinde 'view' kullanıyoruz.
    function addAndView(uint a, uint b) public view returns (uint) {
        return a * (b + 42) + block.timestamp;
    }

    //Pure
    // Ne okuma ne de değiştirme işlemleri yapmadığımız zaman 'pure' kullanırız.
    // Kendi fonksiyonu içinde tanımladığı değişkenlerle işlem yapabiliyor.
    function addAndPure(uint a, uint b) public pure returns (uint) {
        return a * (b + 42);
     }

    function hello() pure public returns(string memory) {
        return 'Hello World!';
    }



}