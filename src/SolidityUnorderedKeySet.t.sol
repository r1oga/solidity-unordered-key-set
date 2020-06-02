pragma solidity ^0.6;
import "ds-test/test.sol";
import "./SolidityUnorderedKeySet.sol";


contract SolidityUnorderedKeySetTest is DSTest {
    using SolidityUnorderedKeySetLib for SolidityUnorderedKeySetLib.Set;
    SolidityUnorderedKeySetLib.Set set;
    SolidityUnorderedKeySetLib.Set set2;
    SolidityUnorderedKeySetLib.Set set3;

    function setUp() public {
        // set = SolidityUnorderedKeySetLib.Set();
    }

    function testLen() public {
        assertEq(set.len(), 0);
        set.keyList.push("test");
        assertEq(set.len(), 1);
    }

    function testExists() public {
        assert(!set2.exists("test"));
        set2.keyList.push("test");
        set2.keyPointers["test"] = 0;
        assert(set2.exists("test"));
    }

    function testInsert() public {
        set3.insert("test");
        assertEq(set3.len(), 1);
        assert(set3.exists("test"));
    }
}
