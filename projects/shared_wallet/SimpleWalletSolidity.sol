pragma solidity >=0.4.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint;
    event AllowanceChanged(
        address indexed _forWho,
        address indexed _fromWhom,
        uint256 _oldAmount,
        uint256 _newAmount
    );

    mapping(address => uint256) public allowance;

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "You are not allowed"
        );
    }

    function addAllowance(address _who, uint256 _amt) public onlyOwner {
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who].add(_amt)
        );
        allowance[_who] = allowance[_who].add(_amt);
    }

    function reduceAllowance(address _who, uint256 _amount) internal {
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who].sub(_amount)
        );
        allowance[_who] = allowance[_who].sub(_amount);
    }
}

contract SimpleWallet is Allowance {
    event MoneySent(address indexed _beneficiary, uint256 _amount);
    event MoneyReceived(address indexed _from, uint256 _amount);

    function withdrawFunds(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        require(
            _amount <= address(this).balance,
            "There are not enough funds stored in this contract"
        );
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }

        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    fallback() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}
