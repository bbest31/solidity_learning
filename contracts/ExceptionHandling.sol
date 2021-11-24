pragma solidity >=0.4.0 <0.9.0;

contract ExceptionExample {

    mapping(address => uint64) public balanceReceived;

    function receiveMoney() public payable {
        // Asserts are for checking internal states
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    }

    function withdrawMoney(address payable _to, uint64 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "You don't have enough ether"); // throws an error and stops the transaction if the condition fails.
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount); // assert throws an exception
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}

/**
Assert VS. Require

Require: (revert is essentially the same as revert())
* Returns remaining gas that was sent to the smart contract.
* Require is used to validate user input.
* ex. function call via message to another smart contract and it doesn't finish properly
* external call to a contract not containing any code
* the contract receives ether without the payable modifer
* your contract receives ether at a getter function
* address.transfer() fails

Assert:
* Consumes all gas sent to the smart contract.
* Used to validate invariants, or sanity checks like checking the number wrap around. These are like internal errors that are unexpected.
* ex. Out of bounds index, division by zero, byteshifting by a negative amount, converting a value too big or negative to an enum,
* 

 */