//
//  XMPFrameworkTests.m
//  XMPFrameworkTests
//
//  Created by Filip Busic on 08/07/2018.
//  Copyright (c) 2018 Filip Busic. All rights reserved.
//

@import XCTest;
@import XMPFramework;

@interface Tests : XCTestCase
@property (nonatomic, strong, readonly) NSURL *testImageURL;
@end

@implementation Tests

#pragma mark - Getters
- (NSURL *)testImageURL {
  return [[NSBundle mainBundle] URLForResource:@"targetImage" withExtension:@"JPG"];
}

#pragma mark - Initializers Tests
- (void)testXMPInitializers {
  self.continueAfterFailure = NO;

  // Initializers that should succeed
  NSURL *pathToFile = self.testImageURL;
  XCTAssert([[XMPReader alloc] initWithFilePath:pathToFile], @"Failed to init with `initWithFilePath:`.");
  XCTAssert([[XMPReader alloc] initWithData:[NSData dataWithContentsOfURL:pathToFile]], @"Failed to init with `initWithData:`.");
  
  // Initializers that should fail
  XCTAssert([[XMPReader alloc] initWithFilePath:[NSURL new]] == nil, @"Failed to init with `initWithFilePath:`.");
  XCTAssert([[XMPReader alloc] initWithData:[NSData data]] == nil, @"Failed to init with `initWithData:`.");

  self.continueAfterFailure = YES;
}

#pragma mark - XMPReader General Functionality Tests
- (void)testXMPReaderGeneralFunctionality {
  NSURL *pathToFile = self.testImageURL;
  NSData *fileData = [NSData dataWithContentsOfURL:pathToFile];
  XCTAssert([fileData isEqualToData:[[XMPReader alloc] initWithData:fileData].data], @"The `fileData` didn't match what we expected it to be.");
  XCTAssert([pathToFile isEqual:[[XMPReader alloc] initWithFilePath:pathToFile].filePath], @"The `pathToFile` didn't match what we expected it to be.");
}

#pragma mark - Read Tests
- (void)testXMPRead {
  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"targetImage" withExtension:@"JPG"];
  XMPReader *reader = [[XMPReader alloc] initWithFilePath:pathToFile];
  NSString *croppedArea = [reader stringForKey:@"CroppedAreaImageHeightPixels"
                                  withProperty:[XMPProperty propertyWithNamespaceURI:@"http://ns.google.com/photos/1.0/panorama/"]];
  
  // Read & validate
  XCTAssertGreaterThan(croppedArea.length, 0, @"Failed to read. The string was invalid.");
  XCTAssert(reader.data, @"Failed to read. The data was nil.");
}

#pragma mark - Write Tests
- (void)testXMPWrite {
  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"input" withExtension:@"JPG"];
  XMPWriter *writer = [[XMPWriter alloc] initWithFilePath:pathToFile];
  XMPProperty *property = [XMPProperty propertyWithNamespaceURI:@"http://ns.google.com/photos/1.0/panorama/" namespacePrefix:@"GPano"];
  
  // Write & synchronize
  XCTAssert([writer setString:@"2002" forKey:@"CroppedAreaImageHeightPixels" withProperty:property], @"Setting the string failed!");
  XCTAssert([writer synchronize], @"Failed to synchronize the changes.");
  
  // Read & validate
  NSString *string = [writer stringForKey:@"CroppedAreaImageHeightPixels" withProperty:property];
  XCTAssert([string isEqualToString:@"2002"], @"String wasn't equal!");
}

#pragma mark - Delete Tests
- (void)testXMPDelete {
  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"input" withExtension:@"JPG"];
  XMPWriter *writer = [[XMPWriter alloc] initWithFilePath:pathToFile];
  XMPProperty *property = [XMPProperty propertyWithNamespaceURI:@"http://ns.google.com/photos/1.0/panorama/" namespacePrefix:@"GPano"];
  
  // Write & synchronize
  XCTAssert([writer setString:@"SomeString" forKey:@"SomeKey"], @"Failed to set `SomeString` for `SomeKey`.");
  XCTAssert([writer setString:@"2002" forKey:@"CroppedAreaImageHeightPixels" withProperty:property], @"Setting the string failed!");
  XCTAssert([writer synchronize], @"Failed to synchronize the changes.");
  
  // Remove value for key
  XCTAssert([writer removeValueForKey:@"SomeKey"]);
  XCTAssert([writer removeValueForKey:@"CroppedAreaImageHeightPixels" withProperty:property], @"Failed to remove value for key.");
  XCTAssert([writer synchronize], @"Failed to synchronize the changes.");
}

#pragma mark - Batch Write Tests
- (void)testBatchWrite {
  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"input" withExtension:@"JPG"];
  XMPBatchWriter *writer = [[XMPBatchWriter alloc] initWithFilePath:pathToFile];
  XMPProperty *property = [XMPProperty propertyWithNamespaceURI:@"http://ns.google.com/photos/1.0/panorama/"
                                                namespacePrefix:@"GPano"];
  
  // Write & synchronize
  NSDictionary *XMPData = @{@"CroppedAreaImageHeightPixels":@"2211",
                            @"CroppedAreaImageWidthPixels":@"4500",
                            @"CroppedAreaLeftPixels":@"4500",
                            @"CroppedAreaTopPixels":@"2212",
                            @"FullPanoHeightPixels":@"6500",
                            @"FullPanoWidthPixels":@"13202",
                            @"ProjectionType":@"cylindrical"
                            };
  XCTAssert([writer setDictionary:XMPData], @"Failed to write the XMP data.");
  XCTAssert([writer setDictionary:XMPData forProperty:property], @"Failed to write the XMP data for <XMPProperty:%@>.", property);
  XCTAssert([writer synchronize], @"Failed to synchronize the changes.");
  
  // Read & validate
  [XMPData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    XCTAssert([[writer stringForKey:key] isEqualToString:obj],
              @"XMPReader's data didn't match with what we had in our XMPData dictionary.");
    XCTAssert([[writer stringForKey:key withProperty:property] isEqualToString:obj],
              @"XMPReader's data didn't match with what we had in our XMPData dictionary for <XMPProperty:%@>.", property);
  }];
}

#pragma mark - Value Type Tests
- (void)testValueTypes {
  BOOL someBOOL = YES;
  double someDouble = 123.45;
  NSInteger someInteger = 1500;
  NSString *someString = @"Test String";
  
  NSDictionary *valuesDict = @{@"SomeBOOL":@(someBOOL),
                               @"SomeDouble":@(someDouble),
                               @"SomeInteger":@(someInteger),
                               @"SomeString":someString
                               };
  
  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"input" withExtension:@"JPG"];
  XMPBatchWriter *writer = [[XMPBatchWriter alloc] initWithFilePath:pathToFile];
  XMPProperty *property = [XMPProperty propertyWithNamespaceURI:@"http://github.com/IHEARTCOOKIES/" namespacePrefix:@"EXAMPLE"];
  NSError *error = nil;
  
  // Write & synchronize
  XCTAssert([writer setDictionary:valuesDict forProperty:property error:&error], @"Failed to write the specified dictionary.");
  XCTAssertNil(error, @"Error: %@", error.localizedDescription);
  XCTAssert([writer synchronize], @"Failed to synchronize the changes.");
  
  // Checks that should succeed
  XCTAssertEqual([writer boolForKey:@"SomeBOOL" withProperty:property], someBOOL, @"`SomeBOOL` was not equal to: someBool.");
  XCTAssertEqual([writer doubleForKey:@"SomeDouble" withProperty:property], someDouble, @"`SomeDouble` was not equal to: someDouble");
  XCTAssertEqual([writer integerForKey:@"SomeInteger" withProperty:property], someInteger, @"`SomeInteger` was not equal to: someInteger");
  XCTAssert([[writer stringForKey:@"SomeString" withProperty:property] isEqualToString:someString], @"`SomeString` was not equal to: someString.");
  
  // Writes that should fail
  XCTAssert([writer setDictionary:@{@"SomeUnsupportedValue":[NSNull new]} forProperty:property error:&error] == NO, @"Writing a NSNull value succeeded.");
  XCTAssert(error, @"We got no errors from trying to write NSNull."); // Assert if we had no errors, which we should if we're trying to write "NSNull"
  XCTAssert(error.code == XMPFrameworkErrorCodeUnsupportedObjectType || error.code == XMPFrameworkErrorCodeUnsupportedPrimitiveType, @"Error: %@", error.localizedDescription); // Assert if the error was not an unsupported error
}

@end

