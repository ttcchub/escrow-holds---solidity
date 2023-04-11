pragma solidity ^0.5.2;

contract Escrow {

// person who allowed to deposit & withdraw

    address agent; 
    // mapping for storing deposits in escrow 
    mapping (address => uint256) public deposits;

// only agent can proceed it
modifier onlyAgent() {
    // comapring is sender is agent;
    require(msg.sender == agent);
    _;
}


    constructor () public { 
        // who deploy contract
        // msg is global variable 
        agent = msg.sender;
    }

// seller
    function deposit(address payee) public onlyAgent payable {
        uint256 amount = msg.value;
        deposits[payee] = deposits[payee] + amount;
        // safeMath library instead of " + amount "
    }


    function withdraw ( address payable payee) public onlyAgent {
        // fetchs in payee account
        uint256 payment = deposits [payee]; 

        deposits[payee] = 0;
        // send funds 
        payee.transfer(payment);
    }
}


// classic scheme 
