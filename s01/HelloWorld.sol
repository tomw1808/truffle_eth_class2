pragma solidity ^0.4.15;

contract HelloWorld {
    uint256 counter;
    
    function increase() public {
        counter++;
    }
    
    function decrease() public {
        counter--;
    }
    
    function getCounter() public constant returns (uint256){
        return counter;
    }
}