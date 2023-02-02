//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract StructEnum {

    // Aslında enum'un içine yazılan kelimeler sadece anlamamızı kolaylaştırıyor yoksa şu an sadece 0,1,2,3 değerlerini tutuyor.
    // Bunun yerine struct'ın içine 'uint256 status' yazsaydıkta aynı anlama gelecekti.
    // Daha sonra anlayacağımız gibi enum'lar okumamızı daha kolaylaştıracak.
    enum Status {
        Taken, // 0
        Preparing, // 1
        Boxed, // 2
        Shipped // 3
    }

    struct Order {
        address customer;
        string zipCode;
        uint256[] products;
        Status status;
    }

    Order[] public orders;
    address public owner;

    constructor() {
        // contract oluşturulduğu anda oluşur.
        owner = msg.sender;
    }

    // Değişkenlerin başına '_' koymak bir alışkanlıktır ve okumayı kolaylastırır.
    // memory : Memory'ler, fonksiyonun scope'unda yer alıp daha sonra kaybolucak veriler olarak düşünebiliriz. 
    function createOrder(string memory _zipCode, uint256[] memory _products) external returns(uint256) {
        require(_products.length > 0, "No products.");

        // Order oluşturabileceğimiz 3 farklı yazım sekli var. Bunlar :

        // 1.Yazım sekli
        // Struct kopyası alınıyor. 
        Order memory order;
        order.customer = msg.sender;
        order.zipCode = _zipCode;
        order.products = _products;
        // Dediğimiz gibi aslında biz Status'un 0'ıncı degerine esitledik fakat yazması ve anlaması boyle daha kolay oldu.
        order.status = Status.Taken;
        orders.push(order);

        // 2.Yazım sekli
        // orders.push(
        //     Order({
        //         customer: msg.sender,
        //         zipCode: _zipCode,
        //         products: _products,
        //         status: Status.Taken
        //     })
        // );

        // 3.yazım sekli
        // orders.push(Order(msg.sender, _zipCode, _products, Status.Taken));
        
        return orders.length - 1; // 0 1 2 3
    }

    function advanceOrder(uint256 _orderId) external {
        require(owner == msg.sender, "You are not authorized.");
        require(_orderId < orders.length, "Not a valid order id.");

        Order storage order = orders[_orderId];
        require(order.status != Status.Shipped, "Order is already shipped.");

        if (order.status == Status.Taken) {
            order.status = Status.Preparing;
        } else if (order.status == Status.Preparing) {
            order.status = Status.Boxed;
        } else if (order.status == Status.Boxed) {
            order.status = Status.Shipped;
        }
    }

    function getOrder(uint256 _orderId) external view returns (Order memory) {
        require(_orderId < orders.length, "Not a valid order id.");
        
        /*
        Order memory order = orders[_orderId];
        return order;
        */

        return orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zip) external {
        require(_orderId < orders.length, "Not a valid order id.");
        Order storage order = orders[_orderId];
        require(order.customer == msg.sender, "You are not the owner of the order.");
        order.zipCode = _zip;
    }

}