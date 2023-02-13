//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Call metodu : Diğer akıllı kontratlardaki fonksiyonları çağırırken çok fazla önerilmeyen 'low-level' bir fonksiyondur.
// Call'u sadece diğer kontratların fallback fonksiyonlarını tetiklemek için veya doğrudan bir ether değeri göndermek için kullanılması öneriliyor.


contract Test {
    uint256 public total = 0;
    uint256 public fallbackCalled = 0;
    string public incrementer;

    fallback() external payable {
        fallbackCalled += 1;
    }

    function inc(uint256 _amount, string memory _incrementer) external returns(uint256) {
        total += _amount;
        incrementer = _incrementer;

        return total;
    } 
}

contract Caller {
    
    function testCall(address _contract, uint256 _amount, string memory _incrementer) external returns (bool, uint256) {
        // multiple return örneği aşagıdaki gibidir (return olarak belirttiğimiz için) :
        // bu call cağrısının (contract.call) bir return degeri varsa ,ki var (yukarıda 'return total'), bu değeri
        // hash'leyerek geri döndürür(res).
        // Bizim burada doğrudan 'res'i okumamız mümkün değil ama sonradan 'decode' yapabiliriz.
       (bool err, bytes memory res) = _contract.call(abi.encodeWithSignature("inc(uint256, string)", _amount, _incrementer));
       
        uint256 _total = abi.decode(res, (uint256));
        return (err, _total);
    }

    function payToFallback(address _contract) external payable {
        (bool err,) = _contract.call{value: msg.value}("");

        if(!err) revert();
    }


}