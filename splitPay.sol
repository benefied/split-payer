// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract SplitPay {
    event PaymentReleased(address indexed to, uint amount);
    event PaymentRecieved(address _from, uint _amount);
    event PayeeAdded(address account, uint shares);

  //an array for the address for the address that are paying eth
  Struct Payee{
    address payable [] public payees;
    string public name;
  }
  
    Payee[] public payees;
    

  //the constructor to add payees
    constructor(address payable [] memory _payees) {
        for(uint i; i < _payees.length; i++) {
            payees.push(_payees[i]);
        }
       emit PayeeAdded(_payees[i], 100 / payees.length)
    }
  
  //fuction to pay into contract and it splits it immediately
    receive() payable external {
        uint256 share = msg.value / payees.length;

        for(uint i; i < payees.length; i++) {
            payees[i].transfer(share);
        }

        emit PaymentRecieved(msg.sender, msg.value);
    }
    //to return amount of payees
     function checkPayees() public view returns(uint){
        return payees.length;
    }

}
