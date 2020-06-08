# Solidity Unordered Key Set
Solidity Library that implements the [Solidity CRUD pattern](https://medium.com/@robhitchens/solidity-crud-part-1-824ffa69509a).  
Use this library to implement Create, Retrieve, Update and Delete operations in data sets in Solidity contracts.

## Supports logical delete
While it is true that blockchain data is immutable, there are frequently cases when a logical delete from a set is required. For example, a set of subscribers where the subscribers are transient.  
While several patterns exist (e.g. set a `bool active = false`) such structures frequently lead to the need to iterate over data and this leads to gas cost increases with scale which is unacceptable in many cases. See [Getting Loopy with Solidity](https://blog.b9lab.com/getting-loopy-with-solidity-1d51794622ad). The [Solidity CRUD pattern](https://medium.com/@robhitchens/solidity-crud-part-1-824ffa69509a) is a general-purpose CRUD solution:
- Create
- Retrieve
- Update
- Delete

plus
- Count
- Iterate
- Verify existence

## Scale Invariant
The operations in this pattern produce consistent gas cost *at any scale*.

## Example
```
pragma solidity 0.5.1;

import "./HitchensUnorderedKeySet.sol";

contract Widget {

    using HitchensUnorderedKeySetLib for HitchensUnorderedKeySetLib.Set;
    HitchensUnorderedKeySetLib.Set widgetSet;

    struct WidgetStruct {
        string name;
        bool delux;
        uint price;
    }

    mapping(bytes32 => WidgetStruct) widgets;

    event LogNewWidget(address sender, bytes32 key, string name, bool delux, uint price);
    event LogUpdateWidget(address sender, bytes32 key, string name, bool delux, uint price);    
    event LogRemWidget(address sender, bytes32 key);

    function newWidget(bytes32 key, string memory name, bool delux, uint price) public {
        widgetSet.insert(key); // Note that this will fail automatically if the key already exists.
        WidgetStruct storage w = widgets[key];
        w.name = name;
        w.delux = delux;
        w.price = price;
        emit LogNewWidget(msg.sender, key, name, delux, price);
    }

    function updateWidget(bytes32 key, string memory name, bool delux, uint price) public {
        require(widgetSet.exists(key), "Can't update a widget that doesn't exist.");
        WidgetStruct storage w = widgets[key];
        w.name = name;
        w.delux = delux;
        w.price = price;
        emit LogUpdateWidget(msg.sender, key, name, delux, price);
    }

    function remWidget(bytes32 key) public {
        widgetSet.remove(key); // Note that this will fail automatically if the key doesn't exist
        delete widgets[key];
        emit LogRemWidget(msg.sender, key);
    }

    function getWidget(bytes32 key) public view returns(string memory name, bool delux, uint price) {
        require(widgetSet.exists(key), "Can't get a widget that doesn't exist.");
        WidgetStruct storage w = widgets[key];
        return(w.name, w.delux, w.price);
    }

    function getWidgetCount() public view returns(uint count) {
        return widgetSet.count();
    }

    function getWidgetAtIndex(uint index) public view returns(bytes32 key) {
        return widgetSet.keyAtIndex(index);
    }
}
```

A production dapp would probably have access control for the state-changing functions. This is deliberately set aside for brevity and to show that the library is unopinionated about how that should work. For example, add `onlyOwner` modifiers to `newWidget()`, `updateWidget()` and `remWidget()` functions if appropriate.

## Compile contracts: `dapp --use solc:0.6.0 build`
## Test contracts: `dapp --use solc:0.6.0 test`

## Credit
[Rob Hitchens](https://github.com/rob-Hitchens/UnorderedKeySet)
