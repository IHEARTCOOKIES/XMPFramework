//
//  XMPWriter.h
//  XMPFramework
//
//  Created by Filip Busic on 8/11/18.
//

#import <XMPFramework/XMPReader.h>
#import <XMPFramework/XMPProperty.h>

#warning Add documentation

NS_ASSUME_NONNULL_BEGIN
@interface XMPWriter : XMPReader

- (void)setString:(NSString *)string forKey:(NSString *)key;
- (void)setString:(NSString *)string forKey:(NSString *)key withProperty:(XMPProperty *)property;

- (BOOL)synchronize;


#warning do we need this one?
/** A boolean for if the file is opened for editing or not. This property defaults to YES, as the file is automatically opened during initialization, however, if you were to close the stream, then you'd need to re-open the file by setting this property to YES. */
@property (nonatomic, assign, readonly) BOOL fileOpen;


@end
NS_ASSUME_NONNULL_END
