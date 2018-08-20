//
//  XMPBatchWriter.h
//  XMPFramework
//
//  Created by Filip Busic on 8/19/18.
//

#import <XMPFramework/XMPWriter.h>

@interface XMPBatchWriter : XMPWriter

- (void)setDictionary:(NSDictionary<NSString *, NSObject *> *)dictionary;
- (void)setDictionary:(NSDictionary<NSString *, NSObject *> *)dictionary forProperty:(XMPProperty *)property;


@end
