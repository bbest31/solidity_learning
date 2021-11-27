pragma solidity >=0.4.0 <0.9.0;

contract SomeContract {
    uint public myUint = 10;
    function setUint(uint _uint) public {
        myUint = _uint;
    }
}