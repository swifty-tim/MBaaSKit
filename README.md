# MBaaSKit

[![CI Status](http://img.shields.io/travis/collegboi/MBaaSKit.svg?style=flat)](https://travis-ci.org/collegboi/MBaaSKit)
[![Version](https://img.shields.io/cocoapods/v/MBaaSKit.svg?style=flat)](http://cocoapods.org/pods/MBaaSKit)
[![License](https://img.shields.io/cocoapods/l/MBaaSKit.svg?style=flat)](http://cocoapods.org/pods/MBaaSKit)
[![Platform](https://img.shields.io/cocoapods/p/MBaaSKit.svg?style=flat)](http://cocoapods.org/pods/MBaaSKit)

## Description

Framework to provide communication to MBaaSKit Server. Provides 
functionality to send and retrieve objects from server. 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Swift 3

## Installation

MBaaSKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MBaaSKit"
```

## Usage

```swift

struct TestObject: TBJSONSerializable {

    var name: String!

    init() {
    }

    init(name:String) {
        self.name = name
    }
    init( jsonObject : TBJSON) {
        self.name = jsonObject.tryConvert("name")
    }
}


var result = [TestObject]()
result.getAllInBackground(ofType:TestObject.self) { (succeeded: Bool, data: [TestObject]) -> () in

    DispatchQueue.main.async {
        if (succeeded) {
            result = data
            print("success")
        } else {
            print("error")
        }
    }
}

let testObject = TestObject(name: "timothy")

testObject.sendInBackground("objectID"){ (succeeded: Bool, data: NSData) -> () in

    DispatchQueue.main.async {
        if (succeeded) {
            print("scucess")
        } else {
            print("error")
        }
    }
}

```


## Author

collegboi, timothy.barnard@mydit.ie

## License

MBaaSKit is available under the MIT license. See the LICENSE file for more info.
