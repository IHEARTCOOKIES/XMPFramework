//
//  XMPBatchWriter.m
//  XMPFramework
//
//  Created by Filip Busic on 8/19/18.
//

#import "XMPBatchWriter.h"

@implementation XMPBatchWriter

#pragma mark - Public Methods
- (void)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary {
  [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
    [self setString:obj forKey:key];
  }];
}
- (void)setDictionary:(NSDictionary<NSString *,NSObject *> *)dictionary forProperty:(XMPProperty *)property {
  [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
    [self setString:obj forKey:key withProperty:property];
  }];
}

@end
