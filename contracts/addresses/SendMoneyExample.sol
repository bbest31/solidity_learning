pragma solidity >=0.4.0 <0.9.0;

contract SendMoneyExample {
    // stores the value of the balance received
    uint256 public balanceReceived;

    function receiveFunds() public payable {
        balanceReceived += msg.value; // stores the amount received in the variable
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // withdraw all funds to person who calls this function
    function withdrawFunds() public {
        address payable to = payable(msg.sender); // msg.sender is of type address and needs to be explicitly converted to a payable type.
        to.transfer(this.getContractBalance());
        balanceReceived = 0;
    }

    function withdrawFundsTo(address payable _to) public {
        _to.transfer(this.getContractBalance());
    }
}
