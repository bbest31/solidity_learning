pragma solidity >=0.4.0 <0.9.0;

contract MappingStructExample {
    struct Payment {
        uint256 amount;
        uint256 timestamp;
    }

    struct Balance {
        uint256 totalBalance;
        uint256 numPayments;
        mapping(uint256 => Payment) payments;
    }

    mapping(address => Balance) public balanceRecieved;

    // Solidity has arrays but gas consumption goes way up so try and stick to maps.
    uint256[] myArray;

    enum ExampleEnum {Option1, Option2, Option3}
    ExampleEnum ex;
    ExampleEnum constant defaultEx = ExampleEnum.Option1;

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        balanceRecieved[msg.sender].totalBalance += msg.value; // increase the balance being tracked for the sender sending eth to this contract.
        Payment memory payment = Payment(msg.value, block.timestamp);

        balanceRecieved[msg.sender].payments[
            balanceRecieved[msg.sender].numPayments
        ] = payment;
        balanceRecieved[msg.sender].numPayments++;
    }

    function withdrawMoney(address payable _to, uint256 _amount) public {
        require(
            balanceRecieved[msg.sender].totalBalance >= _amount,
            "not enough funds"
        );
        balanceRecieved[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _addr) public {
        // use checks-effects-direction pattern for security
        uint256 balanceToSend = balanceRecieved[msg.sender].totalBalance; // check: ensure you can access or do something
        balanceRecieved[msg.sender].totalBalance = 0; // effect: change the state of the smart contract as a result
        _addr.transfer(balanceToSend); // direction: interact with the external account.
    }
}
