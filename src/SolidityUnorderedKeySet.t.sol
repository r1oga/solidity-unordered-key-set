pragma solidity ^0.6;
import "ds-test/test.sol";
import "./SolidityUnorderedKeySet.sol";


contract SolidityUnorderedKeySetTest is DSTest {
    using SolidityUnorderedKeySetLib for SolidityUnorderedKeySetLib.Set;
    SolidityUnorderedKeySetLib.Set setLen;
    SolidityUnorderedKeySetLib.Set setExists;
    SolidityUnorderedKeySetLib.Set setInsert;
    SolidityUnorderedKeySetLib.Set setRemove;
    SolidityUnorderedKeySetLib.Set setKeyAtIndex;
    SolidityUnorderedKeySetLib.Set setIndexAtKey;
    SolidityUnorderedKeySetLib.Set setNuke;

    function setUp() public {
        // set = SolidityUnorderedKeySetLib.Set();
    }

    function testLen() public {
        assertEq(setLen.len(), 0);
        setLen.keyList.push("test");
        assertEq(setLen.len(), 1);
    }

    function testExists() public {
        assert(!setExists.exists("test"));
        setExists.keyList.push("test");
        setExists.keyPointers["test"] = 0;
        assert(setExists.exists("test"));
    }

    function testInsert() public {
        setInsert.insert("test");
        assertEq(setInsert.len(), 1);
        assert(setInsert.exists("test"));
    }

    function testRemove() public {
        setRemove.insert("test");
        assert(setRemove.exists("test"));
        setRemove.remove("test");
        assert(!setRemove.exists("test"));
    }

    function testKeyAtIndex() public {
        setKeyAtIndex.insert("test");
        assertEq("test", setKeyAtIndex.keyList[0]);
    }

    function testIndexAtKey() public {
        setIndexAtKey.insert("test");
        assertEq(0, setKeyAtIndex.keyPointers["test"]);
    }

    // FAILS with dapp test but succeed in e.g remix
    function testNuke() public {
        // Add 2 elements
        setNuke.insert("test0");
        setNuke.insert("test1");
        assert(setNuke.exists("test0"));
        assert(setNuke.exists("test1"));
        assertEq(2, setNuke.len());
        // nuke
        setNuke.nuke();
        assert(!setNuke.exists("test0"));
        assert(!setNuke.exists("test1"));
        assertEq(0, setNuke.len());
    }
}
