pragma solidity ^0.6.0;

contract HotelRoom{

    uint public rooms=4;

    // enum for room status vaccant or occupied;
     enum Statuses{Vaccant,Occupied}

    event Occupy(address _occupant,uint _value);

    Statuses currentStatus;

    address payable public owner ; // address of hotelowner who deployed the smart contract

    constructor() public{
        owner = msg.sender;// address of hotelowner who deployed the smart contract
        currentStatus = Statuses.Vaccant;
    }

    modifier onlyWhileVaccant{
        require(currentStatus == Statuses.Vaccant,"Currently occupied");
        _;
    }
    
    modifier costs (uint _amount)
    {
        require(msg.value >= _amount,"Not enough ");
        _; // this shows that here code will be inserted of function which is using modifier;
    }

    
    receive() external payable onlyWhileVaccant costs(2 ether){
        // checking balance
        
        // check room status -- onlyWhileVaccant 
      
        if(rooms==0){
        currentStatus = Statuses.Occupied;
        }
        owner.transfer(msg.value);
        emit Occupy(msg.sender , msg.value);
        rooms=rooms-1;

    }
}
