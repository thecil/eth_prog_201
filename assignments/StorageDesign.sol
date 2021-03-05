/*
Let’s compare the Gas cost between 2 different designed contracts with the same functionality.

It’s your assignment to create a contract where I can store this struct.

struct Entity{
    uint data;
    address _address;
}
In one of the contracts, I want you to use only a mapping.
In the other contract, I want you to use only an array.

The contract should have 2 functions

addEntity(). Creates a new entity for msg.sender and adds it to the mapping/array.
updateEntity(). Updates the data in a saved entity for msg.sender

After you have built the 2 contracts, I want you to answer the following questions.

When executing the addEntity function, which design consumes the most gas (execution cost)?
 Is it a significant difference? Why/why not?
Add 5 Entities into storage using the addEntity function and 5 different addresses.
Then update the data of the fifth address you used.
Do this for both contracts and take note of the gas consumption (execution cost).
Which solution consumes more gas and why?
*/

pragma solidity 0.8.0;

//In one of the contracts, I want you to use only a mapping.
contract StorageDesign_Mapping {
  struct Entity{
    uint data;
    address _address;
  }

  mapping(address => Entity) EntityMap;

  // Creates a new entity for msg.sender and adds it to the mapping.
  // @uint _data, value that will be added
  function addEntity(uint _data) public returns(bool success) {
    EntityMap[msg.sender].data = _data;
    EntityMap[msg.sender]._address = msg.sender;
    return true;
  }
  // Updates the data in a saved entity for msg.sender
  // @uint _data, value that will be updated
  function updateEntity(uint _data) public returns(bool success) {
    EntityMap[msg.sender].data = _data;
    return true;
  }

  // Just to validate data after update values.
  function getEntityMap() public view returns(uint, address){
    return(EntityMap[msg.sender].data, EntityMap[msg.sender]._address)
  }

} //END StorageDesign

//In the other contract, I want you to use only an array.
contract StorageDesign_Array {

  struct Entity{
    uint data;
    address _address;
  }

  Entity[] EntityArray;

  // Creates a new entity for msg.sender and adds it to the array.
  // @uint _data, value that will be added
  function addEntity(uint _data) public returns(bool success) {
    Entity memory newEntity;
    newEntity.data = _data;
    newEntity._address = msg.sender;
    EntityArray.push(newEntity);
    return true;
  }
  // Updates the data in a saved entity for msg.sender
  // @uint _data, value that will be updated
  function updateEntity(uint _index, uint _data) public returns(bool success) {
    require(EntityArray[_index]._address == msg.sender, "Only entity owner can update values.");
    EntityArray[_index].data = _data;
    return true;
  }

  // Just to validate data after update values.
  function getEntityArr() public view returns (Entity[] memory) {
    return EntityArray;
  }
} //END StorageDesign_HighCost
