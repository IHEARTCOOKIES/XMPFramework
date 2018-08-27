//
//  XMPWriter+Private.h
//  XMPFramework
//
//  Created by Filip Busic on 8/26/18.
//

#import "XMPWriter.h"

NS_PROTOCOL_REQUIRES_EXPLICIT_IMPLEMENTATION
@protocol XMPWriterProtocol <NSObject>
@required
- (BOOL)setObject:(NSObject *)value forKey:(NSString *)key;
- (BOOL)setObject:(NSObject *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error;
- (BOOL)setObject:(NSObject *)value forKey:(NSString *)key withProperty:(XMPProperty *)property;
- (BOOL)setObject:(NSObject *)value forKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *__autoreleasing *)error;
@end

@interface XMPWriter () <XMPWriterProtocol>
@end
