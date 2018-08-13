//
//  XMPReader.h
//  XMPFramework
//
//  Created by Filip Busic on 8/7/18.
//

#import <Foundation/Foundation.h>

#warning Add documentation

NS_ASSUME_NONNULL_BEGIN
@interface XMPReader : NSObject

/** Unavailable initializer(s). */
- (instancetype)init __attribute__((unavailable("Please use one of the designated initializers.")));

/**
 <#Description#>
 
 @param filePath <#filePath description#>
 @return <#return value description#>
 */
- (instancetype)initWithFilePath:(NSURL *)filePath;

#warning Test
- (instancetype)initWithData:(NSData *)data;

- (nullable NSString *)stringForKey:(NSString *)key;
- (nullable NSString *)stringForKey:(NSString *)key withPropertyName:(NSString *)propertyName; // NS_XMP

#ifdef DEBUG
- (void)dumpXMPData;
#endif

/** A boolean for if the file is opened for editing or not. This property defaults to YES, as the file is automatically opened during initialization, however, if you were to close the stream, then you'd need to re-open the file by setting this property to YES. */
@property (nonatomic, assign, readwrite) BOOL fileOpen;

/** A NSData representation of the file that we're referencing. */
@property (nonnull, nonatomic, copy, readonly) NSData *data;

@end
NS_ASSUME_NONNULL_END
