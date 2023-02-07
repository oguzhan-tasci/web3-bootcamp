// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Bir banka uygulaması yapmak istiyoruz.
// Temel olarak yapmak istediğimiz :
// İnsanlar bu kontrata ethereum gönderebilsin, istediği zaman çekebilsin.

contract Bank {
    
    // Adress'lerin gönderdikler ether'leri tutmak için 'mapping'kullanıyoruz.
    mapping(address => uint ) balances;

    // ether göndermeye yarıyacak fonksiyon
    // Bir değer gönderimi yapıalcağı için 'payable' keywordü kullanıyoruz.
    function sendEtherToContract() payable external {
        balances[msg.sender] = msg.value;
    }

    //
    function showBalance() external view returns(uint) {
        return balances[msg.sender];
    }

    // Parayı çekmek için yazılan fonksiyon.
    // Bir fonksiyona ether göndermek istiyorsakta 'payable' olarak işaretlememiz gerekiyor.  
    function withdraw(address payable to, uint amount) external  {
        // require(balances[msg.sender] >= amount,"yetersiz bakiye");
        to.transfer(amount);
        balances[to] += amount;
        balances[msg.sender] -= amount;


    }

    // Ether gönderme metodları : Transfer, Send , Call
    // transferin iyi özelliği : yeterli miktarı gödermessen , fazla vs. , revert işlemi (geri çevirme) işlemi uygulanıyor.
    // Transfer()
    // Revert

    // Bir işlemin gönderilip gönderilmediğini true-false olarak döndüren methoddur.
    // Send()
    // true, false
    
        // bool ok = to.send(amount);
        // balances[msg.sender] -= amount;
        // return ok;
        // OUTPUT : true or false

    // İki değer döndürüyor true-false ve data.
    // Call()
    // bool, data

        // (bool sent, bytes memory data) = to.call{value:amount}("Hata");
        // balances[msg.sender] -= amount;
        // return sent;
        // OUTPUT : 

    uint public receiveCount = 0;
    uint public fallbackCount = 0;
    
    // Eğer bir kontrata ether göndermek istiyorsak, bu kontratların özel 2 fonksiyonu vardır : receive ve fallback

    // veri olmadan çalışır.
    receive() external payable {
        receiveCount +=1;
    }
    // receive ile aynı işlemi görür sadece ekstra olarak data'da gönderilebiliniyor.
    // fallback olmadan sadece receive fonksiyonu yazılırsa hata alınır bu işleme izin verilmez fakat
    // sadece fallback yazılır ve receive yazılmazsa uyarı verir ama çalışır!
    fallback() external payable {
        fallbackCount += 1;
    }
}