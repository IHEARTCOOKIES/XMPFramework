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
+ (instancetype)propertyWithNamespacePrefix:(NSString *)prefix {
  return [[self alloc] initWithNamespacePrefix:prefix];
}
+ (instancetype)propertyWithNamespaceURI:(NSString *)URI namespacePrefix:(NSString *)prefix {
  return [[self alloc] initWithNamespaceURI:URI namespacePrefix:prefix];
}

#pragma mark - Getters
- (BOOL)isValid {
  return IS_VALID_NSSTRING(self.URI) || IS_VALID_NSSTRING(self.prefix);
}

#pragma mark - Initializers
- (instancetype)initWithNamespaceURI:(NSString *)URI {
  return [self initWithNamespaceURI:URI namespacePrefix:nil];
}
- (instancetype)initWithNamespacePrefix:(NSString *)prefix {
  return [self initWithNamespaceURI:nil namespacePrefix:prefix];
}
- (instancetype)initWithNamespaceURI:(NSString *)URI namespacePrefix:(NSString *)prefix {
  self = [super init];
  if (self) {
    self.URI = URI;
    self.prefix = prefix;
  }
  return self.isValid ? self : nil;
}

#pragma mark - NSCopying Protocol
- (id)copyWithZone:(NSZone *)zone {
  return [[XMPProperty alloc] initWithNamespaceURI:self.URI namespacePrefix:self.prefix];
}

@end
