pragma solidity >=0.4.0 <0.9.0;

contract Debugger {
    uint256 public myUint;

    function setMyUint(uint256 _myuint) public {
        myUint = _myuint;
    }
}