pragma solidity >=0.4.0 <0.9.0;

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
contract EventsAndReturns {
    
    mapping(address => uint) public tokenBalance;

    // events allow information to be emitted in the transaction within the logs section.
    // this takes the place of return values for transactions.
    // it can also serve as a trigger in which other applications can subscribe and listen to these events
    // through the RPC interface of an Ethereum client.
    event TokenSent(address _from, address _to, uint _amount);

    constructor() {
        tokenBalance[msg.sender] = 100;
    }
    
    function sendToken(address _to, uint256 _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]); // num wrap around check
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]); // num wrap around check
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokenSent(msg.sender, _to, _amount);
    }
}
