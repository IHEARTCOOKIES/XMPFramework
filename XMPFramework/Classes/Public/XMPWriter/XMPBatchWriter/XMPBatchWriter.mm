//
//  XMPBatchWriter.m
//  XMPFramework
//
//  Created by Filip Busic on 8/19/18.
//

#import "XMPBatchWriter.h"
#import "XMPWriter+Private.h"

@implementation XMPBatchWriter

#pragma mark - Public Methods
- (BOOL)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary {
  __block BOOL success = NO;
  [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
    success = [self setObject:obj forKey:key];
    if (success == NO) { *stop = YES; }
  }];
  return success;
}
- (BOOL)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary error:(NSError *__autoreleasing *)error {
  __block BOOL success = NO;
  __block NSError *outerError = nil;
  [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
    success = [self setObject:obj forKey:key error:&outerError];
    if (success == NO || outerError != nil) { *stop = YES; }
  }];
  *error = outerError;
  return success;
}
- (BOOL)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary forProperty:(XMPProperty *)property {
  __block BOOL success = NO;
  [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
    success = [self setObject:obj forKey:key withProperty:property];
    if (success == NO) { *stop = YES; }
  }];
  return success;
}
- (BOOL)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary forProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error {
  __block BOOL success = NO;
  __block NSError *outerError = nil;
  [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
    success = [self setObject:obj forKey:key withProperty:property error:&outerError];
    if (success == NO || outerError != nil) { *stop = YES; }
  }];
  *error = outerError;
  return success;
}

@end
