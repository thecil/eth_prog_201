pragma solidity 0.8.0;

contract HelloWorld{
    string message = "hello world!";


    function setMessage(string memory _newMessage) public{
        message = _newMessage;
    }

    function hello() public view returns(string memory){
        return message;
    }

}