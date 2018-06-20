pragma solidity ^0.4.17;

contract Lottery {
    address public admin;
    address[] public players;
    
    constructor() Lottery() public{
        admin = msg.sender;
    
    }
        
    function enter() public payable{
        require(msg.value > 0.1 ether);
        
        players.push(msg.sender);  
        
    }
    
    function randomSelector() private view returns (uint256){
        
        return uint(keccak256(block.difficulty, now, players));
        
    }
    
    function pickWinner() public {
        uint index = randomSelector() % players.length;
        players[index].transfer(address(this).balance);
        players = new address[](0);
        require(msg.sender == admin);
    
        
    }
    
    function getPlayers() public view returns (address[]) { 
        
        return players;
    }
    
    
}
