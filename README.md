![logo][1]
__`XMPFramework` is a simple Objective-C wrapper on top of [Adobe XMP ToolKit][2] that allow for a native API similar to `NSUserDefaults` to read/write XMP data.__

[![CI Status](https://img.shields.io/travis/IHEARTCOOKIES/XMPFramework.svg?style=flat)](https://travis-ci.org/IHEARTCOOKIES/XMPFramework)
[![Version](https://img.shields.io/cocoapods/v/XMPFramework.svg?style=flat)](https://cocoapods.org/pods/XMPFramework)
[![License](https://img.shields.io/cocoapods/l/XMPFramework.svg?style=flat)](https://cocoapods.org/pods/XMPFramework)
[![Platform](https://img.shields.io/cocoapods/p/XMPFramework.svg?style=flat)](https://cocoapods.org/pods/XMPFramework)

## Installation
The quickest way to get up and running would be through the use of cocoapods. Simply add the following line to your Podfile:
```ruby
pod 'XMPFramework'
```

## Usage

### Reading XMP Data

To read XMP data, simply instantiate an instance of `XMPReader` with the path to the file in mind. You should feel right at home with XMPFramework since most of the APIs are very similar to [NSUserDefaults][4] class.
```objective-c
XMPReader *reader = [[XMPReader alloc] initWithFilePath:pathToFile];
NSString *output = [reader stringForKey:@"SomeXMPMetadataKey"];
```

### Writing XMP Data

You have two choices in writing XMP data. You could either instantiate a `XMPWriter` instance and write data using the traditional `set:` APIs.
```objective-c
XMPWriter *writer = [[XMPWriter alloc] initWithFilePath:pathToFile];
BOOL writeSuccessful = [writer setString:@"SomeString" forKey:@"SomeKey"];
BOOL syncSuccessful = [writer synchronize]; // synchronizes the changes
```

To write multiple bits of data, it's preferred to do this using a `XMPBatchWriter` instance.
```objective-c
XMPBatchWriter *writer = [[XMPBatchWriter alloc] initWithFilePath:pathToFile];
[writer setDictionary:@{
   @"SomeKeyA":@"SomeStringA",
   @"SomeKeyB":@"SomeStringB"
}];
BOOL syncSuccessful = [writer synchronize]; // synchronizes the changes
```

For more concrete examples of writing XMP data (using properties, namespace URI, etc.), see the `Tests.m` file located in the [Tests directory][3].

## Requirements

Runs on iOS 8.0+, 64 bit and above. 32 bit is not supported by [Adobe XMP ToolKit][2].

## Who created it?

XMPFramework was authored by Filip Busic (the guy who likes cookies). Feel free to shoot a message to the author via [Twitter][5] if you have any questions or ideas on how to make XMPFramework better.

## License

XMPFramework is available under the MIT license. The underlying component, [Adobe XMP ToolKit][2], that makes this framework possible runs on BSD. See the LICENSE file for more info.

[1]: https://i.imgur.com/uWunVdE.png
[2]: https://github.com/IHEARTCOOKIES/Adobe-XMP-ToolKit
[3]: https://github.com/IHEARTCOOKIES/XMPFramework/blob/master/Example/Tests/Tests.m
[4]: https://developer.apple.com/documentation/foundation/nsuserdefaults
[5]: https://twitter.com/__unused
