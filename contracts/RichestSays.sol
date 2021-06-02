// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract RichestSays {
    bytes public Author = "updog";
    bytes public Message = "Doge coin to the moon!";
    uint256 public Value = 10000000000000000;
    
    address payable _owner;

    event NewRichest(string author, string message, uint256 value);

    constructor() {
        _owner = payable(msg.sender);
    }

    function send_message(string calldata author, string calldata message) payable external {
        require(msg.value > Value);
        require(bytes(author).length <= 30);
        require(bytes(message).length <= 280);

        Value = msg.value;
        Message = bytes(message);
        Author = bytes(author);

        emit NewRichest(author, message, msg.value);
    }

    function get_current_richest() external view returns (string memory, string memory, uint256) {
        return (string(Author), string(Message), Value);
    }

    function cash_back() external payable {
        _owner.transfer(address(this).balance);
    }

    receive() external payable {
        _owner.transfer(msg.value);
    }

    fallback() external payable {
        _owner.transfer(msg.value);
    }
}