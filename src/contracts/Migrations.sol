// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
/* ERROR: VS Code flag the pragma line with Error message below
Source file requires different compiler version (current compiler is 0.4.17+commit.bdeb9e52.Emscripten.clang - note that nightly builds are considered to be strictly less than the released versionsolc
*/
 
contract Migrations {
  address public owner = msg.sender;
  uint public last_completed_migration;
 
  modifier restricted() {
    require(
/* ERROR: VS Code flag the require line with Error message below
Wrong argument count for function call: 2 arguments given but expected 1.solc
*/
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }
 
  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}