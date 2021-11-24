pragma solidity >=0.4.0 <0.9.0;

import "./Owned.sol";

contract InheritanceModifierExample is Owned { // inheritance works with contracts as well.
    mapping(address => uint256) public tokenBalance;
    // inherits the owner state variable and the onlyOwner modifier
    uint256 tokenPrice = 1 ether;

    constructor() {
        owner = msg.sender;
        tokenBalance[owner] = 100;
    }

    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }

    function purchaseToken() public payable {
        require(
            (tokenBalance[owner] * tokenPrice) / msg.value > 0,
            "not enough tokens"
        );
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    function sendToken(address _to, uint256 _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]); // num wrap around check
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]); // num wrap around check
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }
}
