pragma solidity >=0.4.0 <0.9.0;

import "@openzeppelin/contracts/utils/math/Math.sol";

contract Libraries {
    mapping(address => uint) public tokenBalance;

    constructor () {
        tokenBalance[msg.sender] = 1;
    }

    function sendToken(address _to, uint _amount) public returns(bool) {
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        return true;
    }
}