// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SimpleStorage {
    // State variable to store a number
    uint public num;
    address public owner;
    event OwnerUpdate( address oldOwner, address newOlwner);
    event NumberUpdate(uint newNumber, address indexed user);

    constructor (){
        owner = msg.sender;
    }
    // change owner
    function changeOwner (address newOwner) onlyOwner public{
        address oldOwner = owner;
        owner = newOwner;
        emit OwnerUpdate(oldOwner, owner);
      

    }
    
    // You need to send a transaction to write to a state variable.// costo per l'invio transazione allo sm
    function set(uint _num) public payable higherThanTen(_num){
        require(msg.value >= 0.001 ether, "Error :not enought money");
        //owner.trasfer(msg.value);
        num = _num;
        emit NumberUpdate(num, msg.sender);
    } 
    

    // You can read from a state variable without sending a transaction.
    function get() public view returns (uint) {
        return num;  
    }

    // n.b i soldi vanno allo smart contract e quindi devo avere una funzione withdraw per ritirare i soldi
   //  e devi fare una funzione che te li deve far ritirare solo a te( onlyOwner) con i modificatori
    //function withdraw() onlyOwner {

    //}

    // inoltre se si vuole creare uno smart contract che puo ricevere soldi devi fare una funzione di FALLBACK /VEDI Exempio.sol
    // https://solidity-by-example.org/fallback/.. SI SUA SPESSO QND I SOLDI VANNO SULLA SMART CONTRACT E NON CE' NESSUNA FUNZIONE DI RICEZIONE
    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier higherThanTen(uint _num){
        require(_num >10, "Error: number must be greater than 10");
        _;
    }

    
    

    // Fallback function must be declared as external.
    fallback() external payable {
        // send / transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
        //emit Log("fallback", gasleft());
    }
}
