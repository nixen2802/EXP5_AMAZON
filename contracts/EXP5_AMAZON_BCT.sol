// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract EXP5_AMAZON_BCT {
    struct Product {
        string title;
        string desc;
        uint productId;
        uint price;
        address payable buyer;
        address payable seller;
        bool delivered;
    }
    uint counter = 0;
    Product[] public products;

    event registered(string title, uint productId, address seller);
    event bought(uint productId, address buyer);
    event delivered(uint productId);

    function regsiterProduct(string memory title, string memory desc, uint price) public {
        require(price!=0, "Price must be greater than 0");
        Product memory tempProduct;
        tempProduct.title=title;
        tempProduct.desc=desc;
        tempProduct.price=price;
        tempProduct.seller=payable(msg.sender);
        tempProduct.productId=counter;
        products.push(tempProduct);
        counter++;
        emit registered(title, tempProduct.productId, msg.sender);
    }

    function buyProduct(uint productId) payable public {
        require((products[productId].price)*(1 ether)==msg.value, "Please pay the product's full price");
        require(products[productId].seller!=msg.sender, "A seller cannot purchase their own product");
        products[productId].buyer=payable(msg.sender);
        emit bought(productId, msg.sender);
    }

    function delivery(uint productId) public {
        require(products[productId].buyer==msg.sender, "Only the product's purchaser may confirm delivery of the item");
        products[productId].delivered=true;
        products[productId].seller.transfer((products[productId].price)*(1 ether));
        emit delivered(productId);
    }
}