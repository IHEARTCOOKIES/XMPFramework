//
//  XMPFrameworkTests.m
//  XMPFrameworkTests
//
//  Created by Filip Busic on 08/07/2018.
//  Copyright (c) 2018 Filip Busic. All rights reserved.
//

@import XCTest;
@import XMPFramework;

#warning Add more tests
#warning Test out what happens if two readers are accessing the same file at the same time?

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

- (void)testXMPRead {
  //[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"targetImage" ofType:@"JPG"]];
  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"targetImage" withExtension:@"JPG"];
  XMPReader *reader = [[XMPReader alloc] initWithFilePath:pathToFile];
  [reader dumpXMPData];

  NSString *croppedArea = [reader stringForKey:kKey withPropertyName:kPropertyName]; // 2267
  XCTAssertGreaterThan(croppedArea.length, 0, @"Failed to get the string for it!");
  XCTAssert(reader.data, @"The data was nil.");

  
  // Writer
//  [writer setString:@"2001" forKey:kKey withProperty:[XMPProperty propertyWithNamespaceURI:kPropertyName namespacePrefix:@"GPano"]];
//  [writer synchronize];
//  croppedArea = [writer stringForKey:kKey withPropertyName:kPropertyName];
//  NSLog(@"Modified: %@", writer.filePath);
//  XCTAssert([croppedArea isEqualToString:@"2001"], @"Set failed");
}

//- (void)testBatchWrite {
//  NSURL *pathToFile = [[NSBundle mainBundle] URLForResource:@"input" withExtension:@"JPG"];
//  XMPBatchWriter *writer = [[XMPBatchWriter alloc] initWithFilePath:pathToFile];
//  [writer dumpXMPData];
//
//  [writer setDictionary:@{@"CroppedAreaImageHeightPixels":@"2211",
//                          @"CroppedAreaImageWidthPixels":@"4500",
//                          @"CroppedAreaLeftPixels":@"4500",
//                          @"CroppedAreaTopPixels":@"2212",
//                          @"FullPanoHeightPixels":@"6500",
//                          @"FullPanoWidthPixels":@"13202",
//                          @"ProjectionType":@"cylindrical"
//                          } forProperty:[XMPProperty propertyWithNamespaceURI:kPropertyName namespacePrefix:@"GPano"]];
//  [writer synchronize];
//
//  [writer dumpXMPData];
//}

@end

