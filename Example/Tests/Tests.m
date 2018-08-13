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
  
  NSString *croppedArea = [reader stringForKey:@"CroppedAreaImageHeightPixels" withPropertyName:@"http://ns.google.com/photos/1.0/panorama/"];
  XCTAssertGreaterThan(croppedArea.length, 0, @"Failed to get the string for it!");
}

@end

