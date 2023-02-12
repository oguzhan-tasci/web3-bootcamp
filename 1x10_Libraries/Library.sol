// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Sürekli kullanabileceğimiz fonksiyonları oluşturmamızı sağlar.

library Math {
    function plus(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }

    function minus(uint256 x, uint256 y) public pure returns (uint256) {
        return x - y;
    }

    function multi(uint256 x, uint256 y) public pure returns (uint256) {
        return x * y;
    }

    function divide(uint256 x, uint256 y) public pure returns (uint256) {
        require(y != 0, "bu sayisi begenmedim!");
        return x / y;
    }

    function min(uint256 x, uint256 y) public pure returns (uint256) {
        if (x <= y) {
            return x;
        } else {
            return y;
        }
    }

    function max(uint256 x, uint256 y) public pure returns (uint256) {
        if (x >= y) {
            return x;
        } else {
            return y;
        }
    }
}

// Yukarıda oluşturduğumuz library en basit şeklinde 'Math(library ismi)' ile başlayıp fonksiyonu ekleyerek çağırabiliyoruz.
contract Library2 {
    function trial1(uint256 x, uint256 y) public pure returns (uint256) {
        return Math.plus(x, y);
    }

    function trial2(uint256 x, uint256 y) public pure returns (uint256) {
        return Math.max(x, y);
    }

    function trial3(uint256 x, uint256 y) public pure returns (uint256) {
        return Math.min(x, y);
    }

    function trial4(uint256 x, uint256 y) public pure returns (uint256) {
        return Math.multi(x, y);
    }
}


// Verilen array içerisinde belirtilen sayı var mı ? sorsunu cevaplamak için yazılan search fonksiyonu.
library Search {
    function indexOf(uint256[] memory list, uint256 data)
        public
        pure
        returns (uint256)
    {
        for (uint256 i = 0; i < list.length; i++) {
            if (list[i] == data) {
                return i;
            }
        }
        return list.length;
    }
}

contract Library {
    using Math for uint256;
    using Search for uint256[];

    function trial1(uint256[] memory x, uint256 y)
        public
        pure
        returns (uint256)
    {
        return x.indexOf(y); // Search.indexOf(x,y)  Math.plus(x,y);
    }
}


library Human {
    struct Person {
        uint256 age;
    }

    function birthday(Person storage _person) public {
        _person.age += 1;
    }

    function showAge(Person storage _person) public view returns (uint256) {
        return _person.age;
    }
}

contract HumanContract {
    mapping(uint256 => Human.Person) people;

    function newYear() public {
        Human.birthday(people[0]);
    }

    function show() public view returns (uint256) {
        return Human.showAge(people[0]);
    }
}
