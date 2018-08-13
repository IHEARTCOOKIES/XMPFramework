//
//  XMPWriter.h
//  XMPFramework
//
//  Created by Filip Busic on 8/11/18.
//

#import <XMPFramework/XMPReader.h>

#warning Add documentation

NS_ASSUME_NONNULL_BEGIN
@interface XMPWriter : XMPReader

- (void)setObject:(id)value forKey:(NSString *)key; //NS_XMP by default
- (void)setObject:(id)value forKey:(NSString *)key withPropertyName:(NSString *)propertyName; // NS_XMP

@end
NS_ASSUME_NONNULL_END
