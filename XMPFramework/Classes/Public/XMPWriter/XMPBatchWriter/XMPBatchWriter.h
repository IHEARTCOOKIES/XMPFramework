//
//  XMPBatchWriter.h
//  XMPFramework
//
//  Created by Filip Busic on 8/19/18.
//

#import <XMPFramework/XMPWriter.h>

NS_ASSUME_NONNULL_BEGIN
@interface XMPBatchWriter : XMPWriter

- (BOOL)setDictionary:(NSDictionary<NSString *, NSObject *> *)dictionary;
- (BOOL)setDictionary:(NSDictionary<NSString *, NSObject *> *)dictionary error:(NSError *_Nullable __autoreleasing *)error;
- (BOOL)setDictionary:(NSDictionary<NSString *, NSObject *> *)dictionary forProperty:(XMPProperty *)property;
- (BOOL)setDictionary:(NSDictionary<NSString *, NSObject *> *)dictionary forProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;

@end
NS_ASSUME_NONNULL_END
