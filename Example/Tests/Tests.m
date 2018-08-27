//
//  XMPFrameworkTests.m
//  XMPFrameworkTests
//
//  Created by Filip Busic on 08/07/2018.
//  Copyright (c) 2018 Filip Busic. All rights reserved.
//

@import XCTest;
@import XMPFramework;

#warning TODO:
#warning Add more tests
#warning Test thread safety
#warning Work on the exception descriptions

static NSString *const kPropertyName = @"http://ns.google.com/photos/1.0/panorama/";
static NSString *const kKey = @"CroppedAreaImageHeightPixels";

@interface Tests : XCTestCase
@end

@implementation Tests

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

//- (void)testXMPRead {
//  //[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"targetImage" ofType:@"JPG"]];
//  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"targetImage" withExtension:@"JPG"];
//  XMPReader *reader = [[XMPReader alloc] initWithFilePath:pathToFile];
//  [reader dumpXMPData];
//
//  NSString *croppedArea = [reader stringForKey:kKey withPropertyName:kPropertyName]; // 2267
//  XCTAssertGreaterThan(croppedArea.length, 0, @"Failed to get the string for it!");
//  XCTAssert(reader.data, @"The data was nil.");
//
//
////  // Writer
////  [writer setString:@"2002" forKey:kKey];
////  [writer synchronize];
//
//  // Custom Writer
////  [writer setString:@"2001" forKey:kKey withProperty:[XMPProperty propertyWithNamespaceURI:kPropertyName namespacePrefix:@"GPano"]];
////  [writer synchronize];
////  croppedArea = [writer stringForKey:kKey withPropertyName:kPropertyName];
////  NSLog(@"Modified: %@", writer.filePath);
////  XCTAssert([croppedArea isEqualToString:@"2001"], @"Set failed");
//}
//- (void)testXMPWrite {
//  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"input" withExtension:@"JPG"];
//  XMPWriter *writer = [[XMPWriter alloc] initWithFilePath:pathToFile];
//  [writer dumpXMPData];
//  
//  // Writer
//  XCTAssert([writer setString:@"2002" forKey:kKey withProperty:[XMPProperty propertyWithNamespaceURI:kPropertyName namespacePrefix:@"GPano"]], @"Setting the string failed!");
//  XCTAssert([writer synchronize], @"Failed to synchronize the changes.");
//  
//  NSString *string = [writer stringForKey:kKey withPropertyName:kPropertyName];
//  // Read & validate
//  XCTAssert([string isEqualToString:@"2002"], @"String wasn't equal!");
//  [writer dumpXMPData];
//}
//
//- (void)testBatchWrite {
//  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"input" withExtension:@"JPG"];
//  XMPBatchWriter *writer = [[XMPBatchWriter alloc] initWithFilePath:pathToFile];
//  [writer dumpXMPData];
//
//  XCTAssert(([writer setDictionary:@{@"CroppedAreaImageHeightPixels":@"2211",
//                                     @"CroppedAreaImageWidthPixels":@"4500",
//                                     @"CroppedAreaLeftPixels":@"4500",
//                                     @"CroppedAreaTopPixels":@"2212",
//                                     @"FullPanoHeightPixels":@"6500",
//                                     @"FullPanoWidthPixels":@"13202",
//                                     @"ProjectionType":@"cylindrical"
//                                     } forProperty:[XMPProperty propertyWithNamespaceURI:kPropertyName namespacePrefix:@"GPano"]]), @"Failed to write the specified dictionary.");
//  
//  XCTAssert([writer synchronize], @"Failed to synchronize the changes.");
//
//  [writer dumpXMPData];
//}

- (void)testValueWrites {
  NSString *namespaceURI = @"http://github.com/IHEARTCOOKIES/";
  NSString *namespacePrefix = @"EXAMPLE";
  XMPProperty *property = [XMPProperty propertyWithNamespaceURI:namespaceURI namespacePrefix:namespacePrefix];
  
  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"input" withExtension:@"JPG"];
  XMPBatchWriter *writer = [[XMPBatchWriter alloc] initWithFilePath:pathToFile];
  [writer dumpXMPData];
  
  BOOL someBOOL = YES;
  double someDouble = 123.45;
  NSInteger someInteger = 1500;
  NSString *someString = @"Test String";
  
  NSDictionary *dictionary = @{@"SomeBOOL":@(someBOOL),
                               @"SomeDouble":@(someDouble),
                               @"SomeInteger":@(someInteger),
                               @"SomeString":someString
                               };
  
  NSError *error = nil;
  XCTAssert([writer setDictionary:dictionary forProperty:property error:&error],
            @"Failed to write the specified dictionary.");
  XCTAssertNil(error, @"Error: %@", error.localizedDescription);
  
  XCTAssert([writer synchronize], @"Failed to synchronize the changes.");
  
  XCTAssertEqual([writer boolForKey:@"SomeBOOL" withProperty:property], someBOOL, @"`SomeBOOL` was not equal to: someBool.");
  XCTAssertEqual([writer doubleForKey:@"SomeDouble" withProperty:property], someDouble, @"`SomeDouble` was not equal to: someDouble");
  XCTAssertEqual([writer integerForKey:@"SomeInteger" withProperty:property], someInteger, @"`SomeInteger` was not equal to: someInteger");
  XCTAssert([[writer stringForKey:@"SomeString" withProperty:property] isEqualToString:someString], @"`SomeString` was not equal to: someString.");
  
  XCTAssert(([writer setDictionary:@{@"SomeUnsupportedValue":[NSNull new]} forProperty:property error:&error]) == NO, @"Writing a NSNull value succeeded.");
  XCTAssert(error, @"We got no errors from trying to write NSNull."); // Assert if we had no errors, which we should if we're trying to write "NSNull"
  XCTAssert(error.code == 415 || error.code == 416, @"Error: %@", error.localizedDescription); // Assert if the error was not an unsupported error
  
  [writer dumpXMPData];
}

@end

