pragma solidity >=0.4.0 <0.9.0;

contract StartStopUpdateExample {
    address owner; // will refer to the address of the smart contract owner
    bool paused;

    constructor() {
        owner = msg.sender;
    }

    function sendMoney() public payable {}

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "You are not the owner"); // stop the transaction is require statements don't pass.
        require(!paused, "contract is paused"); // can use require statements with booleans to paused certain functions of a smart contract to not execute until unpaused.
        _to.transfer(address(this).balance);
    }

    // destroy a smart contract and send the held funds to a specific address.
    // once a contract is destroyed the balance is emptied out.
    // You can still send ether to the contract because it is still technically an account with an address.
    // However, you can't utilize any functions of the contract to send funds anywhere else so those fund would essentially be locked to the contract.
    function destroy(address payable _to) public {
        require(msg.sender == owner);
        selfdestruct(_to); // built in Solidity function to destroy a smart contract.
    }
}
