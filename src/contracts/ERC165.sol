// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './interfaces/IERC165.sol';

contract ERC165 is IERC165 {

  mapping(bytes4 => bool) private _supportedInterfaces;

  constructor() {
    _registerInterface(bytes4(keccak256('supportInterface(bytes4)')));
  }

  function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
    return _supportedInterfaces[interfaceId];
  }

  function _registerInterface(bytes4 interfaceId) internal {
    require(interfaceId != 0xffffffff, 'Invalid interface request');
    _supportedInterfaces[interfaceId] = true;
  }

}