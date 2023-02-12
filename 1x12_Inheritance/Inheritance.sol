// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// virtual
// virtual : Eğer bir fonksiyon 'virtual' olarak işaretleniyorsa şu anlama geliyor : 
// Bu fonksiyon inherit alınırsa bu fonksiyonun içeriği değiştirilebilir demektir.
contract A {
    uint public x;

    uint public y;

    function setX(uint _x) virtual public {
        x = _x;
    }

    function setY(uint _y) virtual public {
        y = _y;
    }
}
// override
// 'virtual' olan fonksiyonların içeriğini değiştirmek istiyorsak, değiştirdiğimiz fonksiyonu 'override' olarak işaretlemeliyiz.
// A kontratindaki fonksiyonları kullanmak için A kontratını '... is A' ile inherit ediyoruz.
contract B is A {

    uint public z;

    function setZ(uint _z) public {
        z = _z;
    }

    function setX(uint _x) override public {
        x = _x + 2;
    }

}

// -------------------------- 

contract Human {
    function sayHello() public pure virtual returns(string memory) {
        return "Aramiza katilmak ve kendini gelistirmek ister misin?";
    }
}

contract SuperHuman is Human {
    function sayHello() public pure override returns(string memory) {
        return "Aramiza katildigin icin pisman olmayacaksin :)";
    }

    // isMember 'true' ise kendi sayHello'sunu , false ise inheritance oldugu fonksiyonun sayHello'sunu çağırır.
    // İnheritance olan fonksiyona ulaşmak için 'super' anahtar kelimesi veya contract ismi kullanılır.
    function welcomeMessage(bool isMember) public pure returns(string memory) {
        return isMember ? sayHello() : super.sayHello();
        // return isMember ? sayHello() : Human.sayHello();
    }
}