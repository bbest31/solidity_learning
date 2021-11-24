pragma solidity >=0.4.0 <0.9.0;

contract Functions {
    mapping(address => uint256) public balanceReceived;

    function receiveMoney() public payable {
        assert(
            balanceReceived[msg.sender] + msg.value >=
                balanceReceived[msg.sender]
        );
        balanceReceived[msg.sender] += msg.value;
    }

    address payable owner;

    constructor() {
        owner = payable(address(msg.sender));
    }

    // the view modifier indicates a function that only reads but doesn't modify the state in anyway.
    // https://docs.soliditylang.org/en/latest/contracts.html#view-functions
    function getOwner() public view returns (address) {
        return owner;
    }

    // Pure functions do not interact with any state variables
    // https://docs.soliditylang.org/en/latest/contracts.html#pure-functions
    function converWeitoEther(uint _amountInWei) public pure returns(uint) {
        return _amountInWei / 1 ether;
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }

    function withdrawMoney(address payable to, uint256 amount) public {
        require(amount <= balanceReceived[msg.sender], "not enough funds");
        assert(
            balanceReceived[msg.sender] >= balanceReceived[msg.sender] - amount
        );
        balanceReceived[msg.sender] -= amount;
        to.transfer(amount);
    }

    // fallback function is a function that is run if
    // the call does not match any of the declared functions and someone just wants to send money to the contract.
    // this allows someone to send money to the contract by doing something like using the address and not having to interact
    // with the receiveMoney function directly.
    fallback() external payable {
        receiveMoney();
    }

    // external keyword: function can be called from other contracts and externally but not internally.
    // internal keyword: only callable from the contract itself or from derived contracts. Can't be invoked by a transaction.
    // private: similar to internal but also not callable from derived contracts.
}
