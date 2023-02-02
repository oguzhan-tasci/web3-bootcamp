//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* 

    Eğer dogrudan iterate edeceğimiz durumlar yoksa veya değerleri sıralamamız gerekmiyorsa mappingleri kullanmalıyız,
    bu üşlem oldukça gaz tasarruflarına yol açıyor.
    NOT : mapping'ler ile for dongusu gibi iteration islemler yapılamaz.
*/

contract Mapping {
    mapping(address => bool) public registered;
    mapping(address => int256) public favNums;

    function register(int256 _favNum) public {
        // Bu fonksiyonun true iken tekrar çağrılmaması için ne yapmalıyız? 'require' kullanabiliriz.
        // require, içinde yer alan koşul şartı true değil ise fonksiyonu revert ediyor ve çağrılmasını engelliyor.
        //require(!registered[msg.sender], "Kullanıcınız daha önce kayıt yaptı.");
        require(!isRegistered(), "Kullaniciniz daha once kayit yapti.");
        registered[msg.sender] = true;
        favNums[msg.sender] = _favNum;
    }

    function isRegistered() public view returns (bool) {
        return registered[msg.sender];
    }

    function deleteRegistered() public {
        require(isRegistered(), "Kullaniciniz kayitli degil.");
        delete (registered[msg.sender]);  
        delete (favNums[msg.sender]);
    }
}

// Burada da , bir mapping'in key degerini degistirmeden value degerine bir mapping atayabiliyoruz.
// Şöyle bir senaryo düşünelim : key degeri benim adresim , value degeri ise bana borcu olan kisilerin adres'ini ve borcunu tutsun.
contract NestedMapping {
    mapping(address => mapping(address => uint256)) public debts;

    function incDebt(address _borrower, uint256 _amount) public {
        debts[msg.sender][_borrower] += _amount;
    }

    function decDebt(address _borrower, uint256 _amount) public {
        require(debts[msg.sender][_borrower] >= _amount, "Not enough debt.");
        debts[msg.sender][_borrower] -= _amount;
    }

    function getDebt(address _borrower) public view returns (uint256) {
        return debts[msg.sender][_borrower];
    }
}
