//
//  XMPBatchWriter.m
//  XMPFramework
//
//  Created by Filip Busic on 8/19/18.
//

#import "XMPBatchWriter.h"
#import "XMPReader+Private.h"
#import "XMPWriter+Private.h"

@implementation XMPBatchWriter

#pragma mark - Public Methods
- (BOOL)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary {
  return [self setDictionary:dictionary error:nil];
}
- (BOOL)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary error:(NSError *__autoreleasing *)error {
  return [self setDictionary:dictionary forProperty:[XMPProperty propertyWithNamespaceURI:[NSString stringWithUTF8String:kXMP_NS_XMP]] error:error];
}
- (BOOL)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary forProperty:(XMPProperty *)property {
  return [self setDictionary:dictionary forProperty:property error:nil];
}
- (BOOL)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary forProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
  __block BOOL success = NO;
  __block NSError *outerError = nil;
  [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
    success = [self setObject:obj forKey:key withProperty:property error:&outerError];
    if (success == NO || (error && outerError)) { *stop = YES; }
  }];
  if (error) { *error = outerError; }
  return success;
}

@end
