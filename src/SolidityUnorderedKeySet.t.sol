pragma solidity ^0.6;

import "ds-test/test.sol";

import "./SolidityUnorderedKeySet.sol";

contract SolidityUnorderedKeySetTest is DSTest {
    SolidityUnorderedKeySet set;

    function setUp() public {
        set = new SolidityUnorderedKeySet();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
