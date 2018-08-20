//
//  XMPProperty.m
//  XMPFramework
//
//  Created by Filip Busic on 8/19/18.
//

#import "XMPProperty.h"
#import "XMPProperty+Private.h"

@implementation XMPProperty

#pragma mark - Constructors
+ (instancetype)propertyWithNamespaceURI:(NSString *)URI {
  return [[self alloc] initWithNamespaceURI:URI];
}
+ (instancetype)propertyWithNamespaceURI:(NSString *)URI namespacePrefix:(NSString *)prefix {
  return [[self alloc] initWithNamespaceURI:URI namespacePrefix:prefix];
}

#pragma mark - Initializers
- (instancetype)initWithNamespaceURI:(NSString *)URI {
  return [self initWithNamespaceURI:URI namespacePrefix:nil];
}
- (instancetype)initWithNamespaceURI:(NSString *)URI namespacePrefix:(NSString *)prefix {
  self = [super init];
  if (self) {
    self.URI = URI;
    self.prefix = prefix;
  }
  return self;
}

@end
