// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Variables {

    // Yorum satırı
    /* 
        Yorum Satırı
    */

    // Fixed-Size Types

    bool isTrue = true; // varsayılan: false
    
    int256 number = 12; // -2^256 to 2^256 - 1 

    uint number2 = 10; // 0 to 2^256 - 1 --> u anlamı : Negatif sayılar yok

    // adress ile etherum adresi tanımlıyoruz. Bunun boyutuda 20byte
    address addresss; // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 - 20 byte

    bytes32 data; // bytes1 => bytes32


    // Dynamic-Size Types

    string name = "Oguzhan";

    bytes datas;

    uint[] numbers; // [1, 2, 3, 4, 5]

    // Mapping degisken türü şu şekilde çalışıyor : mapping(uint(1) => string(2)) dictionary(3);
    // Uint olarak tanıttım değişken(1), string türündeki değişkenleri(2) tutsun ve bunu dictionary(3) diyerek çağıralım.
    // Key - value mantığına oldukça benzer şekilde çalışıyor..
    mapping(uint => string) dictionary;


    // User Defined Value Types

    // Birden fazla kişinin değerlerini tutmak için tanımlanan değerlerdir.
    struct Human {
        uint ID;
        string name;
        string surname;
        uint age;
    }


    // enum'ları içerideki sadece bir değişkeni kullanmak için kullanırız. Örneğin bir sayıyı geçtikten sonra 'GREEN' olsun vs.
    enum trafficLights {
        RED,
        YELLOW,
        GREEN
    } 

    // operators

    // ! (logical negation)
    // && (logical conjunction, “and”)
    // || (logical disjunction, “or”)
    // == (equality)
    // != (inequality)


    // ether birimleri

    // 1 wei = 1
    // 1 gwei = 10^9
    // 1 ether = 10^18

    // zaman birimleri 

    // 1 == 1 seconds
    // 1 minutes == 60 seconds
    // 1 hours == 60 minutes
    // 1 days == 24 hours
    // 1 weeks == 7 days


    // State Variables

    string public bestClub = "itu blockchain";
    uint256 public founded = 2018;
    bool private rich = false;

    function add(int256 _number) public pure returns (int256) {
        // Local Variables
        int256 minus = -1;
        int256 lucky = 33;

        return _number + minus + lucky;
    }

    //Global Variables

    // block.difficulty (uint)	Current block difficulty
    // block.gaslimit (uint)	Current block gaslimit
    // block.number (uint)	Current block number
    // block.timestamp (uint)	Current block timestamp as seconds since unix epoch
    // msg.data (bytes calldata)	Complete calldata
    // msg.sender (address payable)
    
}