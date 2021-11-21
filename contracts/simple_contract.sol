pragma solidity >=0.4.0 <0.9.0;

contract SimpleContract {
    // All variables are initialized by a default value.
    // there is no null or undefined value.

    // There are no floats in solidity. Just uint which represents wei.
    // 1 ETH = 10^18 wei
    // public variables can be openly viewed
    uint256 public myUint; // public variables generate a getter with the name of the variable.

    // uints wrap at their limits so be careful with number overflow

    // functions can also be delcared as public so they are exposed on the SC and can be called.
    function setMyUint(uint256 _myUint) public {
        myUint = _myUint;
    }

    // there is an address type which refers to an Ethereum address.
    address public myAddress;

    function setMyAddress(address _address) public {
        myAddress = _address;
    }

    function getBalanceOfAddress() public view returns (uint256) {
        return myAddress.balance;
    }

    // Caveats to strings in solidity:
    // - not a lot of util functions built in.
    // - no length or index access
    // - expensive to use!
    string public myString;

    // strings are tricky and have special rules. The memory keyword means we are storing it's value in memory and not referencing
    // a specific memory address. This is because strings are a reference type.
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}
