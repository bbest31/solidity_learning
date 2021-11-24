pragma solidity >=0.4.0 <0.9.0;

contract SimpleMappingExample {
    mapping(address => bool) public myMapping;

    function setValue(address _address) public {
        myMapping[_address] = true;
    }

    function setMyAddressToTrue() public {
        myMapping[msg.sender] = true;
    }
}
