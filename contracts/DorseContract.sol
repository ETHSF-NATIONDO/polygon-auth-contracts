// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./lib/GenesisUtils.sol";
import "./interfaces/ICircuitValidator.sol";
import "./verifiers/ZKPVerifier.sol";

contract DorseContract is ZKPVerifier {
    uint64 public constant TRANSFER_REQUEST_ID = 1;

    string public _name;
    mapping(uint256 => address) public idToAddress;
    mapping(address => uint256) public addressToId;

    constructor(string memory name_) {
        _name = name_;
    }

    function _beforeProofSubmit(
        uint64, /* requestId */
        uint256[] memory inputs,
        ICircuitValidator validator
    ) internal view override {
        // check that challenge input of the proof is equal to the msg.sender
        address addr = GenesisUtils.int256ToAddress(
            inputs[validator.getChallengeInputIndex()]
        );
        require(
            _msgSender() == addr,
            "address in proof is not a sender address"
        );
    }

    function _afterProofSubmit(
        uint64 requestId,
        uint256[] memory inputs,
        ICircuitValidator validator
    ) internal override {
        require(
            requestId == TRANSFER_REQUEST_ID,
            "requestId is not same as transferRequest"
        );

        uint256 id = inputs[validator.getChallengeInputIndex()];
        addressToId[_msgSender()] = id;
    }

    function isAuthenticated() external view returns (bool _isAuthenticated) {
        return addressToId[_msgSender()] != 0;
    }
}
