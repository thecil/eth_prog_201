// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is 
Ownable, 
ERC20PresetMinterPauser
{
    constructor() ERC20PresetMinterPauser("openTokenFull", "OTKN") {
        // 100 OTKN
        _cap = 100000000000000000000;
        _setupRole(CAPPER_ROLE, _msgSender());
        // mint 10 OTKN
        _mint(msg.sender, 10000000000000000000);

    }

    // add cap functionality
    using SafeMath for uint256;
    uint256 private _cap;

    function cap() public view virtual returns (uint256) {
        return _cap;
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);

        if (from == address(0)) { // When minting tokens
            require(totalSupply().add(amount) <= cap(), "ERC20Capped: cap exceeded");
        }
    }

    /*
    implement a new role in the same ERC20 contract. 
    This role should be the only one to be able to change the contract's cap.
    */
    bytes32 public constant CAPPER_ROLE = keccak256("CAPPER_ROLE");

    // new function that allows you to modify the cap.
    function newCap(uint256 _newCap) public {
        require(hasRole(CAPPER_ROLE, _msgSender()), "ERC20PresetMinterPauser: must have capper role to change cap");
        require(_newCap > 0, "ERC20Capped: cap is 0");
        _cap = _newCap;
    }
}