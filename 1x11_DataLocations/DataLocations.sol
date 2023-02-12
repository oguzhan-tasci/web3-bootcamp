// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
           Kontrat           <----                  Kontrata yapılan çağrı
           -------                                      -------------
    Kontrat depolama alanı           Fonksiyon için ayrılan hafıza ve çağrıdaki data alanı

    memory:          Geçici hafıza
    storage:         Kalıcı hafıza
    calldata:        Çağrıdaki argümanlar

    bytes, string, array, struct

    * Değer tipleri (uint, int, bool, bytes32) kontrat üzerinde storage, 
      fonksiyon içinde memory'dir
    
    * mapping'ler her zaman kontrat üzerinde tanımlanır ve storage'dadır.
*/

// Calldata'yı fonksiyonun içerisinde verilen değerleri doğrudan okumak istiyorsak kullanmalı ;
// Memory'i fonksiyon içerisinde eğer bir değişiklik yapılmayacaksa sadece okuma işlemi yapılacaksa kullanılmalı ;
// Storage ise bir değişiklik yapılacaksa kullanılacaktır.
// Kodun daha fazla okunaklı olması için, daha az gas harcamak için bunlara dikkat edilmesi gerekir. 
// En çok gaz harcıyandan en az harcayana : Storage > Memory > Calldata


struct Student {
    uint8 age;
    uint16 score;
    string name;
}

contract School {
    uint256 totalStudents = 0;              // storage
    mapping(uint256 => Student) students;   // storage

    // memory veya storage değilde 'calldata' olursa, bu değişken değişmez, sonradan atama yapılamaz.
    function addStudent(string calldata name, uint8 age, uint16 score) external {
        uint256 currentId = totalStudents++;
        students[currentId] = Student(age, score, name); 
    }

    function changeStudentInfoStorage(
        uint256 id,                 // memory
        string calldata newName,    // calldata
        uint8 newAge,               // memory
        uint16 newScore             // memory
    ) external {
        // kontratın içeriğini değiştirmek istiyorsak 'storage' kullanmalıyız.
        Student storage currentStudent = students[id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;
    }

    /**
        @dev Bu işe yaramayacaktır, çünkü oluşturulan currentStudent ömrü
        fonksiyonun bitişine kadar olan bir değişken ve fonksiyon tamamlandığında
        silinecektir
    */
    function changeStudentInfoMemory(
        uint256 id,                 // memory
        string calldata newName,    // calldata
        uint8 newAge,               // memory
        uint16 newScore             // memory
    ) external {
        Student memory currentStudent = students[id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;
    }

    function getStudentName(uint256 id) external view returns(string memory) { 
        return students[id].name;
    }
}
