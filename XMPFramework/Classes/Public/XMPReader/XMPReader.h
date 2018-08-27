//
//  XMPReader.h
//  XMPFramework
//
//  Created by Filip Busic on 8/7/18.
//

#import <Foundation/Foundation.h>
#import <XMPFramework/XMPProperty.h>

#warning Don't forget to add a prefix header file and macro for NSLog
#warning if we're inheriting the name NSLog in the macro, make sure that it doesn't come up in the end-client application (i.e, XMPFramework-Example.app)

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

#pragma mark - Get Value For Key Methods

- (BOOL)boolForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (nullable NSString *)stringForKey:(NSString *)key;

#pragma mark - Get Value For Key w/ Error Methods

- (BOOL)boolForKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;
- (double)doubleForKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;
- (NSInteger)integerForKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;
- (nullable NSString *)stringForKey:(NSString *)key error:(NSError *_Nullable __autoreleasing *)error;

#pragma mark - Get Value For Key w/ XMPProperty Methods

- (BOOL)boolForKey:(NSString *)key withProperty:(XMPProperty *)property;
- (double)doubleForKey:(NSString *)key withProperty:(XMPProperty *)property;
- (NSInteger)integerForKey:(NSString *)key withProperty:(XMPProperty *)property;
- (nullable NSString *)stringForKey:(NSString *)key withProperty:(XMPProperty *)property;

#pragma mark - Get Value For Key w/ XMPProperty & Error Methods

- (BOOL)boolForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;
- (double)doubleForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;
- (NSInteger)integerForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;
- (nullable NSString *)stringForKey:(NSString *)key withProperty:(XMPProperty *)property error:(NSError *_Nullable __autoreleasing *)error;

#ifdef DEBUG
- (void)dumpXMPData;
#endif

/** A NSData representation of the file that we're referencing. */
@property (nonnull, nonatomic, copy, readonly) NSData *data;

/** A reference to the file that we initialized with. If the `initWithData:` initializer was used, this will point to a temporary file. */
@property (nonnull, nonatomic, strong, readonly) NSURL *filePath;

@end
NS_ASSUME_NONNULL_END
